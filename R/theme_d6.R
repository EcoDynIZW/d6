#' A custom ggplot2 theme.
#' 
#' A dedicated theme for graphics created within the D6, with sensible defaults 
#' and additional options. It is based on the light theme and uses the custom 
#' typefaces PT Sans (defaul) and PT Serif (optional).
#'
#' @param base_size Numeric. The base sizes used for theme elements, defaults to 14 
#' (which is slightly larger than in the default themes which use 11).
#' @param base_family Character. The base font family, defaults to PT Sans. 
#' Typefaces need to be installed locally. 
#' @param grid Character. Should the panel grid be drawn? Specify \code{""} or 
#' code{"none"} 
#' to draw no grid or any combination of \code{"x"}, \code{"X"}, \code{"y"}, 
#' and \code{"Y"} to draw horizontal (y) and/or vertical (x) grid lines.
#' @param legend Character or numeric vector. The position of legends as to be 
#' used in the \code{`theme()`} function: either \code{"none"}, \code{"left"}, 
#' \code{"right"}, \code{"bottom"}, or \code{"top"}, or a two-element numeric 
#' vector specifying the relative x and y coordinates to place the legend inside 
#' the panel.
#' @param serif Logical. Should Sans or Sans Serif fonts be used? Default is 
#' \code{FALSE}.
#' @param mono Character. Should the axis and/or legend text be formatted as tabular, 
#' mono-spaced font? Specify the axes with \code{"x"}, \code{"X"}, \code{"y"}, 
#' and \code{"Y"} and the legend as \code{"legend"}, \code{"l"} or \code{"L"}. 
#' If you want to use the base family, set \code{""} or \code{"none"} (default).
#' @param margin Vector. The plot margin four-element numeric vector specifying 
#' the margin on the top, right, bottom, and left. Defaults to 
#' \code{rep(base_size / 2, 4)}
#' @param bg Color. The color used for the plot background, defaults to 
#' transparent.
#' @param ... Other arguments passed to complete ggplot2 themes.
#'
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mpg, aes(x = class, y = cty, color = class)) + geom_boxplot() +
#'   theme_d6(grid = "y", bg = "grey90", legend = "top", mono = "y")
theme_d6 <- function(base_size = 14, base_family = "PT Sans",
                     grid = "xy", legend = "bottom", mono = "none",
                     bg = "transparent", serif = FALSE, 
                     margin = rep(base_size / 2, 4), ...) {
  
  if(!is.character(base_family)) stop('base_family must be a character input.')
  if(!is.numeric(base_size) || base_size <= 0) stop('base_size must be a positive number.') 
  if(!grid %in% c("", "none", "xy", "xY", "Xy", "XY", "x", "X", "y", "Y")) stop('grid must be a character: "" or "none" for no grid or any combination of "X", "Y", "x" and "y".')
  str <- isTRUE(legend %in% c("", "none", "top", "bottom", "left", "right"))
  vec <- is.numeric(legend) & length(legend) == 2
  out <- isTRUE(str || vec)
  if(!out) stop('legend must be a character or vector: "", "none", "left", "right", "bottom", "top", or a two-element numeric vector specifying the x and y coordinates to place the legend inside the panel.')
  if(!mono %in% c("", "none", "xy", "xY", "Xy", "XY", "x", "X", "y", "Y", "legend", "l", "L", "xylegend", "xyl", "xyL", "Xylegend", "Xyl", "XyL", "xYlegend", "xYl", "xYL", "XYlegend", "XYl", "XYL")) stop('mono must be a character: "" or "none" or any combination of "x" or "X", "y" or "Y", and "legend", "l" or "L".')
  if(!is.character(bg)) stop('bg must be a character containing a color.')
  if(!is.logical(serif)) stop('serif must be either TRUE or FALSE.')
  if(!is.numeric(margin) & length(margin) != 4) stop('margin must a be four-element numeric vector specifying the margin on the top, right, bottom, and left.')
  
  half_line <- base_size/2
  
  ## typefaces
  if (base_family == "PT Sans") {
    
    fonts_unavailable <- vector("character")
  
    ## base_family for all non-numeric text elements
    ## either serif or sans depending on `serif` argument value
    if (serif == FALSE) {
      if (sum(grepl("PT Sans", systemfonts::system_fonts()$family)) == 0) {
        base_family <- ""
        fonts_unavailable <- c(fonts_unavailable, "PT Sans")
      } else {
        base_family <- "PT Sans"
      }
    } else {
      if (sum(grepl("PT Serif", systemfonts::system_fonts()$family)) == 0) {
        base_family <- ""
        fonts_unavailable <- c(fonts_unavailable, "PT Serif")
      } else {
        base_family <- "PT Serif"
      }
    }
  
    ## tabular typeface for text elements displaying numbers
    if (!mono %in% c("none", "") & sum(grepl("PT Mono", systemfonts::system_fonts()$family)) == 0) {
      mono_family <- ""
      fonts_unavailable <- c(fonts_unavailable, "PT Mono")
    } else {
      mono_family <- "PT Mono"
    }
    
    if (length(fonts_unavailable) > 0) {
      fonts_unavailable <- data.frame(name = fonts_unavailable)
      font_urls <- data.frame(
        name = c("PT Sans", "PT Serif", "PT Mono"),
        url = paste0(
          "https://fonts.google.com/specimen/",
          c("PT+Sans", "PT+Serif", "PT+Mono")
        )
      )
      fonts_unavailable <- merge(fonts_unavailable, font_urls, by = "name")
      message(paste(
        "Using system default fonts. If you want to use the correct fonts in `theme_d6()`, please install the following font(s) and restart your R session.",
        paste0("  - ", fonts_unavailable$name, ": ", fonts_unavailable$url, collapse = "\n"),
        sep = "\n"
      ))
    }
  }
   
  if (base_family != "PT Sans") {
    message("You have specified a custom base family. The options `serif` and `mono` are ignored.")
    
    if (sum(grepl(base_family, systemfonts::system_fonts()$family)) == 0) {
      base_family <- ""
      message("Using system default fonts as the specified base family is not installed on your computer.")
    }
    
    mono_family <- base_family
  }

  ## theme
  out <-
    ggplot2::theme_light(
      base_size = base_size, base_family = base_family, ...
    ) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = base_size / 1.5)),
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = base_size / 1.5)),
      axis.text = ggplot2::element_text(size = ggplot2::rel(.85)),
      strip.text = ggplot2::element_text(
        face = "bold", size = ggplot2::rel(1),
      ),
      legend.text = ggplot2::element_text(size = ggplot2::rel(.85)),
      legend.position = legend,
      legend.background = ggplot2::element_rect(color = bg, fill = bg),
      legend.key = ggplot2::element_rect(color = bg, fill = bg),
      plot.title = ggplot2::element_text(
        face = "bold", size = ggplot2::rel(1.35), hjust = 0, margin = ggplot2::margin(0, 0, 10, 0)
      ),
      plot.title.position = "plot",
      plot.margin = ggplot2::margin(margin),
      plot.background = ggplot2::element_rect(color = bg, fill = bg),
      panel.background = ggplot2::element_rect(color = "transparent", fill = "transparent"),
    )

  ## add grid if needed
  if (!grid %in% c("none", "")) {
    if (!stringr::str_detect(grid, "X|x")) {
      out <- out +
        ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
    }
    if (!stringr::str_detect(grid, "Y|y")) {
      out <- out +
        ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
    }
  } else {
    out <- out +
      ggplot2::theme(panel.grid.major = ggplot2::element_blank())
  }

  ## use tabular typeface for number labels if needed
  if (!mono %in% c("none", "")) {
    if (stringr::str_detect(mono, "X|x")) {
      out <- out +
        ggplot2::theme(axis.text.x = ggplot2::element_text(family = mono_family))
    }
    if (stringr::str_detect(mono, "Y|y")) {
      out <- out +
        ggplot2::theme(axis.text.y = ggplot2::element_text(family = mono_family))
    }
    if (stringr::str_detect(mono, "L|l|legend")) {
      out <- out +
        ggplot2::theme(legend.text = ggplot2::element_text(family = mono_family))
    }
  }

  return(out)

}
