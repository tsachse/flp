#  R --save < skas12_boxplot.R
dijkstra <- read.csv('dataset_skas_12.log.csv')
floyd <- read.csv('dataset_skas_12f.log.csv')
simple <- read.csv('dataset_skas_12s.log.csv')
p <- simple[,"dataset"]=="skas_12s+"
simple_plus <- simple[p,]
png(filename="dataset_skas_12_boxplot.png")
par(mfcol=c(1,2))
boxplot(dijkstra$duration,
        floyd$duration,
        simple_plus$duration,
        main="Rechenzeit",
        ylab="Sekunden",
        xlab="Variante",names=c("D","F","S"))
boxplot(dijkstra$best_costs,
        floyd$best_costs,
        simple_plus$best_costs,
        main="Kosten",
        ylab="Kosten",
        xlab="Variante",names=c("D","F","S"))
dev.off()
