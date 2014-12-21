## Example usage:
# > x <- matrix(rnorm(25), nrow = 5)    // Create base matrix
# > cx <- makeCacheMatrix(x)            // Create cached matrix to wrap matrix
# > cx$get()                            // Return the matrix
# > cacheSolve(cx)                      // Solve for the inverse
# > cacheSolve(cx)                      // Solve inverse again, cached inverse is returned


## makeCacheMatrix: return a list of functions to:
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 4. Get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
    # Inverse - cached
    inv <- NULL

    # Constructor/setter for the matrix
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    # Getter for the matrix
    get <- function() x

    # Setter for the inverse
    setinv <- function(inverse) inv <<- inverse
	
    # Getter for the inverse
    getinv <- function() inv

    # Return matrix with these defined functions
    list(set = set, get = get, setinv = setinv, getinv = getinv)
}


# cacheSolve: 
# Compute the inverse of the matrix. If the inverse has already
# been calculated, return the cached inverse.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of x
	inv <- x$getinv()

    # Return cached inverse if already calculated 
    if (!is.null(inv)) {
        message("getting cached inverse")
        return(inv)
    }

    # Otherwise calculate inverse
    data <- x$get()
    inv <- solve(data, ...)

    # then cache and return inverse
    x$setinv(inv)
    inv
}

