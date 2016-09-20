#  R --save < skas_timed_iteration_boxplot.R

d8 <- read.csv('dataset_skas_8t.log.csv')
d10 <- read.csv('dataset_skas_10t.log.csv')
d12 <- read.csv('dataset_skas_12t.log.csv')
png(filename="skas_timed_iteration_boxplot.png")
boxplot( d8$best_iteration,
        d10$best_iteration,
        d12$best_iteration,
        main="Iterationen (zeitbasierter Abbruch)",
        ylab="Beste Interation",
        xlab="Facilities",names=c("8","10","12"))
dev.off()
