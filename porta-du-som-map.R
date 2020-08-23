#----------------------------------------
# This script sets out to produce a 
# map of the city Porta du Som for
# Trent's new D&D campaign
#
# NOTE: This script requires setup.R to
# have been run first
#----------------------------------------

#----------------------------------------
# Author: Trent Henderson, 23 August 2020
#----------------------------------------

# Read in old paper background for the map

the_url <- "https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_960_720.jpg"
the_file <- tempfile()
download.file(the_url, the_file, mode = "wb")
pic <- readJPEG(the_file)

#---------------------- SIMULATE DATA ---------------

set.seed(123)
x <- rnorm(25)
y <- rnorm(25)

points <- data.frame(x,y) %>%
  mutate(x = round(x, digits = 8),
         y = round(y, digits = 8))

# Specify a set of coordinates to label on the map

the_coords <- c(-0.56047565, -0.62503927, 0.35981383, -1.26506123, -1.96661716)

locations <- points %>%
  filter(x %in% the_coords) %>%
  mutate(location = case_when(
    x == -0.56047565 ~ "Sultry Seafarer (Tavern)",
    x == -0.62503927 ~ "Honourable Grazer (Tavern)",
    x == 0.35981383  ~ "Aegos Market",
    x == -1.26506123 ~ "Porta Slums",
    x == -1.96661716 ~ "Dimdraw Trail (Exit)"))

points <- points %>%
  left_join(locations, by = c("x" = "x", "y" = "y"))

#---------------------- PLOT ------------------------

p <- points %>%
  ggplot(aes(x,y)) +
  background_image(pic) +
  stat_voronoi(geom = "path") +
  geom_text(aes(label = location), fontface = "italic", family = "Times", vjust = -1.5) +
  annotate("text", x = 1.75, y = 2.25, label = "Porta du Som", fontface = "bold.italic", family = "Times",
           size = 6) +
  geom_point(shape = "\u2302", size = 4) + # Turns points into unicode buildings
  theme_void()
print(p)

#---------------------- EXPORT ----------------------

CairoPNG("output/PortaduSom.png", 1000, 600)
print(p)
dev.off()
