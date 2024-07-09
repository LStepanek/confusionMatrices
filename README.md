# Summary 
An `R` package `confusionMatrices` enables plotting confusion matrices, highlighting their main and parallel diagonals and calculation performance metrics.

# Installation

```
library(devtools)
devtools::install_github("LStepanek/confusionMatrices")
library(confusionMatrices)
```


# Examples

Below are several examples that demonstrate the usage of the plotConfusionMatrix function. Each example progressively introduces more complexity and highlights different features of the function.


## Example 1: Basic Usage

This simple example demonstrates the default usage of the function with a basic confusion matrix, utilizing default color scaling and no highlighting.

```
# Define a basic confusion matrix
basic_table <- matrix(
    c(10, 2, 3, 0,
      0, 15, 0, 1,
      0, 1, 20, 2,
      1, 0, 3, 18),
    nrow = 4,
    byrow = TRUE,
    dimnames = list(
        observed = c("class_1", "class_2", "class_3", "class_4"),
        predicted = c("class_1", "class_2", "class_3", "class_4")
    )
)

# Plot the basic confusion matrix
plotConfusionMatrix(
    table = basic_table,
    color = "grey_scaled",
    main_diagonal_highlighting = "none",
    percentage_display = FALSE
)
```


## Example 2: Adding Color and Labels

This example uses RGB color scaling and adds custom labels to the axes, making it slightly more complex and visually distinct.

```
plotConfusionMatrix(
    table = basic_table,
    color = "rgb_scaled",
    rgb_code = c(0.2, 0.5, 0.7),
    horizontal_label = "Actual Classes",
    vertical_label =  "Predicted Classes",
    main_diagonal_highlighting = "none",
    percentage_display = FALSE
)
```


## Example 3: Highlighting and Class Labels

This example introduces diagonal highlighting and custom class labels, showcasing the function's capability to emphasize specific parts of the matrix and label classes differently.

```
plotConfusionMatrix(
    table = basic_table,
    color = "rgb_scaled",
    rgb_code = c(0.6, 0.1, 0.1),
    class_labels = c("Type 1", "Type 2", "Type 3", "Type 4"),
    main_diagonal_highlighting = "color",
    rgb_code_highlighting = c(1, 0, 0),
    percentage_display = FALSE
)
```


## Example 4: Comprehensive Customization

This final example uses a comprehensive set of customizations, including highlighting multiple diagonals, displaying percentages, and adjusting text and frame properties, representing the most complex use case.

```
# Define a larger, more complex confusion matrix
complex_table <- matrix(
    c(30, 5, 2, 1, 0,
      3, 40, 0, 2, 1,
      0, 2, 50, 3, 2,
      1, 0, 4, 45, 5,
      0, 1, 2, 5, 35),
    nrow = 5,
    byrow = TRUE,
    dimnames = list(
        observed = c("class_A", "class_B", "class_C", "class_D", "class_E"),
        predicted = c("class_A", "class_B", "class_C", "class_D", "class_E")
    )
)

# Plot the complex matrix with extensive customizations
plotConfusionMatrix(
    table = complex_table,
    color = "rgb_scaled",
    rgb_code = c(0, 0.4, 0.8),
    class_labels = c("Alpha", "Beta", "Gamma", "Delta", "Epsilon"),
    main_diagonal_highlighting = "both",
    rgb_code_highlighting = c(0.8, 0.2, 0.2),
    rgb_code_highlighting_framebox = c(0, 0, 0),
    highlighting_framebox_lwd = 2.0,
    n_of_parallel_diagonals_to_highlight = 1,
    percentage_display = TRUE,
    percentage_round_digits = 2,
    horizontal_label = "True Category",
    vertical_label = "Predicted Category",
    horizontal_label_cex = 0.8,
    vertical_label_cex = 0.8,
    left_margin = 6.0,
    top_margin = 6.0
)
```

These examples start from very basic usage and move towards increasingly complex scenarios, demonstrating the flexibility and powerful visualization capabilities of the plotConfusionMatrix function.
