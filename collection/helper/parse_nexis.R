library(magrittr) # pipe operator

parse_nexis <- function (csv, 
                         column_name, 
                         remove_publication = NULL) {
  # load csv
  articles <- readr::read_csv(csv)
  
  # remove unused columns and rename columns
  articles <- articles %>%
    dplyr::select(date = DATE, headline = HEADLINE, publication = PUBLICATION)
  
  # remove unwanted publications
  if (!is.null(remove_publication)) {
    articles <- articles %>% 
      dplyr::select(stringr::str_detect(publication, remove_publication))
  }
  
  # remove duplicates
  articles <- articles %>% 
    dplyr::distinct(date, headline, .keep_all = T)
  
  # parse date
  articles$date_parsed <- articles$date %>% 
    stringr::str_replace(pattern = "^[:alpha:]+", "") %>%
    stringr::str_replace(pattern = ".\\sMai\\s", "-05-") %>%   
    stringr::str_replace(pattern = ".\\sApril\\s", "-04-") %>% 
    stringr::str_replace(pattern = ".\\sMärz\\s", "-03-") %>% 
    as.Date(format = "%d-%m-%Y")
  
  # add immigration to main df
  articles <- articles %>% 
    dplyr::group_by(date_parsed) %>%
    dplyr::summarise(n = n()) 
  
  # change column name
  colnames(articles)[2] <- column_name
  
  # return article data frame
  articles
}