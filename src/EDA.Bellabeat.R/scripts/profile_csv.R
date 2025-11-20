# ---- Profile function ----

#' Profile a CSV file and return profiling objects for reporting.
#'
#' This function reads a CSV file and computes:
#' - a column-level profile (types, missing values, distinct values),
#' - basic numeric statistics (min, max, mean, median),
#' - a global skimr profile (rich summary for all variables).
#'
#' It returns a list of data frames / tibbles
#' that can be directly used in an R Markdown report (printed, formatted,
#' or further transformed).
#'
#' @param file_path Character string. Path to the CSV file to be profiled.
#' @return A list with elements:
#'   - data: the original dataframe
#'   - col_profile: column-level profile
#'   - num_stats: numeric variables summary (or NULL if no numeric vars)
#'   - skim: skimr profile (skim_df)
#' @details Requires packages: readr, dplyr, purrr, tidyr, skimr.
profile_csv <- function(file_path) {
  # Display which file is being profiled (informational message)
  message("=== Profiling : ", basename(file_path), " ===")
  # Read the CSV file into a dataframe
  df <- readr::read_csv(
    file_path,
    show_col_types = FALSE,
    guess_max = 5000
  )
  
  # Build a column-level profile:
  # - column name
  # - detected type
  # - number and % of missing values
  # - number of distinct values
  col_profile <- tibble::tibble(
    column       = names(df),
    type         = purrr::map_chr(df, ~ class(.x)[1]),
    n_missing    = purrr::map_int(df, ~ sum(is.na(.x))),
    pct_missing  = purrr::map_dbl(df, ~ mean(is.na(.x))),
    n_distinct   = purrr::map_int(df, ~ dplyr::n_distinct(.x))
  )
  # If the dataset contains numeric variables, compute basic numeric statistics
  num_stats <- NULL
  if (any(purrr::map_lgl(df, is.numeric))) {
    num_stats <- df %>%
      dplyr::summarise(dplyr::across(
        dplyr::where(is.numeric),
        list(
          min    = ~ min(.x, na.rm = TRUE),
          max    = ~ max(.x, na.rm = TRUE),
          mean   = ~ mean(.x, na.rm = TRUE),
          median = ~ median(.x, na.rm = TRUE)
        ),
        .names = "{.col}_{.fn}"
      )) %>%
      tidyr::pivot_longer(
        dplyr::everything(),
        names_to  = c("variable", ".value"),
        names_sep = "_"
      )
  }
  # Compute a rich, structured summary for all variables using skimr
  skim_profile <- skimr::skim(df)
  # Optionally display dataset dimensions for quick inspection
  message("Dimensions : ", nrow(df), " rows x ", ncol(df), " columns")
  # Return a structured list of profiling artifacts
  list(
    file_path    = file_path,
    file_name    = basename(file_path),
    file_size    = file.info(file_path)$size / 1024^2,  # Mo
    n_rows       = nrow(df),
    n_cols       = ncol(df),
    data        = df,
    col_profile = col_profile,
    num_stats   = num_stats,
    skim        = skim_profile
  )
}