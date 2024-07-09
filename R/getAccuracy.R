###############################################################################
###############################################################################
###############################################################################

#' Calculate the Extended Accuracy from a Confusion Matrix
#'
#' This function computes the extended accuracy of a classification model by considering
#' not only the main diagonal (perfect classification matches) but also adjacent
#' diagonals if specified. This allows for a measure of accuracy that can accept
#' near-miss classifications as correct within a certain tolerance.
#'
#' @param table A square matrix representing the confusion matrix data.
#'              Each element should be an integer count of predictions versus
#'              actual class labels. The matrix must be square.
#' @param n_of_parallel_diagonals_to_consider An integer indicating how many
#'        diagonals parallel to the main diagonal should be considered in the
#'        accuracy calculation. This allows for a tolerance in classification
#'        accuracy where predictions close to the correct class are counted as
#'        correct. This value must be non-negative and less than the dimension of
#'        the matrix.
#'
#' @return A list containing two elements:
#'         - `accuracy`: The extended accuracy as a decimal, representing the
#'           probability that the classification is correct or nearly correct
#'           within the specified tolerance.
#'         - `expected_accuracy`: The expected accuracy assuming random classification,
#'           adjusted for the number of diagonals considered.
#'
#' @examples
#' table <- matrix(c(10, 2, 1, 2, 15, 3, 4, 0, 18), nrow = 3, byrow = TRUE)
#' getAccuracy(table, 1)  # Includes main diagonal and one parallel on each side
getAccuracy <- function(
    
    table,
    n_of_parallel_diagonals_to_consider = 0
    
){
    
    # '''
    # table: A square matrix of the confusion matrix data. Each cell
    #        contains integer counts of predictions versus actual class
    #        labels. This matrix must be square and contain only integer
    #        values.
    # n_of_parallel_diagonals_to_consider: Number of diagonals parallel
    #        to the main diagonal to include in the accuracy calculation.
    #        This value should be non-negative and less than the dimension
    #        of the confusion matrix 'table'.
    # 
    # The function calculates and returns a list with two elements,
    #  (i) 'accuracy' -- the extended accuracy, a point estimate of the
    #      probability that an algorithm classifying observed values
    #      correctly. Depending on 'n_of_parallel_diagonals_to_consider',
    #      a perfect class match or matches that differ by
    #      'n_of_parallel_diagonals_to_consider' values (when sorted) are
    #      considered correct classifications.
    # (ii) 'expected_accuracy' -- the expected value of such an accuracy if
    #      the algorithm behind the confusion matrix was classifying randomly.
    #      This takes into account the number of considered parallel diagonals.
    # '''
    
    ## error handling ---------------------------------------------------------
    
    if(
        missing(table)
    ){
        
        stop(
            "Argument 'table' is missing with no default!"
        )
        
    }
    
    if(
        any(
            is.na(
                round(table, digits = 0)
            )
        )
    ){
        
        stop(
            "Confusion matrix 'table' must contain integer numbers!"
        )
        
    }
    
    if(
        any(
            round(table, digits = 0) != table
        )
    ){
        
        stop(
            "Confusion matrix 'table' must contain integer numbers!"
        )
        
    }
    
    if(
        dim(table)[1] != dim(table)[2]
    ){
        
        stop(
            "Confusion matrix 'table' must be a square matrix!"
        )
        
    }
    
    if(
        missing(n_of_parallel_diagonals_to_consider)
    ){
        
        stop(
            paste(
                "Argument 'n_of_parallel_diagonals_to_consider' ",
                "is missing with no default!",
                sep = ""
            )
        )
        
    }
    
    if(
        ! is.numeric(n_of_parallel_diagonals_to_consider)
    ){
        
        stop(
            paste(
                "Argument '",
                n_of_parallel_diagonals_to_consider,
                "' must be a number!",
                sep = ""
            )
        )
        
    }
    
    if(
        n_of_parallel_diagonals_to_consider < 0 |
        n_of_parallel_diagonals_to_consider > dim(table)[1] - 1
    ){
        
        stop(
            paste(
                "Argument 'n_of_parallel_diagonals_to_consider' ",
                "must be a non-negative integer lower than the dimension ",
                "of confusion matrix 'table'!",
                sep = ""
            )
        )
        
    }
    
    
    ## main function body -----------------------------------------------------
    
    my_accuracy <- 0
    
    for(
        i in 1:dim(table)[1]
    ){
        
        for(
            j in 1:dim(table)[2]
        ){
            
            if(
                abs(i - j) <= n_of_parallel_diagonals_to_consider
            ){
                
                my_accuracy <- my_accuracy + table[i, j] / sum(table)
                
            }
            
        }
        
    }
    
    return(
        list(
            "accuracy" = my_accuracy,
            "expected_accuracy" = 1 - (
                (
                    dim(table)[1] -
                    n_of_parallel_diagonals_to_consider -
                    1
                ) * (
                    dim(table)[1] -
                    n_of_parallel_diagonals_to_consider
                )
            ) / (
                dim(table)[1] ^ 2
            )
        )
    )
    
}


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





