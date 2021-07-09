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

# even thinner borders?
tm_bb <- tm_shape(tbl,projection = proj) +
  tm_borders(lwd = .25) +
  tm_fill("broadband_usage")

tmap::tmap_save(tm_bb,"2021/week20/maps/tm_bb3.png")

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



####### DMV Maps -------
dmv_proj <- "+proj=lcc +lat_1=39.2 +lat_2=38.03333333333333 +lat_0=37.66666666666666 +lon_0=-78.5 +x_0=3500000.0001016 +y_0=2000000.0001016 +ellps=GRS80 +to_meter=0.3048006096012192 +no_defs"

tm_dmv <- tm_shape(dmv,projection = dmv_proj) +
  tm_borders(lwd = .25) +
  tm_fill("broadband_usage", legend.hist = TRUE)

tmap::tmap_save(tm_dmv,"2021/week20/maps/tm_dmv2.png")

gg_dmv <- ggplot() +
  geom_sf(data = dmv, aes(fill = broadband_usage),lwd = .125) + 
  coord_sf(crs = dmv_proj) +
  theme(
    panel.border = element_blank(),
    axis.text = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    plot.background = element_rect(fill = "#3c3c3c"),
    panel.background = element_rect(fill = "#3c3c3c")
  ) +
  ggthemes::scale_fill_continuous_tableau()


ggsave(filename = "2021/week20/maps/gg_bb2.png",plot = gg_dmv,width = 32,height = 15)


