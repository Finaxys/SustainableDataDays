WITH OB_HOLDING AS (
    SELECT
        timestamp,
        a.NAME as agentname,
        LEFT(a.OBNAME, 12) as orderbook,
        a.invests,
        a.LASTFIXEDPRICE,
        a.INVESTS * a.LASTFIXEDPRICE as ob_holding
    FROM {{ref('BRONZE_TABLE_AGENT')}} a
    QUALIFY ROW_NUMBER() OVER (PARTITION BY agentname, orderbook ORDER BY  a.TIMESTAMP desc) = 1)
, HOLDING AS (
    SELECT AGENTNAME,
        sum(ob_holding) as holding
    FROM OB_HOLDING GROUP BY AGENTNAME
), HOLDING_RATIO AS (
    SELECT
        timestamp,
        obh.AGENTNAME,
        obh.orderbook,
        DIV0(obh.ob_holding,h.holding) as holding_ratio,
        h.holding as holding,
        invests,
        LASTFIXEDPRICE,
        obh.ob_holding
    FROM OB_HOLDING obh, HOLDING H
    WHERE obh.agentname = h.agentname
), OB_ESG_SCORE AS (
    SELECT
        timestamp,
        agentname,
        orderbook,
        c.name as instrument_name,
        c.country,
        c.sector_longname,
        c.subsector_longname,
        c.industry_longname,
        holding_ratio,
        holding,
        ob_holding,
        invests,
        lastfixedprice,
        esg.esg,
        esg.e,
        esg.s,
        esg.g,
        (holding_ratio * esg.esg) as esg_ratio,
        (holding_ratio * esg.e) as e_ratio,
        (holding_ratio * esg.s) as s_ratio,
        (holding_ratio * esg.g) as g_ratio
    FROM HOLDING_RATIO hr
    INNER JOIN {{ref('BRONZE_TABLE_CLASSIFICATION')}} c on c.isin = hr.orderbook
    LEFT OUTER JOIN {{ref('BRONZE_TABLE_ESG')}} esg on  esg.isin = hr.orderbook
)
SELECT * FROM OB_ESG_SCORE ORDER BY holding desc