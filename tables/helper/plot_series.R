library(ggplot2)
library(RColorBrewer)

fte_theme <- function() {
  
  # Generate the colors for the chart procedurally with RColorBrewer
  
  palette <- brewer.pal("Greys", n=9)
  color.background = "#ffffff"
  color.grid.major = palette[3]
  color.axis.text = palette[6]
  color.axis.title = palette[7]
  color.title = palette[9]
  
  # Begin construction of chart
  
  theme_bw(base_size=9) +
    
    # Set the entire chart region to a light gray color
    
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    # Format the grid
    
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    
    # Format the legend, but hide by default
    
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=7,color=color.axis.title)) +
    
    # Set title and axis labels, and format these and tick marks
    
    theme(plot.title=element_text(color=color.title, size=10, vjust=1.25)) +
    theme(axis.text.x=element_text(size=7,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=7,color=color.axis.text)) +
    theme(axis.title.x=element_text(size=8,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=8,color=color.axis.title, vjust=1.25)) +
    
    # Plot margins
    
    theme(plot.margin = unit(c(0.35, 0.2, 0.3, 0.35), "cm"))
}

ts_plot_twitter <- function (twitter_wo_afd,
                             twitter_afd,
                             title) {
  # define dates
  begin <- as.Date("2018-03-15")
  end <- as.Date("2018-05-08")
  
  # define date sequence for given time frame
  timeline <- seq(from = begin, 
                  to = end, 
                  by = 1)
  
  ggplot() +
    geom_point(aes(timeline, twitter_wo_afd), pch = 1, col = "#a2a2a2") +
    geom_point(aes(timeline, twitter_afd), pch = 2, col = "#339999") +
    geom_line(aes(timeline, twitter_wo_afd), col = "#a2a2a2", linetype = 2) +
    geom_line(aes(timeline, twitter_afd), col = "#339999") +
    fte_theme() +
    geom_hline(yintercept = 0, size = 0.4, color = "#5a5a5a") +
    labs(title = title,
         x = "",
         y = "# of observations") +
    ylim(-1, 15) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    theme(legend.position = "right")
}

ts_plot_newspaper <- function (twitter_wo_afd,
                     twitter_afd, 
                     newspaper,
                     title) {
  # define dates
  begin <- as.Date("2018-03-15")
  end <- as.Date("2018-05-08")
  
  # define date sequence for given time frame
  timeline <- seq(from = begin, 
                  to = end, 
                  by = 1)
  
  ggplot() +
    geom_point(aes(timeline, twitter_wo_afd), pch = 0, col = "#a2a2a2") +
    geom_point(aes(timeline, twitter_afd), pch = 1, col = "#5a5a5a") +
    geom_point(aes(timeline, newspaper), pch = 2, col = "#339999") +
    geom_line(aes(timeline, twitter_wo_afd), col = "#a2a2a2", alpha = .7, linetype = 2) +
    geom_line(aes(timeline, twitter_afd), col = "#5a5a5a", alpha = .7, linetype = 3) +
    geom_line(aes(timeline, newspaper), col = "#339999", alpha = .7) +
    fte_theme() +
    geom_hline(yintercept = 0, size = 0.4, color = "#5a5a5a") +
    labs(title = title,
         x = "",
         y = "# of observations") +
    ylim(-1, 35) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    theme(legend.position = "right")
}