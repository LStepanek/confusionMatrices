# Confusion matrices of any size with number-based color intensities visualized easily with R using `confusionMatrices()` function!
 
A confusion matrix is a crucial tool in evaluating predictive models and comparing predicted values against actual observations. While R offers several packages such as caret, mlearning, ConfusionTableR, and others for constructing confusion matrices, customization options for color representations are often limited, although asked in papers and reports both by publication and business practice. Common methods like heatmap(), called on top of the table() function, can produce misleading color shades that do not accurately reflect the underlying data. Other solutions may require extensive coding and user-own-defined fingers-on solutions, such as using ggplot2 or similar packages, and may be time-consuming. To address this gap, we have developed a versatile graphical function that allows users to easily customize the visualization of confusion matrices with just a single line of code when called. This function can be seamlessly integrated into R workflows and has the potential to be further developed into a standalone R package for broader use. The source code and examples for this functionality can be found on our GitHub repository, https://github.com/lstepanek/confusionMatrices.


<p align="center">
  <img src="https://raw.githubusercontent.com/LStepanek/confusionMatrices/main/confusion_matrices.png">
</p>

(examples of confusion matrices created using `confusionMatrices()` function)
