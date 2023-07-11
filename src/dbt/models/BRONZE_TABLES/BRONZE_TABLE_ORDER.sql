SELECT
    $1:timestamp::varchar::TIMESTAMP TIMESTAMP,
    $1:obName::STRING OBNAME,
    $1:orderType::STRING ORDERTYPE,
    $1:sender::STRING SENDER,
    $1:extId::STRING EXTID,
    $1:quantity::NUMBER QUANTITY,
    $1:direction::STRING DIRECTION,
    $1:price::NUMBER PRICE,
    $1:validity::NUMBER VALIDITY
FROM
    {{ source('TRADE_DB', 'RAW') }}
WHERE
    $1:type = 'Order'