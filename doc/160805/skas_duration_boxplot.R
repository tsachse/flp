#  R --save < skas_duration_boxplot.R

d4 <- read.csv('dataset_skas_4.log.csv')
d6 <- read.csv('dataset_skas_6.log.csv')
d8 <- read.csv('dataset_skas_8.log.csv')
d10 <- read.csv('dataset_skas_10.log.csv')
d12 <- read.csv('dataset_skas_12.log.csv')
png(filename="skas_duration_boxplot.png")
boxplot(d4$duration,
        d6$duration,
        d8$duration,
        d10$duration,
        d12$duration,
        main="Rechenzeit",
        ylab="Sekunden",
        xlab="Facilities",names=c("4","6","8","10","12"))
dev.off()
