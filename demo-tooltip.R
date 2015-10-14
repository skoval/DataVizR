
library(ggplot2)
library(googleVis)
library(ggvis)
library(plotly)
library(rCharts)

library(dplyr) # piping

# Credentials for plotly - user-specific
Sys.setenv("plotly_username" = "on-the-t")
Sys.setenv("plotly_api_key" = "rsmkz3l6jy")

# Prepare data for demo
data(state)
state.x77 <- as.data.frame(state.x77)


# GGPLOT2 - SCATTERPLOT
state.x77$state <- rownames(state.x77)
ggplot(state.x77, aes(y = Illiteracy, x = Income)) +
  geom_point(size = 3, colour = colors[1]) +
  geom_text(aes(label = state)) 

# GGPLOTLY - SCATTERPLOT
gg1 <- ggplot(state.x77, aes(y = Illiteracy, x = Income, 
                             colour = region, text = state)) +
  geom_point(size = 3) +
  scale_colour_manual("Region", values = colors)

ggplotly(gg1)


# GoogleVis 
colors_str <- paste("['",gsub(",","','",paste(colors, collapse = ",")),"']", sep = "",collapse = "")

gg2 <- gvisBubbleChart(data = state.x77,
            idvar = "state",
            xvar = "Income", yvar = "Illiteracy",
            colorvar = "region", sizevar = "Murder",
            options = list(width = 800, height = 800,
                           colors = colors_str))

plot(gg2)
