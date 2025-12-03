# scripts/render_all.R

# -------------------------------------------------------------------
# Génération des rapports HTML pour :
#  - 01_Bellabeat_Data_Profiling_EDA.Rmd
#  - 02_Bellabeat_Files_Overview.Rmd
#
# Les fichiers de sortie sont placés dans le sous-dossier "output"
# du dossier "reports" où se trouvent les .Rmd.
# -------------------------------------------------------------------
library(rmarkdown)
library(here)

# 1. Récupérer les chemins complets des Rmd --------------------------
rmd_files <- c(
  here("reports", "01_Bellabeat_Data_Profiling_EDA.Rmd"),
  here("reports", "02_Bellabeat_Files_Overview.Rmd"),
  here("reports", "02_Bellabeat_Files_Overview_FR.Rmd"),
  here("reports", "03_Bellabeat_ROCCC.Rmd"),
  here("reports", "03_Bellabeat_ROCCC_FR.Rmd"),
  here("reports", "04_Bellabeat_Processus_ETL.Rmd"),
  here("reports", "04_Bellabeat_Processus_ETL_FR.Rmd"),
  here("reports", "05_Bellabeat_Analyse_Daily_Activity.Rmd")
)

for (rmd in rmd_files) {
  
  # Dossier du Rmd (devrait être .../src/EDA.Bellabeat.R/reports)
  rmd_dir <- dirname(rmd)
  
  # Dossier de sortie : sous-dossier "output" à côté des Rmd
  output_dir <- file.path(rmd_dir, "output")
  
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  }
  
  # Nom du fichier HTML de sortie = même préfixe que le Rmd
  output_file <- sub("\\.Rmd$", ".html", basename(rmd))
  
  message("▶ Rendering: ", basename(rmd))
  message("   - rmd_dir    : ", rmd_dir)
  message("   - output_dir : ", output_dir)
  message("   - output_file: ", output_file)
  
  render(
    input         = rmd,
    output_format = "html_document",
    output_file   = output_file,
    output_dir    = output_dir,
    encoding      = "UTF-8"
  )
}

message("✅ Rendering finished.")