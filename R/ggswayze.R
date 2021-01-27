#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Key Swayze
#'
#' @param data,params,size key stuff
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
draw_key_swayze <-  function(data, params, size) {

  filename <- system.file(paste0(data$swayze, ".png"), package = "ggswayze", mustWork = TRUE)
  # print(filename)
  img <- as.raster(png::readPNG(filename))
  aspect <- dim(img)[1]/dim(img)[2]
  # rasterGrob
  grid::rasterGrob(image         = img)
}

# swayzeGrob
swayzeGrob <- function(x, y, size, swayze = "breaking", geom_key = list(breaking = "breaking.png",
                                                                        housing  = "housing.png")) {

  filename <- system.file(geom_key[[unique(swayze)]], package = "ggswayze", mustWork = TRUE)
  img <- as.raster(png::readPNG(filename))

  # rasterGrob
  grid::rasterGrob(x             = x,
                   y             = y,
                   image         = img,
                   # only set height so that the width scales proportionally and so that the icon
                   # stays the same size regardless of the dimensions of the plot
                   height        = size * ggplot2::unit(20, "mm"))
}

# GeomSwayze
GeomSwayze <- ggplot2::ggproto(`_class` = "GeomSwayze",
                               `_inherit` = ggplot2::Geom,
                               required_aes = c("x", "y"),
                               non_missing_aes = c("size", "swayze"),
                               default_aes = ggplot2::aes(size = 1, swayze = "breaking", shape  = 19,
                                                          colour = "black",   fill   = NA,
                                                          alpha  = NA,
                                                          stroke =  0.5,
                                                          scale = 5,
                                                          image_filename = "breaking"),

                               draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
                                 coords <- coord$transform(data, panel_scales)
                                 ggplot2:::ggname(prefix = "geom_swayze",
                                                  grob = swayzeGrob(x = coords$x,
                                                                    y = coords$y,
                                                                    size = coords$size,
                                                                    swayze = coords$swayze))
                               },

                               draw_key = draw_key_swayze)

#' @title Swayze layer
#' @description The geom is used to add Patrick Swayze to plots. See ?ggplot2::geom_points for more info.
#' @inheritParams ggplot2::geom_point
#' @examples
#'
#' # install.packages("ggplot2")
#'library(ggplot2)
#'
#' ggplot(mtcars) +
#'  geom_swayze(aes(mpg, wt), swayze = "breaking") +
#'  theme_bw()
#'
#' ggplot(mtcars) +
#'  geom_swayze(aes(mpg, wt), swayze = "housing") +
#'  theme_bw()
#'
#' @importFrom grDevices as.raster
#' @export
geom_swayze <- function(mapping = NULL,
                        data = NULL,
                        stat = "identity",
                        position = "identity",
                        ...,
                        na.rm = FALSE,
                        show.legend = NA,
                        inherit.aes = TRUE) {

  ggplot2::layer(data = data,
                 mapping = mapping,
                 stat = stat,
                 geom = GeomSwayze,
                 position = position,
                 show.legend = show.legend,
                 inherit.aes = inherit.aes,
                 params = list(na.rm = na.rm, ...))
}




