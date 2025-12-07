# Load here (once)
if (!requireNamespace("here", quietly = TRUE)) {
  stop("The 'here' package is required by config.R")
}

# Root of the R project (where the .Rproj EDA.Bellabeat.R file is located)
project_root <- here::here()

# Root "solution" above src/EDA.Bellabeat.R
solution_root <- here::here("..", "..")

# Folder containing the CSV source files of the Bellabeat project data
data_dir <- file.path(solution_root, "data-samples")

# Folder for Jupyter notebooks 
ipynb_output_dir <- file.path(project_root, "notebooks")

# Folder containing the R Markdown files of the Bellabeat analysis
reports_dir <- file.path(project_root, "reports")

# Folder for the generated HTML site directory.
output_dir <- file.path(reports_dir, "output")

# Create notebooks folder if needed
if (!dir.exists(ipynb_output_dir)) dir.create(ipynb_output_dir, recursive = TRUE)

# Create reports folder if needed
if (!dir.exists(reports_dir)) dir.create(reports_dir, recursive = TRUE)

# Create output folder if needed
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
