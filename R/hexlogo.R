library(hexSticker)

imgurl <- here::here("inst", "img", "logo_d6_alpha.png")

sticker(imgurl, 
        package = "", 
        h_fill = "#17112E",
        h_color = ,
        p_size = 20, 
        s_x = 1, s_y = .75, 
        s_width = .6,
        filename = "inst/img/hexlogo.png")
