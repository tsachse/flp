#  R --save < skas6_boxplot.R
dijkstra <- read.csv('dataset_skas_6.log.csv')
floyd <- read.csv('dataset_skas_6f.log.csv')
simple <- read.csv('dataset_skas_6s.log.csv')
p <- simple[,"dataset"]=="skas_6s+"
simple_plus <- simple[p,]
png(filename="dataset_skas_6_boxplot.png")
par(mfcol=c(1,2))
boxplot(dijkstra$duration,
        floyd$duration,
        simple_plus$duration,
        main="Rechenzeit",
        ylab="Sekunden",
        xlab="Variante",names=c("Dijkstra","Floyd","Simple"))
boxplot(dijkstra$best_costs,
        floyd$best_costs,
        simple_plus$best_costs,
        main="Kosten",
        ylab="Kosten",
        xlab="Variante",names=c("Dijkstra","Floyd","Simple"))
dev.off()
