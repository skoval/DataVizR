
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


# GGPLOT2 - SCATTERPLOT
ggplot(state.x77, aes(y = Illiteracy, x = Income)) +
  geom_point(size = 3, col = "#663399")
  
# GGVIS - SCATTERPLOT
gg1 <- state.x77 %>%
  ggvis(x = ~Income, y = ~Illiteracy, fill := "#663399") %>%
  layer_points()

gg1

# GGPLOTLY - SCATTERPLOT
gg1 <- ggplot(state.x77, aes(y = Illiteracy, x = Income)) +
  geom_point(size = 3, col = "#663399")

ggplotly(gg1)

# PLOTLY - SCATTERPLOT
plot_ly(data = state.x77, x = Income, y = Illiteracy, 
        mode = "markers", 
        marker = list(color = "#663399"))

    
# RCHARTS - SCATTERPLOT
gg2 <- rPlot(Illiteracy ~ Income, 
             data = state.x77, 
             color = list(const = "#663399"),
             type = "point")

gg2$guides(
  x = list(min = 0, max = max(state.x77$Income)),
  y = list(min = 0, max = max(state.x77$Illiteracy))
  )

gg2

# GoogleVis - SCATTERPLOT
gg3 <- gvisScatterChart(state.x77[,c("Income", "Illiteracy")],
  options = list(width = 800, height = 800,
                 colors = "['#663399']"))

plot(gg3)
