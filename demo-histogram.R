
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
  layer_histograms(width = 0.5, fill := "#663399")

hist.gvis

# GGPLOTLY - HISTOGRAM
gg1 <- ggplot(state.x77, aes(x = Illiteracy)) +
         geom_histogram(binwidth = 0.5, fill = "#663399")

ggplotly(gg1)

  # plotly version
plot_ly(x = state.x77$Illiteracy, type = "histogram", 
        marker = list(color = "#663399"))


# RCHARTS - HISTOGRAM
hist.rcharts <- rPlot(x="bin(Illiteracy, 0.5)", y="count(Illiteracy)", 
                      data=state.x77, type="bar", color = list(const = "#663399"))

hist.rcharts

# GoogleVis - HISTOGRAM
hist.gvis <- gvisHistogram(data=state.x77["Illiteracy"],
                           options = list(width = 800, height = 1000, colors = "['#663399']"))
plot(hist.gvis)



# OVERLAID
# plotly version
state.x77$region <- state.region

plot_ly(x = state.x77$Illiteracy[state.x77$region == "West"], 
        type = "histogram", opacity = 0.5,
        marker = list(color = "#663399")) %>%
  add_trace(x = state.x77$Illiteracy[state.x77$region == "South"],
            opacity = 0.5,
            marker = list(color = "#009688")) %>%
  layout(barmode="overlay")

  
