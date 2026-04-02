library(ggplot2)
library(dplyr)
library(tidyr)

raw <- read.csv('fig8.csv',header=TRUE)
data <- tibble(raw)
m = 0.0055
g = 9.81

data <- mutate(data,
     KE = 1/2*m*v_ms^2,
     GPE = m*g*h_m)

print(summarize(data,
	meanKE = mean(KE),
	sdKE = sd(KE),
	meanGPE = mean(GPE),
	sdGPE = sd(GPE)))

longer <- data %>%
       select(KE, GPE, trial) %>%
       pivot_longer(
	cols=c(KE,GPE),
	values_to='E'
	)

fig8 <- ggplot(longer,aes(x=name,y=E,fill=name))+
     geom_hline(yintercept=0,color='gray70')+
     stat_summary(fun=mean,geom="bar",width=0.6)+
     stat_summary(fun.data = mean_sdl, fun.args=list(mult=1),
     			   geom="errorbar",width=0.2)+
     theme_bw(base_size=8)+
     scale_x_discrete(limits=c("KE","GPE"),labels=c('KE','GPE'))+
     ylab('\\unit{\\joule}')+
     theme(legend.position="none",
	axis.title.x=element_blank())
ggsave('fig8.svg',plot=fig8,width=3.4167,height=2,units="in")