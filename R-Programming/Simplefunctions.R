add2 <- function(a,b)
{
    a+b
}

above10 <- function(x, n = 10)
{
    use <- x > n
    x[use]
}

columnmean <- function (y, removeNA = TRUE)
{
    nc <- ncol(y)
    means <- numeric(nc)
    
    for (i in 1:nc)
    {
        #     values <- y[,i]
        #     print(values)
        #     print(values[values > 50])
        means[i] <- mean(y[,i], na.rm = removeNA)
    }
    means
}

