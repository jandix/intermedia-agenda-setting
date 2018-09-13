# load packages
library("dplyr")

get_faz_archive <- function (q,
                             limit = 200,
                             offset = 0,
                             date = NULL) {
  
  # define base url
  base_url <- "https://fazarchiv.faz.net/fazSearch/index/searchForm"
  
  # define query
  query <- list(
    q = q,
    search_in = "",
    timeFilter = "",
    timePeriod = "dateFilter",
    DT_from = date,
    DT_to = date,
    `KO%2CSO` = "",
    crxdefs = "",
    NN = "",
    `CO%2C1E` = "",
    CN = "",
    BC = "",
    submitSearch = "Suchen",
    maxHits = limit,
    sorting = "", 
    toggleFilter = "",
    dosearch = "new"
  )
  
  # build url
  url <- httr::parse_url(base_url)
  url$query <- query
  url$fragment <- "hitlist"
  url <- httr::build_url(url)
  
  # GET page
  result <- httr::GET(url)
  html <- xml2::read_html(url)
  
  # parse table
  nodes <- html %>% 
    rvest::html_nodes(".module13 .clearfix")
  
  if (length(nodes) <= 0) {
    return(NA)
  }
  
  # parse titles
  title <- nodes %>% 
    rvest::html_nodes("h3 a") %>% 
    rvest::html_text()
  
  # parse source
  source <- nodes %>% 
    rvest::html_nodes("ul") %>% 
    rvest::html_text()
  
  # create dummies
  source <- ifelse(stringr::str_detect(source, "FAZ.NET"), T, F)
  
  # parse date
  date <- as.Date(date, "%d.%m.%Y")
  
  # return data frame containg the results
  data.frame(title = title,
             dates = date,
             source = source,
             stringsAsFactors = F)
}

loop_faz_archive <- function (query,
                              df_online,
                              df_offline,
                              column_name) {
  
  # define new columns
  df_online[ , column_name] <- 0
  df_offline[ , column_name] <- 0
  
  # setup progressbar
  pb <- txtProgressBar(min = 0, max = nrow(df_online), style = 3)
  
  # get and count articles 
  for (i in 1:nrow(df_online)) {
    
    # extract date
    date <- format(df_online$date[i], "%d.%m.%Y")
    
    # query archive
    articles <- get_faz_archive(q = query,
                                date = date)
    
    if (is.na(articles)) {
      next
    }
    
    df_online[i, column_name] <- articles %>% 
      filter(source) %>% 
      nrow()
    df_offline[i, column_name] <- articles %>% 
      filter(!source) %>% 
      nrow()
    # update progressbar
    setTxtProgressBar(pb, i)
  }
  
  # return complete data frames
  list(
    online = df_online,
    offline = df_offline
  )
}