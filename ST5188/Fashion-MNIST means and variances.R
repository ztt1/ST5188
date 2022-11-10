library(ggplot2)

load_image_file <- function(filename) {
  ret = list()
  f = file(filename,'rb')
  readBin(f,'integer',n=1,size=4,endian='big')
  ret$n = readBin(f,'integer',n=1,size=4,endian='big')
  nrow = readBin(f,'integer',n=1,size=4,endian='big')
  ncol = readBin(f,'integer',n=1,size=4,endian='big')
  x = readBin(f,'integer',n=ret$n*nrow*ncol,size=1,signed=F)
  ret$x = matrix(x, ncol=nrow*ncol, byrow=T)
  close(f)
  ret
}
load_label_file <- function(filename) {
  f = file(filename,'rb')
  readBin(f,'integer',n=1,size=4,endian='big')
  n = readBin(f,'integer',n=1,size=4,endian='big')
  y = readBin(f,'integer',n=n,size=1,signed=F)
  close(f)
  y
}

train <<- load_image_file('train-images-idx3-ubyte')
test <<- load_image_file('t10k-images-idx3-ubyte')

train_y <<- load_label_file('train-labels-idx1-ubyte')
test_y<<- load_label_file('t10k-labels-idx1-ubyte')  

A = rbind(test$x, train$x)
B = c(test_y,train_y)
C = t(rbind(rowMeans(A),B))
Variance = matrix(0,70000,1)
for (i in 1:nrow(Variance)) {
  Variance[i,1] = var(A[i,])
}
C = cbind(C,Variance)

colnames(C) = c("mean","label","Variance")
C = data.frame(C)

C$label.f <- factor(C$label,levels=c(0,1,2,3,4,5,6,7,8,9),
                    labels=c("T-shirt/top","Trouser","Pullover",
                             "Dress","Coat","Sandal","Shirt",
                             "Sneaker","Bag","Ankle boot"))

ggplot(C,aes(label.f,mean))+
  geom_boxplot(position=position_dodge(0.6),
               size=0.7,
               width=0.5,
               fill=rainbow(10),
               color="black",
               outlier.color = "black",
               outlier.fill = "red",
               outlier.shape = 19,
               outlier.size = 1.5,
               outlier.stroke = 0.5,
               outlier.alpha = 45,
               notch = F,
               notchwidth = 0.5)+
  theme(axis.title = element_text(size=18),
        axis.text = element_text(size=14))

ggplot(C,aes(label.f,Variance))+
  geom_boxplot(position=position_dodge(0.6),
               size=0.7,
               width=0.5,
               fill=rainbow(10),
               color="black",
               outlier.color = "black",
               outlier.fill = "red",
               outlier.shape = 19,
               outlier.size = 1.5,
               outlier.stroke = 0.5,
               outlier.alpha = 45,
               notch = F,
               notchwidth = 0.5)+
  theme(axis.title = element_text(size=18),
        axis.text = element_text(size=14))


