library(ggplot2)
library(dplyr)

raw <- read.csv('fig3.csv',header=TRUE)
data <- tibble(raw)

fig3 <- ggplot(data,aes(x=x_m,y=F_N))+
     geom_point(color='skyblue')+
     geom_line(color='skyblue')+
     geom_area(fill='skyblue',alpha=0.5)+
     xlab('$x$, \\unit{\\meter}')+
     ylab('$F$, \\unit{\\newton}')+
     ylim(0,10)+
     theme_bw(base_size=8)
ggsave("fig3.svg",plot=fig3,width=3.4167,height=2,units="in")

# get area using trapz in pracma package
library(pracma)
trapz(data$x_m,data$F_N)
# gives 0.298705

