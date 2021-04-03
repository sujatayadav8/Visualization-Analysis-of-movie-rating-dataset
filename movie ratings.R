---
title: "R Notebook"
output: html_notebook
---
```{r}
getwd()
setwd("C:/Users/SAI/Desktop/WINTER WRK/Resume projects")
movies=read.csv("P2-Movie-Ratings (2).csv")
head(movies)
colnames(movies)=c("Film" ,"Genre" ,"CriticRating" ,"AudienceRating","BudgetMillions","Year")
colnames(movies)
head(movies)
str(movies)
```


This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 

```{r}
#####as year is an integer ,we don't need to do calculations with this ,so convert it into factor
factor(movies$Year)
movies$Year=factor(movies$Year)

str(movies)

```


```{r}
########GGPLOT
library(ggplot2)
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))
####add geometry

ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))+
  geom_point()

```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.
```{r}
######add parameter -COLOR
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))+
  geom_point()
#####add size 
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,size=Genre))+
  geom_point()####size =genre doesn't represent any logic ,why thriller movie size is greater than others genre 
#
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,size=BudgetMillions))+
  geom_point()##### here size =budgetmillion represents a logic - that means higher the budget greater d size of bubble
```


```{r}
#########PLOTTING WITH LAYERS
p=ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,size=BudgetMillions))
p
#point
p+geom_point()
#####line
p+geom_line()#doesn't make any sense ,but draw just for practice

#multiple layers
p+geom_point()+geom_line()
p+geom_line()+geom_point()
```


```{r}
########overridding AESTHETIC
q=ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,size=BudgetMillions))
###3add geom layer
q+geom_point()
###over ridding Q
#eg-1
q+geom_point(aes(size=CriticRating))
###eg-2
q+geom_point(aes(colour=BudgetMillions))
# q remains same

q+geom_point()### overridding doesmean we r chnaging the graph permanently - we get original graph after writting this prog
#####eg-3 ### here we r mapping
q+geom_point(aes(x=BudgetMillions))#####but it still show x axis = criticrating 
q+geom_point(aes(x=BudgetMillions))+xlab("BudgetMillions$$$")#######noe x axis=budgetmillion
#eg-4
q+geom_line()+geom_point()
#####reduce the line size ,here we r setting aesthetic

q+geom_line(size=1)+geom_point()
```


```{r}
#########MAPPING VS SETTING
r=ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))
r+geom_point()
###add colour -
#MAPPING (WHAT we have done so far)
r+geom_point(aes(colour=Genre))
####2 - setting
r+geom_point(colour="DarkGreen")
#####ERROR 
#r+geom_point(aes(colour="DarkGreen"))
####mapping 
r+geom_point(aes(size=BudgetMillions))
#setting
r+geom_point(size=4)
#error
#r+geom_point(aes(size=1))
##########............HISTOGRAM AND DENSITY CHART
s=ggplot(data=movies,aes(x=BudgetMillions))
s+geom_histogram(binwidth = 10)
#setting
s+geom_histogram(binwidth = 10,fill="Green")
#mapping
s+geom_histogram(binwidth = 10,aes(fill=Genre))

#######add a border--we r setting it ,not mapping
s+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")
```


```{r}
########3we will improve it


####density charts - some tym we may not need them some tym we may
s+geom_density(aes(fill=Genre))
######adding secret parameter
s+geom_density(aes(fill=Genre),position = "stack")

##########......starting layer tip
t=ggplot(data=movies,aes(x=AudienceRating))
t+geom_histogram(binwidth = 10,fill="White",colour="Blue")
#####another way to achieve this
u=ggplot(data=movies)
u+geom_histogram(binwidth = 10,aes(x=AudienceRating),fill="White",colour="Blue")
```


```{r}
######4th chart

u=ggplot(data=movies)
u+geom_histogram(binwidth = 10,aes(x=CriticRating),fill="White",colour="Blue")#####here no need to 
#####creat another ggplot functiopn ,just change the geom_histogram-aes value and get different graphs 
#### from just same coding
######5-skeleton plot
t=ggplot()
########.......STATISTICAL TRANSFORMATION
v=ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))
v+geom_point()+geom_smooth()

v+geom_point()+geom_smooth(fill=NA)
#####box plot 
v=ggplot(data=movies,aes(x=Genre,y=AudienceRating,colour=Genre))
v+geom_boxplot()

v+geom_boxplot(size=1.2)
v+geom_boxplot(size=1.2)+geom_point()
#####tip/hack
v+geom_boxplot(size=1.2)+geom_jitter()
####another way
v+geom_jitter()+geom_boxplot(size=1.2,alpha=0.9)
#
w=ggplot(data=movies,aes(x=Genre,y=CriticRating,colour=Genre))
w+geom_boxplot()
w+geom_jitter()+geom_boxplot(size=1.2,alpha=0.9)

```

```{r}
##########........Facet 
a=ggplot(data=movies,aes(x=BudgetMillions))
a+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")
#####......facets
a+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+
  facet_grid(Genre~.)
a+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+
  facet_grid(Genre~.,scales="free")
####### scatter_plot
y=ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))
#####facetlayers
#1
y+geom_point(size=1)+facet_grid(Genre~.)
#2
y+geom_point(size=1)+facet_grid(.~Year)
#3
y+geom_point(size=1)+facet_grid(Genre~Year)
##4
y+geom_point(size=1)+
  geom_smooth()+
facet_grid(Genre~Year)
```


```{r}
#####but still we can improve it
#########Coordinates
##limit
#zoom
m=ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,size=BudgetMillions,colour=Genre))
m+geom_point()

m+geom_point()+xlim(50,100)+ylim(50,100)
#######but don't work always
n=ggplot(data=movies,aes(x=BudgetMillions))
n+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+ylim(50,90)
########then how to zoom in ======zoom
n+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+
  coord_cartesian(ylim=c(0,50))
#####add layer of facet_grid
#####33improved on of above

y+geom_point(aes(size=BudgetMillions))+
  geom_smooth()+
  facet_grid(Genre~Year)+
  coord_cartesian(ylim=c(0,100))

##########.........THEME 
o=ggplot(data=movies,aes(x=BudgetMillions))
h=o+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")
h
```


```{r}
######axes labels
h+xlab("Money Axes")+
  ylab("Number of Movies")
###labels formatting
h+
  xlab("Money Axes")+
  ylab("Number of Movies")+
  theme(axis.title.x = element_text(colour = "DarkGreen",size=30),
       axis.title.y = element_text(colour = "Red",size=30))
#####tick mark formetting

h+
  xlab("Money Axes")+
  ylab("Number of Movies")+
  theme(axis.title.x = element_text(colour = "DarkGreen",size=30),
        axis.title.y = element_text(colour = "Red",size=30),
        axis.text.x=element_text(size=20),
        axis.text.y = element_text(size=20))

```


```{r}
####legend formatting# theme
h+
  xlab("Money Axes")+
  ylab("Number of Movies")+
  ggtitle("Movie Budget Distribution")+
  theme(axis.title.x = element_text(colour = "DarkGreen",size=30),
        axis.title.y = element_text(colour = "Red",size=30),
        axis.text.x=element_text(size=20),
        axis.text.y = element_text(size=20),
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour = "Dark Blue",size=30,
                                  family = "Courier") )
```


```{r}
```

