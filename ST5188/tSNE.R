############### data import
library(readr)
fashion_mnist_train = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/fashion-mnist_train.csv")
fashion_mnist_test = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/fashion-mnist_test.csv")
label  = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/actual_label_test.csv")

## tSNE embedding data
embedding_o = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/em_test_o.csv")
embedding = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/em_test_m1.csv")
embedding_2 = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/em_test_m2.csv")
embedding_3 = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/em_test_ag3.csv")

## test label
label  = read_csv("C:/Users/DELL/Desktop/Capstone Project/code/actual_label_test.csv")


##################visualization: original test
train_embed_o = cbind(label[,2],embedding_o)
train_embed_o = train_embed_o[,-2]
colnames(train_embed_o) = c('label','x','y')
train_embed_o[,1] = as.character(train_embed_o[,1])
ggplot(data = train_embed_o ,mapping = aes(x=x, y=y,colour = label))+ 
  geom_point(alpha = 0.7)+theme_bw()

################# visualization: m1
library(ggplot2)
train_embed = cbind(label[,2],embedding)
train_embed = train_embed[,-2]
colnames(train_embed) = c('label','x','y')
train_embed[,1] = as.character(train_embed[,1])
ggplot(data = train_embed ,mapping = aes(x=x, y=y,colour = label))+ 
  geom_point(alpha = 0.7)+theme_bw()
                                        
###################visualization: m2

train_embed_2 = cbind(label[,2],embedding_2)
train_embed_2 = train_embed_2[,-2]
colnames(train_embed_2) = c('label','x','y')
train_embed_2[,1] = as.character(train_embed_2[,1])
ggplot(data = train_embed_2 ,mapping = aes(x=x, y=y,colour = label))+ 
  geom_point(alpha = 0.7)+theme_bw()


###################visualization: ag

train_embed_3 = cbind(label[,2],embedding_3)
train_embed_3 = train_embed_3[,-2]
colnames(train_embed_3) = c('label','x','y')
train_embed_3[,1] = as.character(train_embed_3[,1])
ggplot(data = train_embed_3 ,mapping = aes(x=x, y=y,colour = label))+ 
  geom_point(alpha = 0.7)+theme_bw()
