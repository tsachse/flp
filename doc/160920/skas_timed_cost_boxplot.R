#  R --save < skas_timed_cost_boxplot.R

d8 <- read.csv('dataset_skas_8t.log.csv')
d10 <- read.csv('dataset_skas_10t.log.csv')
d12 <- read.csv('dataset_skas_12t.log.csv')
png(filename="skas_timed_cost_boxplot.png")
boxplot( d8$best_costs,
        d10$best_costs,
        d12$best_costs,
        main="Kosten (zeitbasierter Abbruch)",
        ylab="Beste Kosten",
        xlab="Facilities",names=c("8","10","12"))
dev.off()
