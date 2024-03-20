# Confusion matrices of any size with number-based color intensities visualized easily with R using `confusionMatrices()` function!
 
A confusion matrix is a crucial tool in evaluating predictive models and comparing predicted values against actual observations. While R offers several packages such as caret, mlearning, ConfusionTableR, and others for constructing confusion matrices, customization options for color representations are often limited, although asked in papers and reports both by publication and business practice. Common methods like heatmap(), called on top of the table() function, can produce misleading color shades that do not accurately reflect the underlying data. Other solutions may require extensive coding and user-own-defined fingers-on solutions, such as using ggplot2 or similar packages, and may be time-consuming. To address this gap, we have developed a versatile graphical function that allows users to easily customize the visualization of confusion matrices with just a single line of code when called. This function can be seamlessly integrated into R workflows and has the potential to be further developed into a standalone R package for broader use. The source code and examples for this functionality can be found on our GitHub repository, https://github.com/lstepanek/confusionMatrices.


<p align="center">
  <img src="https://raw.githubusercontent.com/LStepanek/confusionMatrices/main/confusion_matrices.png">
</p>

(examples of confusion matrices created using `confusionMatrices()` function)


```
###############################################################################
###############################################################################
###############################################################################

## I am saving statistics about the predictive accuracies of the
## individual models ----------------------------------------------------------

setwd(
    paste(
        mother_working_directory,
        "cermat_english_matura_difficulty_classification_(for_paper)",
        "outputs",
        sep = "/"
    )
)

if(
    file.exists("predictive_accuracies.txt")
){
    invisible(
        file.remove("predictive_accuracies.txt")
    )
}

for(
    my_difficulty in my_codebook[
        my_codebook[, "response_type"] == "dependent" &
        my_codebook[, "to_omit"] != "#",
        "variable_name"
    ]
){
    
    sink(
        file = "predictive_accuracies.txt",
        append = TRUE
    )
    
    cat(
        paste(
            "####################",
            "####################",
            "####################",
            "####################\n",
            "####################",
            "####################",
            "####################",
            "####################\n",
            "####################",
            "####################",
            "####################",
            "####################\n",
            sep = ""
        )
    )
    
    #cat("\n")
    
    cat("\n")
    cat(
        paste(
            "difficulty: ",
            my_difficulty,
            sep = ""
            
        )
    )
    cat("\n")    
    cat("\n")
    cat("\n")
    
    for(
        my_name in names(my_predictive_accuracy_list)[
            grepl(
                paste(
                    my_difficulty,
                    "$",
                    sep = ""
                ),
                names(my_predictive_accuracy_list)
            )
        ]
    ){
        
        cat(
            gsub(
                "_",
                " ",
                gsub(
                    paste(
                        my_difficulty,
                        "$",
                        sep = ""
                    ),
                    "",
                    my_name
                )
            )
        )
        
        cat("\n")
        cat("\n")
        
        cat("-- predictive accuracies")
        cat("\n")
        print(
            summary(
                my_predictive_accuracy_list[[my_name]][[
                    "predictive_accuracies"
                ]]
            )
        )
        
        cat("\n")
        
        cat("-- extended predictive accuracies")
        cat("\n")
        print(
            summary(
                my_predictive_accuracy_list[[my_name]][[
                    "extended_predictive_accuracies"
                ]]
            )
        )
        
        cat("\n")
        #cat("\n")
        #cat("\n")
        
        cat("-- summative confusion matrix")
        cat("\n")
        
        my_table <- my_predictive_accuracy_list[[my_name]][[
            "confusion_matrices"
        ]][[1]]
        
        if(
            length(
                my_predictive_accuracy_list[[my_name]][[
                    "confusion_matrices"
                ]]
            ) > 1
        ){
            
            for(
                i in 2:length(
                    my_predictive_accuracy_list[[my_name]][[
                        "confusion_matrices"
                    ]]
                )
            ){
                
                my_table <- my_table + 
                    my_predictive_accuracy_list[[my_name]][[
                        "confusion_matrices"
                    ]][[i]]
                
            }
            
        }
        
        print(
            my_table
        )
        
        cat("\n")
        
        cat("-- sum of summative confusion matrix")
        cat("\n")
        
        cat(
            sum(
                my_table
            )
        )
        
        cat("\n")
        cat("\n")
        
        cat(
            paste(
                "## -----------------",
                "--------------------",
                "--------------------",
                "--------------------\n",
                sep = ""
            )
        )
        
        cat("\n")
        
    }
    
    sink()
    
    
    ## ------------------------------------------------------------------------
    
}


for(
    my_difficulty in my_codebook[
        my_codebook[, "response_type"] == "dependent" &
        my_codebook[, "to_omit"] != "#",
        "variable_name"
    ]
){
    
    for(
        my_name in names(my_predictive_accuracy_list)[
            grepl(
                paste(
                    my_difficulty,
                    "$",
                    sep = ""
                ),
                names(my_predictive_accuracy_list)
            )
        ]
    ){
        
        my_table <- my_predictive_accuracy_list[[my_name]][[
            "confusion_matrices"
        ]][[1]]
        
        if(
            length(
                my_predictive_accuracy_list[[my_name]][[
                    "confusion_matrices"
                ]]
            ) > 1
        ){
            
            for(
                i in 2:length(
                    my_predictive_accuracy_list[[my_name]][[
                        "confusion_matrices"
                    ]]
                )
            ){
                
                my_table <- my_table + 
                    my_predictive_accuracy_list[[my_name]][[
                        "confusion_matrices"
                    ]][[i]]
                
            }
            
        }
        
        cairo_ps(
            file = paste(
                my_name,
                "_summative_confusion_table",
                ".eps",
                sep = ""
            ),
            width = 6.0,
            height = 6.0,
            pointsize = 14
        )
        
        par(mar = c(0.1, 6.5, 6.5, 0.1), xpd = TRUE)
        
        plot(
            0,
            xlim = c(0, dim(my_table)[1]),
            ylim = c(0, dim(my_table)[2]),
            type = "n",
            axes = FALSE,
            ann = FALSE
        )
        
        for(
            i in 1:dim(my_table)[1]
        ){
            
            for(
                j in 1:dim(my_table)[2]
            ){
                
                rect(
                    xleft = j - 1,
                    ybottom = dim(my_table)[1] - i,
                    xright = j,
                    ytop = dim(my_table)[1] - i + 1,
                    col = grey(
                        0.9 - 0.8 * (my_table[i, j] / sum(my_table)) ** (1 / 2)
                    ),
                    border = NA
                )
                
                text(
                    x = j - 0.5,
                    y = dim(my_table)[1] - i + 0.5,
                    labels = my_table[i, j]
                )
                
            }
            
        }
        
        text(
            x = -1.8,
            y = dim(my_table)[1] / 2 - 0.15,
            labels = "'true' class",
            adj = 0.5,
            pos = 3,
            srt = 90,
            cex = 1.0
        )
        
        for(
            my_rowname in rownames(my_table)
        ){
            
            text(
                x = -0.80,
                y = dim(my_table)[2]
                    - which(rownames(my_table) == my_rowname) + 0.35,
                labels = c(
                    "very easy",
                    "easy",
                    "moderate",
                    "difficult",
                    "very difficult"
                )[
                    which(
                        rownames(my_table) == my_rowname
                    )
                ],
                #my_rowname,
                adj = 0.5,
                pos = 3,
                srt = 0,
                cex = 1.0
            )
            
        }
        
        text(
            x = dim(my_table)[2] / 2,
            y = dim(my_table)[2] + 1.20,
            labels = "predicted class",
            adj = 0.5,
            pos = 3,
            cex = 1.0
        )
        
        for(
            my_colname in colnames(my_table)
        ){
            
            text(
                x = which(colnames(my_table) == my_colname) - 0.45,
                y = dim(my_table)[2] + 0.40,
                labels = c(
                    "very easy",
                    "easy",
                    "moderate",
                    "difficult",
                    "very difficult"
                )[
                    which(
                        colnames(my_table) == my_colname
                    )
                ],
                #my_colname,
                adj = 0.5,
                pos = 3,
                srt = 45,
                cex = 1.0
            )
            
        }
        
        text(
            x = -1.60,
            y = dim(my_table)[2] + 1.70,
            labels = gsub(
                "_",
                " ",
                gsub(
                    paste("(.*)(_", my_difficulty, ")", "$", sep = ""),
                    "\\1",
                    my_name
                )
            ),
            adj = 0.5,
            pos = 4,
            cex = 1.2
        )
        
        dev.off()
        
    }
    
    ## ------------------------------------------------------------------------
    
}

setwd(
    mother_working_directory
)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################
```





