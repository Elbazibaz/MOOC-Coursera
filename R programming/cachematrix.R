## The goal is to be able to cache the result of the inversion of a matrix to avoid calculating it if we need the same matrix again.

## The goal of the first function, makeCacheMatrix, is to return a list of functions that we will need in the second function. Therefore we can still access this environment.
makeCacheMatrix <- function(x = matrix()) {
    
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinverse <- function(solve) inv <<- solve
    getinverse <- function() inv
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}
## The x in this function is a list of the function that has been returned by makeCacheMatrix(). This function return the inv of the initial matrix defined in the first function. If the inv is already in the cache, we don't calculate it. If it's not we do calculate it.
cacheSolve <- function(x, ...) {
    inv <- x$getinverse()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setinverse(inv)
    inv
}
