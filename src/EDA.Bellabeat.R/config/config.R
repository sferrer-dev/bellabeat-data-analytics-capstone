# Folder containing the CSV source files of the Bellabeat project data
data_dir <- file.path("..", "..", "data-samples")

# Folder for analysis artifacts
output_dir <- "output"

# Statistical descriptions of source files
profile_dir <- file.path(output_dir, "profile_summaries")

# Create output folder if needed
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Create profile_summaries folder if needed
if (!dir.exists(profile_dir)) dir.create(profile_dir, recursive = TRUE)
