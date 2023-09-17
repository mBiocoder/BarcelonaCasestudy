library(ggplot2)
library(sf)
library(rnaturalearth)



worldmap <- ne_countries(scale = 'medium', type = 'map_units',
                         returnclass = 'sf')
# have a look at these two columns only
head(worldmap[c('name', 'continent')])

ggplot() + geom_sf(data = worldmap) + theme_bw()

#Spain alone
spain <- worldmap[worldmap$name == 'Spain',]
ggplot() + geom_sf(data = spain) + theme_bw()

#crop to only get Barcelona
Barcelona_dt <- data.table(longitude=41.3874, latitude = 2.1686, city = "Barcelona")
#create spatial point object for Barcelona
Barcelona_dt <- SpatialPointsDataFrame(coords=Barcelona_dt[, c("longitude", "latitude")], 
                                       data = Barcelona_dt[, "city"], proj4string = CRS("+proj=longlat +datum=WGS84"))

ggplot() + geom_sf(data = worldmap) +
  coord_sf(xlim = c(-1, 5), ylim = c(41, 43), expand = FALSE) +
  theme_bw() + geom_point(aes(x=2.1686, y=41.3874), colour="blue")
#Europe
europe <- worldmap[worldmap$continent == 'Europe',]
ggplot() + geom_sf(data = europe) + theme_bw()

#cropping
ggplot() + geom_sf(data = worldmap) +
  coord_sf(xlim = c(-20, 45), ylim = c(30, 73), expand = FALSE) +
  theme_bw()

############################################################################################
#https://vangdata.carto.com/tables/shapefiles_barcelona_distrito/public
Barcelona_sf1 <- read_sf(dsn = "C:/Users/mahim/Downloads", layer = "shapefiles_barcelona_distrito")
#class(Barcelona_sf1)
#dfB = fortify(Barcelona_sf1)
tm_shape(Barcelona_sf1)+ tm_fill(col = "#e6e6e6") + tm_borders(col ="black") 



# The mtcars dataset:
data <- as.matrix(mtcars)

# Default Heatmap
heatmap(data)
# Use 'scale' to normalize
heatmap(data, scale="column")

