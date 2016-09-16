#  R --save < skas_cost_boxplot.R

d4 <- read.csv('dataset_skas_4.log.csv')
d6 <- read.csv('dataset_skas_6.log.csv')
d8 <- read.csv('dataset_skas_8.log.csv')
d10 <- read.csv('dataset_skas_10.log.csv')
d12 <- read.csv('dataset_skas_12.log.csv')
png(filename="skas_cost_boxplot.png")
boxplot(d4$best_costs,
        d6$best_costs,
        d8$best_costs,
        d10$best_costs,
        d12$best_costs,
        main="Kosten",
        ylab="iBeste Kosten",
        xlab="Facilities",names=c("4","6","8","10","12"))
dev.off()
