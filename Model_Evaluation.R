# Load additional libraries for evaluation
library(caret)
library(pROC)
library(lattice)

# Set seed for reproducibility
set.seed(123)

# Train-Test Split
cat("\n=== Model Evaluation: Train-Test Split ===\n")
train_index <- createDataPartition(data$Diabetes_binary, p = 0.75, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Fit model on training data (same predictors as your original model)
model_train <- glm(Diabetes_binary ~ Age + Sex + BMI + HighBP + HighChol + Smoker + PhysActivity,
                   family = binomial(link = "logit"), data = train_data)

# Predict on test data
test_data$predicted_prob <- predict(model_train, newdata = test_data, type = "response")

# ROC and AUC for test data
roc_test <- roc(test_data$Diabetes_binary, test_data$predicted_prob)
auc_test <- auc(roc_test)
cat("Test Set AUC:", auc_test, "\n")
plot(roc_test, main = "ROC Curve for Test Set")


# Fix factor levels for Diabetes_binary to be valid R variable names
cat("\n=== Fixing Factor Levels for Diabetes_binary ===\n")
data$Diabetes_binary <- as.factor(data$Diabetes_binary)
levels(data$Diabetes_binary) <- make.names(levels(data$Diabetes_binary)) # Convert to valid names
cat("Updated levels for Diabetes_binary:\n")
print(levels(data$Diabetes_binary))

# 5-Fold Cross-Validation (k=5) with classProbs = TRUE
cat("\n=== Model Evaluation: 5-Fold Cross-Validation ===\n")
set.seed(123) # For reproducibility
cv_control <- trainControl(
  method = "cv",
  number = 5,
  summaryFunction = twoClassSummary,
  classProbs = TRUE # Enable class probabilities for ROC
)
cv_results <- train(
  Diabetes_binary ~ Age + Sex + BMI + HighBP + HighChol + Smoker + PhysActivity,
  data = data,
  method = "glm",
  family = "binomial",
  trControl = cv_control,
  metric = "ROC"
)

# Extract and display cross-validated AUC
cv_auc <- cv_results$results$ROC
cat("Cross-Validated AUC:", cv_auc, "\n")
print(cv_results$results)