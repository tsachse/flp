#  R --save < skas4_costs_boxplot.R
dijkstra <- read.csv('dataset_skas_4.log.csv')
floyd <- read.csv('dataset_skas_4f.log.csv')
simple <- read.csv('dataset_skas_4s.log.csv')
p <- simple[,"dataset"]=="skas_4s+"
simple_plus <- simple[p,]
boxplot(dijkstra$duration,
        floyd$duration,
        simple_plus$duration,
        main="Boxplot der Rechenzeit",
        ylab="Sekunden",
        xlab="Variante",names=c("Dijkstra","Floyd","Simple"))
