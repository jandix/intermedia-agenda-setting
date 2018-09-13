# load packages
library(kableExtra)

# load data
bild_online <- readRDS("./data/ts/bild_online_ts.rds")
bild_offline <- readRDS("./data/ts/bild_offline_ts.rds")
faz_online <- readRDS("./data/ts/faz_online_ts.rds")
faz_offline <- readRDS("./data/ts/faz_offline_ts.rds")
welt_online <- readRDS("./data/ts/welt_online_ts.rds")
welt_offline <- readRDS("./data/ts/welt_offline_ts.rds")
tweets_wo_afd <- readRDS("./data/ts/tweets_wo_afd_ts.rds")
tweets_afd <- readRDS("./data/ts/tweets_afd_ts.rds")

# define function to compare
create_table <- function (tweets,
                          tweets_afd,
                          newspapers,
                          topic) {
  
  # define empty data frame
  results <- data.frame(newspaper = character(),
                        lag = character(),
                        ccf_twitter = character(),
                        ccf_afd = character(),
                        stringsAsFactors = F)
  
  for (i in 1:length(newspapers)) {
    correlation <- ccf(newspapers[[i]][ , topic], tweets[ , topic], plot = F, lag.max = 3)
    correlation_afd <- ccf(newspapers[[i]][ , topic], tweets_afd[ , topic], plot = F, lag.max = 3)
    
    for (j in 1:nrow(correlation$acf)) {
      
      row <- data.frame(newspaper = names(newspapers[i]),
                        lag = correlation$lag[j],
                        ccf_twitter = round(correlation$acf[j], 2),
                        ccf_afd = round(correlation_afd$acf[j], 2),
                        stringsAsFactors = F)
      
      if (correlation$acf[j] > qnorm((1 + 0.95)/2)/sqrt(correlation$n.used) | 
          correlation$acf[j] < -qnorm((1 + 0.95)/2)/sqrt(correlation$n.used)) {
        row$ccf_twitter <- paste(round(correlation$acf[j], 2), "*")
      }
      
      if (correlation_afd$acf[j] > qnorm((1 + 0.95)/2)/sqrt(correlation_afd$n.used) | 
          correlation_afd$acf[j] < -qnorm((1 + 0.95)/2)/sqrt(correlation_afd$n.used)) {
        row$ccf_afd <- paste(round(correlation_afd$acf[j], 2), "*")
      }
      results <- rbind(results, row)
    }
  }
  results
}

newspapers <- list(
  `Bild.de` = bild_online,
  `Bild` = bild_offline,
  `FAZ Online` = faz_online,
  `FAZ` = faz_offline,
  `Welt Online` = welt_online,
  `Die Welt` = welt_offline
)

health <- create_table(tweets_afd,
                       tweets_wo_afd,
                       newspapers,
                       "health")

energy <- create_table(tweets_afd,
                       tweets_wo_afd,
                       newspapers,
                       "energy")

immigration <- create_table(tweets_afd,
                            tweets_wo_afd,
                            newspapers,
                            "immigration")

trade <- create_table(tweets_afd,
                      tweets_wo_afd,
                      newspapers,
                      "trade")

final_ccf <- cbind(health,
                   energy[ , 3:4],
                   immigration[ , 3:4],
                   trade[ , 3:4])

# transform to tex
kable(final_ccf,
      format = "latex",
      booktabs = T) %>% 
  kable_styling(latex_options = c("hold_position","scale_down"),
                full_width = F)

