
c(do.call("cbind",myList)) to  convert  list to  vector
Ok, I'm not completely following you.  If you read the file via read.table() or read.csv() you will have a dataframe.  If you have a single variable, j, then you can create a factor and pass it to the table command:

table(factor(j))

For example:

j <- c("versicolor", "versicolor", "virginica", "virginica", "virginica", "versicolor", "versicolor")

jFactor <- factor(j)

table(jFactor)

jFactor
versicolor  virginica 
         4          3 
To get an actual value you can reference the table by name or by column number:

table(jFactor)[["versicolor"]]
[1] 4
or to get it as a table

table(jFactor)["versicolor"]
versicolor 
         4 
