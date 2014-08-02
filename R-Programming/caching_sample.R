makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

x <- makeVector(c(1,2,3,4,5))
y <- cachemean(x)
z <- cachemean(x)
z

B <- matrix( c(2, 4, 3, 1, 5, 7, 1, 2, 3),  nrow=3, ncol=3) 
B_inverse <- solve(B)
B_inverse


make_matrix_vector <- function(input_matrix = matrix())
{
    return_matrix <- NULL
    set <- function(matrix_store)
    {
        input_matrix <<- matrix_store 
        return_matrix <<- NULL            
    }
    get <- function() input_matrix
    set_inverse <- function(solve) return_matrix <<- solve
    get_inverse <- function() return_matrix
    list(set = set, get = get, 
         set_inverse = set_inverse, 
         get_inverse = get_inverse)
}

cache_solve <- function(matrix_to_check, ...)
{
    matrix_store <- matrix_to_check$get_inverse()
    if(!is.null(matrix_store))
    {
        message("Getting Cached Matrix")
        return(matrix_store)
    }
    data <- matrix_to_check$get()
    matrix_store <- solve(data, ...)
    matrix_to_check$set_inverse(matrix_store)
    matrix_store
}

xm <- make_matrix_vector(B)
xm_1 <- cache_solve(xm)
xm_1
xm_2 <- cache_solve(xm)
xm_2

