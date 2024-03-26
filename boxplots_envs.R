library(ggplot2)
library(plotly)
library(jsonlite)

# jsonStr contains json data passed in from javascript environment
data <- fromJSON(jsonStr)
obs <- data$data
obs$value <- as.numeric(obs$value)

# Remove rows with NA in the value column after the conversion
df_filtered <- obs %>% filter(!is.na(value))

# Now, plot using ggplot2
p <- ggplot(df_filtered, aes(x = value, fill = additionalInfo$studyName)) +
  geom_boxplot() +
  facet_wrap(~ observationVariableName, scales = "free") +
  labs(title = "Boxplots for Each Numeric Observation Variable",
       x = "Value",
       y = "Environment",
       fill = "Environment")

plotly_json(p, pretty = FALSE)