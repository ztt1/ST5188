#library(tsne)
#library(keras)
library(readr)
#library(M3C)
fashion_mnist_train = read_csv("'C:\\Users\\e0431401\\Downloads\\archive\\fashion-mnist_train.csv'")
dim(fashion_mnist_train)
fashion_mnist_test = read_csv("'C:\\Users\\e0431401\\Downloads\\archive\\fashion-mnist_test.csv'")
dim(fashion_mnist_test)

fashion_mist = rbind(fashion_mnist_train,fashion_mnist_test)

mini = sample(1:70000,1000, replace = FALSE)
fashion_mist_mini = fashion_mist[mini,]
#####################



colors = rainbow(length(unique(fashion_mist_mini$label)))
names(colors) = unique(fashion_mist_mini$label)
ecb = function(x,y){ plot(x,t='n'); text(x,labels=fashion_mist_mini$label, col=colors[fashion_mist_mini$label]) }
tsne_fashion_mist = tsne(fashion_mist_mini[,-1], epoch_callback = ecb, perplexity=50)


###################
library(plotly) 
library(umap) 
fm.umap = umap(fashion_mist[,-1], n_components = 2, k = 10) 
layout = fm.umap[["layout"]] 
layout = data.frame(layout) 
final = cbind(layout, fashion_mist[,1]) 
colnames(final) <- c('X1', 'X2', 'label') 

fig = plot_ly(final, x = ~X1, y = ~X2, split = ~label,  type = 'scatter', mode = 'markers')%>%  
  layout(  
    plot_bgcolor = "#e5ecf6",
    legend=list(title=list(text='fashion_mist')), 
    xaxis = list( 
      title = "0"),  
    yaxis = list( 
      title = "1")) 
fig
#### mini
fm.umap = umap(fashion_mist_mini[,-1], n_components = 2, k = 10) 
layout = fm.umap[["layout"]] 
layout = data.frame(layout) 
final = cbind(layout, fashion_mist_mini[,1]) 
colnames(final) <- c('X1', 'X2', 'label') 

fig = plot_ly(final, x = ~X1, y = ~X2, split = ~label,  type = 'scatter', mode = 'markers')%>%  
  layout(  
    plot_bgcolor = "#e5ecf6",
    legend=list(title=list(text='fashion_mist_mini')), 
    xaxis = list( 
      title = "0"),  
    yaxis = list( 
      title = "1")) 
fig

#######################################
fashion_mnist_train$label <- as.character(fashion_mnist_train$label)


train_embed = cbind(fashion_mnist_test$label,embedding)
train_embed = train_embed[,-2]
colnames(train_embed) = c('label','x','y')
library(ggplot2)
as.factor(train_embed$label)
ggplot(data = train_embed ,mapping = aes(x=x, y=y,colour = label))+ 
  geom_point(alpha = 0.2)+theme_bw()
                                        