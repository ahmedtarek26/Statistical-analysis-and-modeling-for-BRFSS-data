# Load required libraries
library(tidyverse)  # For data manipulation and visualization

# Step 1: Load the dataset
data <- read_csv("/kaggle/input/diabetes-health-indicators-dataset/diabetes_binary_5050split_health_indicators_BRFSS2015.csv", show_col_types = FALSE)

# Step 2: Preprocess the data for visualization
cat("\n=== Data Preprocessing ===\n")
data <- data %>%
  mutate(
    Diabetes_binary = as.factor(dplyr::recode(as.character(Diabetes_binary),  # Convert to character first
                                              "0" = "No Diabetes",
                                              "1" = "Diabetes/Prediabetes")),
    Sex = as.factor(ifelse(Sex == 0, "Female", "Male")),  # Recode for readability
    HighBP = as.factor(ifelse(HighBP == 0, "No High BP", "High BP")),  # Recode for readability
    HighChol = as.factor(ifelse(HighChol == 0, "No High Chol", "High Chol"))  # Recode for readability
  )

# Verify preprocessing
cat("Preview of Preprocessed Data:\n")
print(head(data))

# Graph 1 - Bar Plot of Diabetes Status Distribution
cat("\n=== Graph 1: Distribution of Diabetes Status ===\n")
ggplot(data, aes(x = Diabetes_binary, fill = Diabetes_binary)) +
  geom_bar() +
  labs(
    title = "Distribution of Diabetes Status in BRFSS 2015 (50/50 Split)",
    x = "Diabetes Status",
    y = "Count",
    fill = "Diabetes Status"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")
ggsave("diabetes_binary_barplot.png")

# Graph 2 - Histogram of BMI by Diabetes Status
cat("\n=== Graph 2: BMI Distribution by Diabetes Status ===\n")
ggplot(data, aes(x = BMI, fill = Diabetes_binary)) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  labs(
    title = "BMI Distribution by Diabetes Status",
    x = "Body Mass Index (BMI)",
    y = "Count",
    fill = "Diabetes Status"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")
ggsave("bmi_histogram_binary.png")

# Graph 3 - Boxplot of Age by Diabetes Status
cat("\n=== Graph 3: Age Distribution by Diabetes Status ===\n")
ggplot(data, aes(x = Diabetes_binary, y = Age, fill = Diabetes_binary)) +
  geom_boxplot() +
  labs(
    title = "Age Distribution by Diabetes Status",
    x = "Diabetes Status",
    y = "Age (Categorical Scale)",
    fill = "Diabetes Status"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")
ggsave("age_boxplot_binary.png")

# Graph 4 - Stacked Bar Plot of HighCol and Sex by Diabetes Status
cat("\n=== Graph 4: High Cholestrol  and Sex by Diabetes Status ===\n")
ggplot(data, aes(x = Sex, fill = HighChol)) +
  geom_bar(position = "fill") +
  facet_wrap(~Diabetes_binary) +
  labs(
    title = "Proportion of High Cholestrol by Sex and Diabetes Status",
    x = "Sex",
    y = "Proportion",
    fill = "High Cholestrol "
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")
ggsave("highchol_sex_stacked_barplot_binary.png")

# Graph 5 - Stacked Bar Plot of HighBP and Sex by Diabetes Status
cat("\n=== Graph 4: High Blood Pressure and Sex by Diabetes Status ===\n")
ggplot(data, aes(x = Sex, fill = HighBP)) +
  geom_bar(position = "fill") +
  facet_wrap(~Diabetes_binary) +
  labs(
    title = "Proportion of High Blood Pressure by Sex and Diabetes Status",
    x = "Sex",
    y = "Proportion",
    fill = "High Blood Pressure"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")
ggsave("highbp_sex_stacked_barplot_binary.png")

# Step 8: Notes on Graphs
cat("\n=== Notes on Visualizations ===\n")
cat("Graphs saved as PNG files in working directory.\n")
cat("Key insights:\n")
cat("- Bar plot shows balanced 50/50 split between No Diabetes and Diabetes/Prediabetes.\n")
cat("- BMI histogram indicates higher BMI in Diabetes/Prediabetes group.\n")
cat("- Age boxplot shows older age associated with Diabetes/Prediabetes.\n")
cat("- Stacked bar plot highlights higher prevalence of HighBP in Diabetes/Prediabetes group.\n")