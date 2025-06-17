# Statistical Analysis and Modeling for BRFSS Data

This repository contains an R notebook and presentation exploring diabetes risk factors using the 2015 Behavioral Risk Factor Surveillance System (BRFSS) health indicators. The analysis focuses on how common risk factors relate to diabetes and prediabetes prevalence in U.S. adults.

## Contents

- `statistical-analysis-and-modelling.ipynb` – R notebook performing data cleaning, visualization and logistic regression modelling.
- `Understanding-Diabetes-Risk-Factors.pdf` – accompanying slides summarizing the key findings.

## Data

The notebook expects the dataset `diabetes_binary_5050split_health_indicators_BRFSS2015.csv` from Kaggle's "Diabetes Health Indicators" collection. In the notebook it is loaded from:

```
/kaggle/input/diabetes-health-indicators-dataset/diabetes_binary_5050split_health_indicators_BRFSS2015.csv
```

You can adjust the path to match where you place the CSV locally.

## Analysis Overview

1. **Initial Data Exploration** – Descriptive statistics and visualizations for BMI, age, blood pressure and cholesterol.
2. **Logistic Regression** – Models diabetes status as a function of age, BMI, sex, high blood pressure, high cholesterol, smoking and physical activity.
3. **Effect Modification** – Explores an interaction between age and BMI.
4. **Model Diagnostics** – Evaluates performance using the ROC curve and AUC (about 0.79).

From the model, high blood pressure and high cholesterol roughly double the odds of diabetes. Increasing age, BMI, male sex and smoking all raise the odds, while physical activity lowers them. The age–BMI interaction suggests BMI has a stronger effect at older ages.

## Running the Notebook

Open `statistical-analysis-and-modelling.ipynb` in a Jupyter environment with R installed. The following R packages are used:

- `tidyverse`
- `car`
- `pROC`
- `stats`

Run the cells sequentially to reproduce the plots and model output. Generated figures (e.g., `diabetes_binary_barplot.png`) are saved in the working directory.

## Presentation

`Understanding-Diabetes-Risk-Factors.pdf` provides a short slide deck highlighting the motivation, methodology and main conclusions of the analysis.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
