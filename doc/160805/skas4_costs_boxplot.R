skas4 <- read.csv('dataset_skas_4.log.csv')
skas4f <- read.csv('dataset_skas_4f.log.csv')
skas4s <- read.csv('dataset_skas_4s.log.csv')
boxplot(skas4$best_costs,
	skas4f$best_costs,
	skas4s$best_costs,
	main="Boxplot der Kosten",
	ylab="Kosten",
	xlab="Variante",names=c("Dijkstra","Floyd","Simple"))
