
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
colors <- colorRampPalette(c("#663399","#669999"))(4)
state.x77$region <- state.region
ggplot(state.x77, aes(y = Illiteracy, x = Income, colour = region)) +
  geom_point(size = 3) +
  scale_colour_manual("Region", values = colors)

# GGVIS - SCATTERPLOT
state.x77$color_region <- colors[factor(state.x77$region)]

gg1 <- state.x77 %>%
  ggvis(x = ~Income, y = ~Illiteracy, fill := ~color_region) %>%
  layer_points() 

gg1

# GGPLOTLY - SCATTERPLOT
gg2 <- ggplot(state.x77, aes(y = Illiteracy, x = Income, colour = region)) +
  geom_point(size = 3) +
  scale_colour_manual("Region", values = colors)

ggplotly(gg2)

plot_ly(y = state.x77$Illiteracy, x = state.x77$Income,
        type = "scatter", 
        mode = "markers",
        color = state.x77$region,
        colors = colors) 
    

# RCHARTS - SCATTERPLOT
gg3 <- rPlot(Illiteracy ~ Income, 
             data = state.x77, 
             color = ~region,
             type = "point")

gg3$guides(
  x = list(min = 0, max = max(state.x77$Income)),
  y = list(min = 0, max = max(state.x77$Illiteracy))
  )

gg3

# GoogleVis 
colors_str <- paste("['",gsub(",","','",paste(colors, collapse = ",")),"']", sep = "",collapse = "")

gg4 <- gvisBubbleChart(data = state.x77,
            xvar = "Income", yvar = "Illiteracy",
            colorvar = "region", sizevar = "Murder",
            options = list(width = 800, height = 800,
                           bubble = "{textStyle :{color: 'none'}}",
                           colors = colors_str))

plot(gg4)
