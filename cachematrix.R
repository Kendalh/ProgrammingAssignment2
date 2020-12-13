## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

# create a speical matrix that caches the inverse matrix
makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setInverse <- function(iv) inverse <<- iv
  getInverse <- function() inverse
  list(get=get, set=set, getInverse=getInverse, setInverse=setInverse)
}


## Write a short comment describing this function

# return the inverse of the matrix from cache if already computed, otherwise 
# do the computation and retrun
cacheSolve <- function(x, ...) {
  iv <- x$getInverse()
  if (!is.null(iv)) {
    message("get cached data")
    return(iv)
  } else {
    matrix <- x$get()
    iv <- solve(matrix, ...)
    x$setInverse(iv)
    return(iv)
  }
}
