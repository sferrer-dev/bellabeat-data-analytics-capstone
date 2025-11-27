# Folder containing the CSV source files of the Bellabeat project data
data_dir <- file.path("..", "..", "data-samples")

# Folder for analysis artifacts
output_dir <- file.path("..", "reports", "output")

# Create output folder if needed
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)


