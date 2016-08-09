#  R --save < skas6_costs_boxplot.R
dijkstra <- read.csv('dataset_skas_6.log.csv')
floyd <- read.csv('dataset_skas_6f.log.csv')
simple <- read.csv('dataset_skas_6s.log.csv')
p <- simple[,"dataset"]=="skas_6s+"
simple_plus <- simple[p,]
boxplot(dijkstra$best_costs,
	floyd$best_costs,
	simple_plus$best_costs,
	main="Boxplot der Kosten",
	ylab="Kosten",
	xlab="Variante",names=c("Dijkstra","Floyd","Simple"))
