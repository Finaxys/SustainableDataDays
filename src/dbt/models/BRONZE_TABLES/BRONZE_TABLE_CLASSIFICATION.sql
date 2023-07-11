SELECT 
    iu.INSTRUMENT_FULL_NAME as name, 
    iu.isin, iu.lei, 
    country, sector, sector_longname, subsector, subsector_longname, industry, industry_longname,
    ESG, E, S, G
FROM 
    SUSTAINABLE_FINANCE.PUBLIC.INVESTMENT_UNIVERSE iu
    LEFT OUTER JOIN ESG_PROVIDER.PUBLIC.ESG_DATA esg on iu.isin = esg.isin AND esg.date = '2018-09-30' 
where 1 = 1
    --AND esg.ISIN like 'FR%'
ORDER BY
    SECTOR,
    SUBSECTOR,
    ESG desc,
    E desc,
    S desc,
    G desc