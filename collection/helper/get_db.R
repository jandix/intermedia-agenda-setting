## Install system libraries for RMySQL
## sudo apt-get install -y libmariadb-client-lgpl-dev

# load packages
library(magrittr)

### Get n Tweets from DB
get_tweets <- function () {
  # connect to database
  con <- RMySQL::dbConnect(RMySQL::MySQL(), group = "twitter")
  # close db connection after function call exits
  on.exit(RMySQL::dbDisconnect(con))
  # fix encoding issues
  res <- RMySQL::dbSendQuery(con, 'set character set "utf8"')
  # get n tweets
  query <- "SELECT * FROM Bundestag19_tweets ORDER BY created_at"
  res <- DBI::dbGetQuery(con, query)
  # return tweets
  res
}

### Get mdbs from database
get_mdbs <- function () {
  # connect to database
  con <- RMySQL::dbConnect(RMySQL::MySQL(), group = "josef")
  # close db connection after function call exits
  on.exit(RMySQL::dbDisconnect(con))
  # fix encoding issues
  res <- RMySQL::dbSendQuery(con, 'set character set "utf8"')
  # get n tweets
  query <- "SELECT * FROM Alias_BT19 ORDER BY created_at"
  res <- DBI::dbGetQuery(con, query)
  # return tweets
  res
}

### Count Tweets
count_tweets <- function () {
  # connect to database
  con <- RMySQL::dbConnect(RMySQL::MySQL(), group = "twitter")
  # get n tweets
  res <- RMySQL::dbSendQuery(con, "SELECT COUNT(1) FROM Bundestag19_tweets")
  # get result
  n <- RMySQL::dbFetch(res)
  n <- n[1, 1]
  # clear connection
  RMySQL::dbClearResult(res)
  # return tweets
  n
}

### Get categories
get_categories <- function () {
  # connect to database
  con <- RMySQL::dbConnect(RMySQL::MySQL(), group = "twitter")
  # close db connection after function call exits
  on.exit(RMySQL::dbDisconnect(con))
  # fix encoding issues
  res <- RMySQL::dbSendQuery(con, 'set character set "utf8"')
  # get n tweets
  query <- sprintf("SELECT * FROM Bundestag19_categories")
  res <- DBI::dbGetQuery(con, query)
  # return tweets
  res
}