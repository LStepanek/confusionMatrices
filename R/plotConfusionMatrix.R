###############################################################################
###############################################################################
###############################################################################

#' Plot a Confusion Matrix with Customizable Options
#'
#' This function visualizes a confusion matrix with various customization options
#' including color schemes, labeling, and highlighting features. It allows for
#' visual emphasis on specific aspects of the data, such as the main diagonal or
#' certain off-diagonal elements, and can represent data in absolute or percentage
#' terms.
#'
#' @param table A square matrix containing confusion matrix data where each
#'              element represents the count of predictions for each actual class.
#'              This matrix must be square and contain integer values only.
#' @param color A character string specifying the color scheme for the matrix.
#'              Options are "grey_scaled" for grayscale and "rgb_scaled" for RGB
#'              color scaling. Default is c("grey_scaled", "rgb_scaled").
#' @param rgb_code A numeric vector of three elements (between 0 and 1) indicating
#'                 the RGB values for color scaling when 'color' is set to "rgb_scaled".
#'                 Default is c(0, 0, 1).
#' @param horizontal_label A string label for the horizontal axis. Default is
#'                         "horizontal_label".
#' @param vertical_label A string label for the vertical axis. Default is
#'                       "vertical_label".
#' @param class_labels A vector of character strings that labels the classes
#'                     corresponding to the rows and columns of the matrix.
#' @param label_half_width Numeric value specifying half the width of the labels.
#'                         Default is 0.5.
#' @param label_offset_factor Numeric value used as a multiplier to adjust label
#'                            offsets. Default is 2.0.
#' @param horizontal_label_srt The rotation angle for horizontal labels in degrees.
#'                             Default is 0.
#' @param horizontal_label_cex Numeric value specifying the character expansion
#'                             factor for horizontal labels. Default is 1.0.
#' @param vertical_label_srt The rotation angle for vertical labels in degrees.
#'                           Default is 90.
#' @param vertical_label_cex Numeric value specifying the character expansion
#'                           factor for vertical labels. Default is 1.0.
#' @param left_margin Numeric value specifying the left margin size of the plot.
#'                    Default is 5.0.
#' @param top_margin Numeric value specifying the top margin size of the plot.
#'                   Default is 5.0.
#' @param main_diagonal_highlighting Character vector specifying how to highlight
#'                                   the main diagonal. Options are "framebox",
#'                                   "color", "both", or "none". Default is c("framebox",
#'                                   "color", "both", "none").
#' @param rgb_code_highlighting Numeric vector of three elements for the RGB values
#'                              used in highlighting. Default is c(1, 0, 0).
#' @param rgb_code_highlighting_framebox Numeric vector of three elements for the
#'                                       RGB frame box color used in highlighting.
#'                                       Default is c(0, 0, 0).
#' @param highlighting_framebox_lwd Numeric specifying the line width of the frame
#'                                  box used in highlighting. Default is 1.0.
#' @param n_of_parallel_diagonals_to_highlight Integer indicating how many
#'        diagonals parallel to the main diagonal should be highlighted.
#'        Default is 0.
#' @param percentage_display Logical indicating whether to display percentages
#'                           instead of absolute numbers. Default is FALSE.
#' @param percentage_round_digits Integer specifying the number of decimal places
#'                                for rounding the displayed percentages.
#'                                Default is 1.
#' @examples
#' table <- matrix(
#'    c(10, 2, 1, 2, 15, 3, 4, 0, 18),
#'    nrow = 3,
#'    byrow = TRUE,
#'    dimnames = list(observed = c("class_1", "class_2", "class_3"),
#'                    predicted = c("class_1", "class_2", "class_3"))
#' )
#' plotConfusionMatrix(table, color = "rgb_scaled", rgb_code = c(1, 0.5, 0),
#'                     horizontal_label = "Predicted Class",
#'                     vertical_label = "Actual Class",
#'                     main_diagonal_highlighting = "color",
#'                     rgb_code_highlighting = c(0.5, 0.5, 0.5))
plotConfusionMatrix <- function(
    
    table,
    color = c("grey_scaled", "rgb_scaled"),
    rgb_code = c(0, 0, 1),
    horizontal_label = "horizontal_label",
    vertical_label = "vertical_label",
    class_labels,
    label_half_width = 0.5,
    label_offset_factor = 2.0,
    horizontal_label_srt = 0,
    horizontal_label_cex = 1.0,
    vertical_label_srt = 90,
    vertical_label_cex = 1.0,
    left_margin = 5.0,
    top_margin = 5.0,
    main_diagonal_highlighting = c("framebox", "color", "both", "none"),
    rgb_code_highlighting = c(1, 0, 0),
    rgb_code_highlighting_framebox = c(0, 0, 0),
    highlighting_framebox_lwd = 1.0,
    n_of_parallel_diagonals_to_highlight = 0,
    percentage_display = FALSE,
    percentage_round_digits = 1
    
){
    
    # '''
    # table: A square matrix of the confusion matrix data. Each cell
    #        contains integer counts of predictions versus actual class
    #        labels.
    # color: Specifies the coloring method for the matrix. Options:
    #        "grey_scaled" - Uses shades of grey. Darker shades indicate
    #        higher values, lighter shades for lower values.
    #        "rgb_scaled" - Uses RGB values specified in 'rgb_code', with
    #        color intensity reflecting cell values.
    # rgb_code: RGB color values for "rgb_scaled". Expects three numbers
    #           between 0 and 1, representing red, green, and blue.
    # horizontal_label: Text label for the horizontal axis.
    # vertical_label: Text label for the vertical axis.
    # class_labels: Vector of labels for matrix rows and columns.
    # label_half_width: Numeric, half the width for class label offsets.
    # label_offset_factor: Multiplier to adjust the offset of axis labels.
    # horizontal_label_srt: Rotation angle of horizontal labels in degrees.
    # horizontal_label_cex: Expansion factor for horizontal axis labels.
    # vertical_label_srt: Rotation angle of vertical labels in degrees.
    # vertical_label_cex: Expansion factor for vertical axis labels.
    # left_margin: Numeric value to adjust the left margin size.
    # top_margin: Numeric value to adjust the top margin size.
    # main_diagonal_highlighting: Specifies highlighting of the main
    #                             diagonal. Options are "framebox", "color",
    #                             "both", or "none":
    #        "framebox" - Puts a frame around the main diagonal.
    #        "color" - Colors the main diagonal using 'rgb_code_highlighting'.
    #        "both" - Applies both frame and color to the main diagonal.
    #        "none" - No special highlighting applied.
    # rgb_code_highlighting: RGB values for highlighting, used when
    #                        'main_diagonal_highlighting' involves "color"
    #                        or "both".
    # rgb_code_highlighting_framebox: RGB values for the frame box.
    # highlighting_framebox_lwd: Line width of the frame box used in
    #                            highlighting.
    # n_of_parallel_diagonals_to_highlight: Number of diagonals parallel
    #        to the main diagonal to highlight. Should be non-negative.
    # percentage_display: Logical, if TRUE, displays values as percentages.
    # percentage_round_digits: Decimal places for rounding percentages.
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
        ! color %in% c("grey_scaled", "rgb_scaled")
    ){
        
        stop(
            paste(
                "Argument 'color' must equal either to 'grey_scaled', ",
                "or 'rgb_scaled'",
                sep = ""
            )
        )
        
    }
    
    for(
        my_argument_name in c(
            
            "rgb_code",
            "rgb_code_highlighting",
            "rgb_code_highlighting_framebox"
            
        )
    ){
        
        my_argument <- get(my_argument_name)
        
        if(
            missing(my_argument)
        ){
            
            stop(
                paste(
                    "Argument '",
                    my_argument_name,
                    "' is missing with no default!",
                    sep = ""
                )
            )
            
        }
        
        if(
            length(my_argument) != 3
        ){
            
            stop(
                paste(
                    "Length of argument '",
                    my_argument_name,
                    "' must be 3!",
                    sep = ""
                )
            )
            
        }
        
        if(
            ! is.numeric(my_argument[1]) |
            ! is.numeric(my_argument[2]) |
            ! is.numeric(my_argument[3])
        ){
            
            stop(
                paste(
                    "Argument '",
                    my_argument_name,
                    "' must contain three numbers each from interval ",
                    "of <0, 1>!",
                    sep = ""
                )
            )
            
        }
        
        if(
            (my_argument[1] < 0 | my_argument[1] > 1) |
            (my_argument[2] < 0 | my_argument[2] > 1) |
            (my_argument[3] < 0 | my_argument[3] > 1)
        ){
            
            stop(
                paste(
                    "Argument '",
                    my_argument_name,
                    "' must contain three numbers each from interval ",
                    "of <0, 1>!",
                    sep = ""
                )
            )
            
        }
        
    }
    
    if(
        missing(class_labels)
    ){
        
        class_labels <- paste(
            "class",
            as.character(
                1:dim(table)[1]
            ),
            sep = "_"
        )
        
    }
    
    if(
        length(class_labels) != dim(table)[1]
    ){
        
        stop(
            paste(
                "Argument 'class_labels' must have the same length ",
                "as the dimension of confusion matrix 'table'!",
                sep = ""
            )
        )
        
    }
    
    rownames(table) <- class_labels
    colnames(table) <- class_labels
    
    if(
        missing(horizontal_label)
    ){
        
        horizontal_label <- "horizontal_label"
        
    }
    
    if(
        missing(vertical_label)
    ){
        
        vertical_label <- "vertical_label"
        
    }
    
    if(
        ! main_diagonal_highlighting %in% c(
            
            "framebox",
            "color",
            "both",
            "none"
            
        )
    ){
        
        stop(
            paste(
                "Argument 'main_diagonal_highlighting' must equal either to ",
                "'framebox', ",
                "'color', ",
                "or 'none'!",
                sep = ""
            )
        )
        
    }
    
    for(
        my_argument_name in c(
            
            "label_half_width",
            "label_offset_factor",
            "horizontal_label_srt",
            "horizontal_label_cex",
            "vertical_label_srt",
            "vertical_label_cex",
            "left_margin",
            "top_margin",
            "highlighting_framebox_lwd",
            "n_of_parallel_diagonals_to_highlight",
            "percentage_round_digits"
            
        )
    ){
        
        my_argument <- get(my_argument_name)
        
        if(
            missing(my_argument)
        ){
            
            stop(
                paste(
                    "Argument '",
                    my_argument_name,
                    "' is missing with no default!",
                    sep = ""
                )
            )
            
        }
        
        if(
            ! is.numeric(my_argument)
        ){
            
            stop(
                paste(
                    "Argument '",
                    my_argument_name,
                    "' must be a number!",
                    sep = ""
                )
            )
            
        }
        
    }
    
    if(
        n_of_parallel_diagonals_to_highlight < 0 |
        n_of_parallel_diagonals_to_highlight > dim(table)[1] - 1
    ){
        
        stop(
            paste(
                "Argument 'n_of_parallel_diagonals_to_highlight' ",
                "must be a non-negative integer lower than the dimension ",
                "of confusion matrix 'table'!",
                sep = ""
            )
        )
        
    }
    
    if(
        missing(percentage_display)
    ){
        
        stop(
            "Argument 'percentage_display' is missing with no default!"
        )
        
    }
    
    if(
        ! percentage_display %in% c(TRUE, FALSE)
    ){
        
        stop(
            paste(
                "Argument 'percentage_display' must equal either to 'TRUE', ",
                "or 'FALSE'",
                sep = ""
            )
        )
        
    }
    
    ## main function body -----------------------------------------------------
    
    par(
        mar = c(
            0.1,
            left_margin + 0.1 + label_offset_factor * label_half_width,
            top_margin + 0.1 + label_offset_factor * label_half_width,
            0.1
        )
    )
    par(xpd = TRUE)
    
    plot(
        0,
        xlim = c(0, dim(table)[1]),
        ylim = c(0, dim(table)[2]),
        type = "n",
        axes = FALSE,
        ann = FALSE
    )
    
    for(
        i in 1:dim(table)[1]
    ){
        
        for(
            j in 1:dim(table)[2]
        ){
            
            rect(
                xleft = j - 1,
                ybottom = dim(table)[1] - i,
                xright = j,
                ytop = dim(table)[1] - i + 1,
                col = if(
                    color == "grey_scaled"
                ){
                    
                    grey(
                        0.9 - 0.8 * (
                            table[i, j] / sum(table)
                        ) ** (1 / 2)
                    )
                    
                }else{
                    
                    if(
                        color == "rgb_scaled"
                    ){
                        
                        if(
                            main_diagonal_highlighting %in% c(
                                
                                "color",
                                "both"
                                
                            ) & abs(
                                (j - 1) - (i - 1)
                            ) <= n_of_parallel_diagonals_to_highlight
                        ){
                            
                            rgb(
                                rgb_code_highlighting[1],
                                rgb_code_highlighting[2],
                                rgb_code_highlighting[3],
                                0.1 + 0.8 * (
                                    table[i, j] / sum(table)
                                ) ** (1 / 2)
                            )
                            
                        }else{
                            
                            rgb(
                                rgb_code[1],
                                rgb_code[2],
                                rgb_code[3],
                                0.1 + 0.8 * (
                                    table[i, j] / sum(table)
                                ) ** (1 / 2)
                            )
                            
                        }
                        
                    }
                    
                },
                border = NA
                
            )
            
            text(
                x = j - 0.5,
                y = dim(table)[1] - i + 0.5,
                labels = if(
                    percentage_display
                ){
                    
                    paste(
                        format(
                            round(
                                table[i, j] / sum(table) * 100,
                                digits = percentage_round_digits
                            ),
                            nsmall = percentage_round_digits
                        ),
                        " %",
                        sep = ""
                    )
                    
                }else{
                    
                    table[i, j]
                    
                }
                
            )
            
        }
        
    }
    
    text(
        x = - label_offset_factor * label_half_width,
        # 1.1 * (
            # -(max(unlist(lapply(class_labels, nchar))) / 12)
        # ),
        y = dim(table)[1] / 2 - 0.15,
        labels = horizontal_label,
        adj = 0.5,
        pos = 3,
        srt = 90,
        cex = 1.0
    )
    
    for(
        my_rowname in rownames(table)
    ){
        
        text(
            x = -label_half_width,
            # -(max(unlist(lapply(class_labels, nchar))) / 12),
            y = dim(table)[2]
                - which(rownames(table) == my_rowname) + 0.35,
            labels = my_rowname,
            adj = 0.5,
            pos = 3,
            srt = horizontal_label_srt,
            cex = horizontal_label_cex
        )
        
    }
    
    text(
        x = dim(table)[2] / 2,
        y = dim(table)[2] + label_offset_factor * label_half_width,
        # 1.1 * (
            # dim(table)[2] + (
                # max(unlist(lapply(class_labels, nchar))) / 12
            # )
        # ),
        labels = vertical_label,
        adj = 0.5,
        pos = 3,
        cex = 1.0
    )
    
    for(
        my_colname in colnames(table)
    ){
        
        text(
            x = which(colnames(table) == my_colname) - 0.45,
            y = dim(table)[2] + label_half_width,
            # dim(table)[2] + (
                # max(unlist(lapply(class_labels, nchar))) / 12
            # ),
            labels = my_colname,
            adj = 0.5,
            pos = 3,
            srt = vertical_label_srt,
            cex = vertical_label_cex
        )
        
    }
    
    if(
        main_diagonal_highlighting %in% c("framebox", "both")
    ){
        
        #par(xpd = FALSE)
        
        segments(
            x0 = 0,
            y0 = dim(table)[1],
            x1 = 1 + n_of_parallel_diagonals_to_highlight,
            y1 = dim(table)[1],
            lwd = highlighting_framebox_lwd
        )
        
        segments(
            x0 = 0,
            y0 = dim(table)[1],
            x1 = 0,
            y1 = dim(table)[1] - (
                1 + n_of_parallel_diagonals_to_highlight
            ),
            lwd = highlighting_framebox_lwd
        )
        
        segments(
            x0 = dim(table)[1] - (
                1 + n_of_parallel_diagonals_to_highlight
            ),
            y0 = 0,
            x1 = dim(table)[1],
            y1 = 0,
            lwd = highlighting_framebox_lwd
        )
        
        segments(
            x0 = dim(table)[1],
            y0 = (
                1 + n_of_parallel_diagonals_to_highlight
            ),
            x1 = dim(table)[1],
            y1 = 0,
            lwd = highlighting_framebox_lwd
        )
        
        for(
            i in (
                1 + n_of_parallel_diagonals_to_highlight
            ):(dim(table)[1] - 1)
        ){
            
            segments(
                x0 = i,
                y0 = min(
                    dim(table)[1] - (
                        i - n_of_parallel_diagonals_to_highlight - 1
                    ),
                    dim(table)[1]
                ),
                x1 = i,
                y1 = dim(table)[1] - (
                    i - n_of_parallel_diagonals_to_highlight
                ),
                lwd = highlighting_framebox_lwd
            )
            
            segments(
                x0 = i,
                y0 = dim(table)[1] - (
                    i - n_of_parallel_diagonals_to_highlight
                ),
                x1 = min(
                    i + 1,
                    dim(table)[1]
                ),
                y1 = dim(table)[1] - (
                    i - n_of_parallel_diagonals_to_highlight
                ),
                lwd = highlighting_framebox_lwd
            )
            
            segments(
                x0 = max(
                    (
                        i - n_of_parallel_diagonals_to_highlight - 1
                    ),
                    0
                ),
                y0 = dim(table)[1] - i,
                x1 = (
                    i - n_of_parallel_diagonals_to_highlight
                ),
                y1 = dim(table)[1] - i,
                lwd = highlighting_framebox_lwd
            )
            
            segments(
                x0 = (
                    i - n_of_parallel_diagonals_to_highlight
                ),
                y0 = dim(table)[1] - i,
                x1 = (
                    i - n_of_parallel_diagonals_to_highlight
                ),
                y1 = max(
                    dim(table)[1] - (i + 1),
                    0
                ),
                lwd = highlighting_framebox_lwd
            )
            
        }
        
    }
    
}


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





