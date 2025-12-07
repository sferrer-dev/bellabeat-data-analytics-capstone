# scripts/render_all.R
# -------------------------------------------------------------------
# Build complet du projet Bellabeat :
#  1) Génération du site R Markdown (HTML)
#  2) Génération des notebooks Kaggle EN (.ipynb)
#  3) Génération des notebooks Kaggle FR (.ipynb)
# -------------------------------------------------------------------

# 0. Packages --------------------------------------------------------
required_pkgs <- c("rmarkdown", "quarto", "here")

missing <- required_pkgs[!vapply(required_pkgs, requireNamespace,
                                 FUN.VALUE = logical(1), quietly = TRUE)]

if (length(missing) > 0) {
  stop(
    "Les packages suivants sont manquants : ",
    paste(missing, collapse = ", "),
    "\nInstalle-les avant de relancer le script, par ex. :\n",
    "install.packages(c(",
    paste(sprintf('\"%s\"', missing), collapse = ", "),
    "))",
    call. = FALSE
  )
}

library(rmarkdown)
library(quarto)
library(here)

# 0. Custom project configuration
source(here("config", "config.R"))

# 1. Génération du site HTML -----------------------------------------
message("▶ Étape 1/3 : génération du site HTML à partir de 'reports/'")

render_site(input = here("reports"))

message("✅ Site HTML généré.\n")

# 2. Préparation des fichiers pour notebooks -------------------------

reports_dir <- here("reports")

# Tous les rapports numérotés XX_*.Rmd (FR et non-FR)
all_reports <- list.files(
  path   = reports_dir,
  pattern = "^\\d{2}_.*\\.Rmd$",
  full.names = FALSE
)

# Séparation EN / FR par suffixe _FR.Rmd
rmd_en <- all_reports[!grepl("_FR\\.Rmd$", all_reports)]
rmd_fr <- all_reports[ grepl("_FR\\.Rmd$", all_reports)]

message("Fichiers EN détectés :")
print(rmd_en)
message("\nFichiers FR détectés :")
print(rmd_fr)

# Dossier de sortie des notebooks
# ipynb_output_dir <- file.path(reports_dir, "notebooks")

if (!dir.exists(ipynb_output_dir)) {
  dir.create(ipynb_output_dir, recursive = TRUE, showWarnings = FALSE)
}

# Fonction utilitaire : rend et déplace les .ipynb -------------------
render_group <- function(files, label) {
  if (length(files) == 0) {
    message("⚠️ Aucun fichier détecté pour le groupe ", label, ".")
    return(invisible(NULL))
  }
  
  message("\n▶ Génération des notebooks ", label)
  
  for (fn in files) {
    input_path   <- file.path(reports_dir, fn)
    ipynb_name   <- sub("\\.Rmd$", ".ipynb", fn)
    ipynb_source <- file.path(reports_dir, ipynb_name)
    ipynb_target <- file.path(ipynb_output_dir, ipynb_name)
    
    message("   → ", ipynb_name)
    
    # 1) Rendu du .ipynb à côté du .Rmd (dans reports/)
    quarto::quarto_render(
      input         = input_path,
      output_format = "ipynb"
      # pas d'output_file / output_dir ici → Quarto gère le nom par défaut
    )
    
    # 2) Déplacement dans reports/notebooks/
    if (file.exists(ipynb_source)) {
      file.rename(ipynb_source, ipynb_target)
    } else {
      warning("Le fichier attendu n'a pas été trouvé après rendu : ", ipynb_source)
    }
  }
  
  message("✅ Notebooks ", label, " générés.")
}

# 3. Rendu des notebooks EN et FR ------------------------------------

render_group(rmd_en, "EN")
render_group(rmd_fr, "FR")

message("\n🎉 BUILD COMPLET : site HTML + notebooks Kaggle EN & FR générés.")
