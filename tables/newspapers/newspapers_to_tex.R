# load packages
library("readxl")
library("kableExtra")

# read execl file
newspapers <- read_excel("./tables/newspapers/newspapers.xlsx")

# transform to tex
kable(newspapers,
      format = "latex",
      booktabs = T) %>% 
  kable_styling(latex_options = c("hold_position","scale_down"),
                full_width = F)
