# read data reshape and plot
COL.N=c("class","cap.shape","cap.surface","cap.color","bruises","odor","
gill.attachment","gill.spacing","gill.size","gill.color","
stalk.shape","stalk.root","stalk.surface.above.ring","
stalk.surface.below.ring","stalk.color.above.ring","
stalk.color.below.ring","veil.type","veil.color","
ring.number","ring.type","spore.print.color","population","habitat")

library(readr)
mushrooms <- read_csv("datasets_478_974_mushrooms.csv", 
                      col_types = cols(`gill-attachment` = col_character()))
mushrooms = as.data.frame(unclass(mushrooms),stringsAsFactors = T)

library(ggplot2)





#cap.shape
ggplot(mushrooms, aes(x =cap.shape,fill = class)) + 
  geom_bar(stat="count", position = 'stack',alpha=1) +
  geom_text(stat='count',aes(label=..count..), 
            #vjust=0, 
            color="gray30",
            size=3,position=position_stack(0.5))+
  scale_fill_brewer(palette=2,name = "class",
                      labels = c("edible", "poisonous"))+
  scale_x_discrete(labels=c("bell","conical","flat",
                            "knobbed","sunken","convex"))+
  labs(#title = "Categorywise Bar Chart",
       subtitle = "cap.shape",
       x="",
       y="count")+
  theme(axis.text.x = element_text(size = 10, vjust = .6, hjust = 0.5, angle = 30))


#cap.surface
ggplot(mushrooms, aes(x = cap.surface,fill = class)) + 
  geom_bar(stat="count", position = 'stack',alpha=.8) +
  geom_text(stat='count',aes(label=..count..), 
            #vjust=0, 
            color="gray30",
            size=3,position=position_stack(0.5))+
  scale_fill_brewer(palette=16,name = "类别",
                    labels = c("可食用", "有毒"))+
  labs(#title = "Categorywise Bar Chart",
    subtitle = "cap.surface",
    x="",
    y="数量")

after.imp=data.frame(
  class=rep(c("e0","p0","e1","p1"),4),
  name=rep(c("bulbous","club", "equal", "rooted"),each=4),
  dat=c(1920,1856,291,1674,
        512,44,58,0,
        864,256,371,86,
        192,0,0,0)
)  
ggplot(after.imp, aes(x = name,y=dat,fill = class)) + 
  geom_bar(stat="identity", position = 'stack',alpha=.8) +
  scale_fill_brewer(palette=1,name = "类别",
                    labels = c("原可食用", "原有毒","新增可食用","新增有毒"))+
  labs(#title = "Categorywise Bar Chart",
    subtitle = "stalk.root",
    x="",
    y="数量")

library(hrbrthemes)
library(GGally)
library(viridis)
ggparcoord(data.a[sample(1:8124,size=1000),1:22],
           columns = 2:21, 
           groupColumn = 22, 
            order = "anyClass",
            showPoints = TRUE, 
            title = "Parallel Plot of Feature",
           scale="uniminmax",
            alphaLines = 0.3
) + scale_fill_brewer(palette=2,name = "class",
                    labels = c("edible", "poisonous"))+ theme(
    legend.position="none",
    plot.title = element_text(size=13)
  ) +theme(legend.position = "right",axis.text.x = element_text(size = 10, vjust = .6, hjust = 0.5, angle = 30))+xlab("")+ylab("")

