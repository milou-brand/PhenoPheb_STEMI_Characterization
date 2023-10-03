#install.packages("remotes")
#remotes::install_github("ohdsi/Characterization")
#remotes::install_github("ohdsi/FeatureExtraction")

library(Characterization)
library(dplyr)

exampleTargetIds <- c(1,2,4)
exampleOutcomeIds <- 3

exampleCovariateSettings <- FeatureExtraction::createCovariateSettings(
  useDemographicsGender = T,
  useDemographicsAge = T,
  useCharlsonIndex = T
)

exampleAggregateCovariateSettings <- createAggregateCovariateSettings(
  targetIds = exampleTargetIds,
  outcomeIds = exampleOutcomeIds,
  riskWindowStart = 1, startAnchor = 'cohort start',
  riskWindowEnd = 365, endAnchor = 'cohort start',
  covariateSettings = exampleCovariateSettings
)

agc <- computeAggregateCovariateAnalyses(
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = 'main',
  cdmVersion = 5,
  targetDatabaseSchema = 'main',
  targetTable = 'cohort',
  aggregateCovariateSettings = exampleAggregateCovariateSettings,
  databaseId = 'Eunomia', 
  runId = 1
)

agc$covariates %>% 
  collect() %>%
  kableExtra::kbl() 