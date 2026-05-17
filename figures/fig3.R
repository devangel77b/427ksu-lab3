library(ggplot2)
library(dplyr)
library(png)
library(grid)

raw <- read.csv('fig3.csv',header=TRUE)
data <- tibble(raw)

uncompressed <- readPNG("uncompressed.png")
un <- rasterGrob(uncompressed,interpolate=TRUE)
partial <- readPNG("partial.png")
pa <- rasterGrob(partial,interpolate=TRUE)
full <- readPNG("full.png")
fu <- rasterGrob(full,interpolate=TRUE)

fig3 <- ggplot(data,aes(x=x_m,y=F_N))+
     geom_point(color='skyblue')+
     geom_line(color='skyblue')+
     geom_area(fill='skyblue',alpha=0.5)+
     xlab('$x$, \\unit{\\meter}')+
     ylab('$F$, \\unit{\\newton}')+
     ylim(0,10)+
     annotate("text",x=0.015,y=1.25,label="\\qty{0.129}{\\joule}",size=2.811)+
     annotate("text",x=0.04,y=1.25,label="\\qty{0.128}{\\joule}",size=2.811)+
     annotate("text",x=0.055,y=1.25,label="\\qty{0.043}{\\joule}",size=2.811)+
     annotation_custom(un,xmin=0.005,xmax=0.009,ymin=2.5,ymax=5.0)+
     annotation_custom(pa,xmin=0.025,xmax=0.029,ymin=8,ymax=10.5)+
     annotation_custom(fu,xmin=0.05,xmax=0.054,ymin=4,ymax=7)+
     theme_bw(base_size=8)
ggsave("fig3.svg",plot=fig3,width=3.4167,height=2,units="in")

# get area using trapz in pracma package
library(pracma)
trapz(data$x_m,data$F_N)
# gives 0.298705

