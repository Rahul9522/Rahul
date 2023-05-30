library(dplyr)
library(tidyr)
library(stringr)
data <- read.csv("C:/Users/Admin/OneDrive/Desktop/Rahul/your_dataset.csv")
summary(data)
continuous_vars <- c("var1", "var2", "var3")
for (var in continuous_vars) {
  if (sum(is.na(data[, var]))) {
    if (is.numeric(data[[var]])) {
      data[is.na(data[, var]), var] <- mean(data[[var]], na.rm = TRUE)
    } else {
      data[is.na(data[, var]), var] <- median(data[[var]], na.rm = TRUE)
    }
  }
}
categorical_vars <- c("var4", "var5", "var6")
for (var in categorical_vars) {
  if (sum(is.na(data[, var]))) {
    mode_val <- names(which.max(table(data[[var]])))
    data[is.na(data[, var]), var] <- mode_val
  }
}
data$text_column <- str_replace_all(data$text_column, "\\b(?:the|and|or|but|is)\\b", "")
cleaned_data <- data
write.csv(cleaned_data, "cleaned_dataset1.csv", row.names = FALSE)
