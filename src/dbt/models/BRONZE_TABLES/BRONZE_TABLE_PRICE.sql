SELECT
    $1:timestamp::varchar::TIMESTAMP TIMESTAMP,
    $1:obName::STRING OBNAME,
    $1:price::NUMBER PRICE,
    $1:quantity::NUMBER QUANTITY,
    $1:extId1::STRING EXTID1,
    $1:extId2::STRING EXTID2,
    $1:bestAskPrice::NUMBER BESTASKPRICE,
    $1:bestBidPrice::NUMBER BESTBIDPRICE
FROM
    {{ source('TRADE_DB', 'RAW') }}
WHERE
    $1:type = 'Price'