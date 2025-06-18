# Load required libraries
library(tidyverse)  # For data manipulation and visualization

# Load the dataset
data <- read_csv("/kaggle/input/diabetes-health-indicators-dataset/diabetes_binary_5050split_health_indicators_BRFSS2015.csv", show_col_types = FALSE)

# Check for missing values
cat("Missing Values Check:\n")
print(colSums(is.na(data)))  # No missing values expected in this dataset

# Convert categorical variables to factors
data <- data %>%
  mutate(
    Diabetes_binary = as.factor(Diabetes_binary),
    Sex = as.factor(Sex),
    Smoker = as.factor(Smoker),
    HighBP = as.factor(HighBP),
    HighChol = as.factor(HighChol),
    PhysActivity = as.factor(PhysActivity)
  )

# Summary statistics
cat("\nDescriptive Statistics of Variables:\n")
print(summary(data))


# Fit logistic regression model
cat("\n=== Logistic Regression Model ===\n")
cat("Model: Predicting Diabetes with Health Indicators\n")
# Predictors chosen based on health indicators relevant to diabetes
model <- glm(
  Diabetes_binary ~ Age + BMI + Sex + HighBP + HighChol + Smoker + PhysActivity,
  family = binomial(link = "logit"),
  data = data
)

# Summary of the model
summary(model)

cat("\n=== Odds Ratios ===\n")
# Calculate odds ratios
odds_ratios <- exp(coef(model))
results <- cbind(odds_ratios)
print(results)

# Fit logistic regression model with interaction term
model_interaction <- glm(
  Diabetes_binary ~ Age * BMI + Sex + HighBP + HighChol + Smoker + PhysActivity,
  family = binomial(link = "logit"),
  data = data
)

# Display summary to check interaction term significance
summary(model_interaction)

# Load required library
library(stats)

# Calculate OR for BMI at different ages
beta_bmi <- log(1.094231269)  # From main effect
beta_interaction <- 0.0045964  # Hypothetical interaction term
ages <- c(30, 50,70)
or_bmi <- exp(beta_bmi + beta_interaction * ages)
names(or_bmi) <- paste("Age", ages)
print("Odds Ratios for BMI at different ages:")
print(or_bmi)

install.packages("pROC")
library(pROC)       # For ROC curve and AUC


# Model diagnostics
cat("\n=== Model Performance: ROC and AUC ===\n")
# Predict probabilities
data$predicted_prob <- predict(model, type = "response")

# ROC curve and Area Under the Curve (AUC)
roc_obj <- roc(data$Diabetes_binary, data$predicted_prob)
auc_value <- auc(roc_obj)
cat("Area Under the ROC Curve (AUC):", auc_value, "\n")
plot(roc_obj, main = "ROC Curve for Logistic Regression Model")
