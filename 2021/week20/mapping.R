# doing some map setup stuff

# set projection
proj <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

# tmap
library(tmap)
library(tmaptools)
tm_bb <- tm_shape(tbl,projection = proj) +
  tm_borders() +
  tm_fill("broadband_usage")

tmap::tmap_save(tm_bb,"2021/week20/maps/tm_bb.png")

# thinner borders?
tm_bb <- tm_shape(tbl,projection = proj) +
  tm_borders(lwd = .5) +
  tm_fill("broadband_usage")

tmap::tmap_save(tm_bb,"2021/week20/maps/tm_bb2.png")

# ggplot
ggplot() +
  geom_sf(data = tbl, aes(fill = broadband_usage)) + 
  coord_sf(crs = proj)

ggsave("2021/week20/maps/gg_bb.png")


# thinner borders?
ggplot() +
  geom_sf(data = tbl, aes(fill = broadband_usage),lwd = .5) + 
  coord_sf(crs = proj)

ggsave("2021/week20/maps/gg_bb2.png")
