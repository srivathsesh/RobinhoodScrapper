getAnalystRating <- function(ticker,link = 'https://robinhood.com/stocks/') {
  
  #------------------------
  #    Library calls
  #------------------------
  
  library(tidyverse)
  library(magrittr)
  library(rvest)
  
  #    Create url
  
  url <- paste0('https://robinhood.com/stocks/', ticker)
  
  # read webpage
  
  webpage <- read_html(url,encoding = "UTC-8",options = "RECOVER")
  
  # read Analyst ratings of stock
  
  webpage %>% 
    html_nodes('span._1WW-0CEc7nCIXcX_BxxJeH') %>% 
    html_text() %>% 
    str_remove("%") %>% 
    as.numeric()-> BuyHoldSellRating
  
  # return tibble
  
  tibble(ticker = ticker,
         buy = BuyHoldSellRating[1],
         hold = BuyHoldSellRating[2],
         sell = BuyHoldSellRating[3])
  
  
  
}