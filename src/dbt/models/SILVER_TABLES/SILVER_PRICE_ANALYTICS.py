

def model(dbt, session): 

    classification_df = dbt.ref("BRONZE_TABLE_CLASSIFICATION")
    
    price_df = dbt.ref("BRONZE_TABLE_PRICE")

    #Transform to Pandas
    price_df = price_df.to_pandas()

    #Lambda function to cumpute volume
    f = lambda x : x['PRICE'] * x['QUANTITY']

    #use apply fucntion to parse the df
    price_df['VOLUME'] = price_df.apply(f, axis=1)
    #reorder the columns in the df
    vol = price_df.pop('VOLUME')
    price_df.insert(4, 'VOLUME', vol)
    #convert the pandas df to snowpark df
    price_df = session.create_dataframe(price_df)
    #join the two dfs 'ESG_df' and 'price_df'
    dataframe = classification_df.join(price_df, classification_df['ISIN']==price_df['OBNAME'])

    return dataframe