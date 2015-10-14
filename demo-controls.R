
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
str(state.x77)


# GGPLOT2 - HISTOGRAM
ggplot(state.x77, aes(x = Illiteracy)) +
  geom_histogram(binwidth = 0.5, fill = "#663399")

# GGVIS - HISTOGRAM
hist.gvis <- state.x77 %>% 
  ggvis(x = ~Illiteracy) %>% 
  layer_histograms(width = input_slider(0, 1, step = 0.1, label = "Bin Width"), fill := "#663399")

hist.gvis

# RCHARTS - HISTOGRAM
gg2 <- rPlot(Illiteracy ~ Income, 
             data = state.x77, 
             color = list(const = "#663399"),
             type = "point")

gg2$addControls("x", value = "Income", values = c("Population", "Income", "Murder"))

gg2
