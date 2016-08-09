#  R --save < skas6_costs_boxplot.R
dijkstra <- read.csv('dataset_skas_6.log.csv')
floyd <- read.csv('dataset_skas_6f.log.csv')
simple <- read.csv('dataset_skas_6s.log.csv')
p <- simple[,"dataset"]=="skas_6s+"
simple_plus <- simple[p,]
boxplot(dijkstra$duration,
        floyd$duration,
        simple_plus$duration,
        main="Boxplot der Rechenzeit",
        ylab="Sekunden",
        xlab="Variante",names=c("Dijkstra","Floyd","Simple"))
