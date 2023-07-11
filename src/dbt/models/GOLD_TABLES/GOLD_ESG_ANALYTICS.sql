 WITH OB_ESG_SCORE AS (
    SELECT AGENTNAME, ORDERBOOK,
    holding_ratio,
    holding,
    ob_holding,
    (holding_ratio * esg.esg) as esg_ratio,
     (holding_ratio * esg.e) as e_ratio,
     (holding_ratio * esg.s) as s_ratio,
      (holding_ratio * esg.g) as g_ratio
    FROM {{ref('SILVER_HOLDING_RATIO')}} hr
    LEFT OUTER JOIN {{ref('BRONZE_TABLE_ESG')}} esg on orderbook = esg.isin
), ESG_RATING AS (
    SELECT
        AGENTNAME,
        max(holding) as holding
        -- ADD ESG RATINGS --
    FROM OB_ESG_SCORE
    GROUP BY AGENTNAME
)
SELECT * FROM ESG_RATING ORDER BY holding desc