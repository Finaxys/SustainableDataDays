WITH OB_HOLDING AS (
    SELECT
      a.NAME as agentname, 
      LEFT(a.OBNAME, 12) as orderbook, 
      a.INVESTS * a.LASTFIXEDPRICE as ob_holding
    FROM {{ref('BRONZE_TABLE_AGENT')}} a
    QUALIFY ROW_NUMBER() OVER (PARTITION BY agentname, orderbook ORDER BY  a.TIMESTAMP desc) = 1)
, HOLDING AS (
    SELECT AGENTNAME, 
        sum(ob_holding) as holding
    FROM OB_HOLDING GROUP BY AGENTNAME
), HOLDING_RATIO AS (
    SELECT 
        obh.AGENTNAME,
        obh.orderbook, 
        DIV0(obh.ob_holding,h.holding) as holding_ratio, 
        h.holding as holding, 
        obh.ob_holding 
    FROM OB_HOLDING obh, HOLDING H
    WHERE obh.agentname = h.agentname
)
SELECT * FROM HOLDING_RATIO ORDER BY holding desc