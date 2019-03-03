##aim: to build a map with colour gradient for GB
##https://stackoverflow.com/questions/49126405/how-to-set-up-asymmetrical-color-gradient-for-a-numerical-variable-in-leaflet-in
##
rm(list = ls())
if(!require("pacman")) install.packages("pacman")
pacman::p_load(raster, dplyr, leaflet, RColorBrewer)

### Get UK polygon data
UK <- getData("GADM", country = "GB", level = 2)

View(UK@data)

### Create dummy data
set.seed(111)
mydf <- data.frame(place = unique(UK$NAME_2),
                   value = sample(x = -20:180, size = n_distinct(UK$NAME_2), replace = TRUE))
# mydf <- read.csv("gb_data.csv")

# write.csv(mydf, "gb_data.csv", row.names = F)

### Create an asymmetric color range

## Make vector of colors for values smaller than 0 (20 colors)
rc1 <- colorRampPalette(colors = c("red", "white"), space = "Lab")(20)

## Make vector of colors for values larger than 0 (180 colors)
rc2 <- colorRampPalette(colors = c("white", "green"), space = "Lab")(180)

## Combine the two color palettes
rampcols <- c(rc1, rc2)

mypal <- colorNumeric(palette = rampcols, domain = mydf$value)

## If you want to preview the color range, run the following code
previewColors(colorNumeric(palette = rampcols, domain = NULL), values = -20:180)

##preuce a map on region

leaflet() %>% 
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  setView(lat = 55, lng = -3, zoom = 6) %>%
  addPolygons(data = UK,
              stroke = FALSE, smoothFactor = 0.2, fillOpacity = 0.3,
              fillColor = ~mypal(mydf$value),
              popup = paste("Region: ", UK$NAME_2, "<br>",
                            "Value: ", mydf$value, "<br>")) %>%
  addLegend(position = "bottomright", pal = mypal, values = mydf$value,
            title = "Sales",
            opacity = 1)

