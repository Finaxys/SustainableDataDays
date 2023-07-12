from snowflake.snowpark import Session
import streamlit as st
import matplotlib.pyplot as plt
import pandas as pd


def create_snowpark_session():
    return Session.builder.configs(st.secrets["snowpark"]).create()


session = create_snowpark_session()
silver_price = session.table("SILVER_PRICE_ANALYTICS").to_pandas()


def get_x_y_entity(val):
    entity_df = silver_price[silver_price.NAME == val].filter(['TIMESTAMP', 'PRICE'])

    entity_df.TIMESTAMP = pd.to_datetime(entity_df.TIMESTAMP / 1000, unit='ms').astype('datetime64[ms]')

    entity_df = entity_df.groupby('TIMESTAMP', as_index=False, sort=False).PRICE.mean()

    entity_df = entity_df.sort_values('TIMESTAMP')

    entity_df.TIMESTAMP = entity_df.TIMESTAMP.dt.floor('30T').ffill()
    entity_df = entity_df.groupby('TIMESTAMP').PRICE.mean()

    entity_df = entity_df.between_time('07:00:00', '15:00:00')

    ts_df = entity_df.index

    entity_df = entity_df.reset_index()
    entity_df.TIMESTAMP = entity_df.TIMESTAMP.astype(str)
    entity_df = entity_df.set_index('TIMESTAMP')

    return entity_df, ts_df


entity = 'AXA'
final_df, ts = get_x_y_entity(entity)
axes = plt.gca()
axes.xaxis.set_ticks(range(0, len(ts.tolist()), 10))
plt.xticks(rotation=45, ha='right')
plt.plot(final_df)
plt.title('Price evolution')
plt.xlabel('TIMESTAMP')
plt.ylabel('PRICE')
st.pyplot(plt)
