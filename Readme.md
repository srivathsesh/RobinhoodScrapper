# Scrape Robinhood webpage

The below R code serves as an example to scrape Analysts' buy, hold and sell ratings from www.robinhood.com


```

library(dplyr)
library(purrr)
library(magrittr)

source('getAnalystRating.R')

df <- tibble(ticker =  c("AMZN",
             "APPL",
             "TSLA",
             "BABA",
             "JD",
             "PYPL",
             "CSCO"),
       company = c("AMAZON",
                   "APPLE",
                   "TESLA",
                   "ALIBABA",
                   "JD",
                   "PAYPAL",
                   "CISCO")
       
)

```


```
AnalystScores <- lapply(df$ticker,getAnalystRating) %>% 
  reduce(rbind)
```

  
Notice I use lappy instead of purrr::map_df. When I attempted to use map_df as below:

```
df %>% 
select(ticker) %>%
map_df(function(x) getAnalystRating(x))

```



I ran into the following error:

```diff
- Error in doc_parse_file(con, encoding = encoding, as_html = as_html, options = options) : Expecting a single string value: [type=character; extent=7].
```


```
df %>% 
  left_join(AnalystScores)
```

```
Joining, by = "ticker"
# A tibble: 7 x 5
  ticker company   buy  hold  sell
  <chr>  <chr>   <dbl> <dbl> <dbl>
1 AMZN   AMAZON     92     6     2
2 APPL   APPLE      NA    NA    NA
3 TSLA   TESLA      27    42    30
4 BABA   ALIBABA   100     0     0
5 JD     JD         89    11     0
6 PYPL   PAYPAL     83    14     2
7 CSCO   CISCO      48    52     0
```

