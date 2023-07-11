SELECT
    $1:timestamp::varchar::TIMESTAMP TIMESTAMP,
    $1:nbDays::NUMBER NBDAYS,
    $1:obName::STRING OBNAME,
    $1:numberOfOrdersReceived::NUMBER NUMBEROFORDERSRECEIVED,
    $1:numberOfPricesFixed::NUMBER NUMBEROFPRICESFIXED,
    $1:firstPriceOfDay::NUMBER FIRSTPRICEOFDAY,
    $1:lastPriceOfDay::NUMBER LASTPRICEOFDAY,
    $1:highestPriceOfDay::NUMBER HIGHESTPRICEOFDAY,
    $1:lowestPriceOfDay::NUMBER LOWESTPRICEOFDAY
FROM
    {{ source('TRADE_DB', 'RAW') }}
WHERE
    $1:type = 'Day'