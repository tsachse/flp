#  R --save < skas8_costs_boxplot.R
dijkstra <- read.csv('dataset_skas_8.log.csv')
floyd <- read.csv('dataset_skas_8f.log.csv')
simple <- read.csv('dataset_skas_8s.log.csv')
p <- simple[,"dataset"]=="skas_8s+"
simple_plus <- simple[p,]
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

