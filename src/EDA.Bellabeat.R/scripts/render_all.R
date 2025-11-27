# scripts/render_all.R

# -------------------------------------------------------------------
# Génération des rapports HTML et PDF pour 01_Bellabeat_Data_Profiling_EDA.Rmd
# Les fichiers de sortie sont placés dans reports/output/
# -------------------------------------------------------------------
library(rmarkdown)
library(here)

# 1. Chemins absolus propres -----------------------------------------
rmd_path   <- here("reports", "01_Bellabeat_Data_Profiling_EDA.Rmd")
output_dir <- here("reports", "output")

# 2. S'assurer que le dossier de sortie existe -----------------------
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
}

# 3. Rendu HTML ------------------------------------------------------
render(
  input         = rmd_path,
  output_format = "html_document",
  output_file   = "01_Bellabeat_Data_Profiling_EDA.html",
  output_dir    = output_dir,
  encoding      = "UTF-8"
)

message("✅ Rendering finished. Outputs available in: ", normalizePath(output_dir))
