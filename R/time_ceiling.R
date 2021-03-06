#' Ceiling a `tbl_time` object
#'
#' This is essentially a convenient wrapper to [lubridate::ceiling_date()] that
#' allows ceiling of a `tbl_time` object using a period formula.
#'
#' @inheritParams time_group
#' @param x A `tbl_time` object.
#' @param ... Arguments passed on to [lubridate::ceiling_date()]
#'
#' @details
#'
#' This function respects [dplyr::group_by()] groups.
#'
#' @examples
#'
#' example_series <- create_series(~2013, 2~day)
#'
#' # When you convert to a period with `side = "end"` specified,
#' # the highest available date in that period is chosen
#' example_series %>%
#'   as_period(1~m, side = "end")
#'
#' # Sometimes you want to additionally ceiling that date so that all dates
#' # are consistent
#' # Note that lubridate::ceiling_date() rounds up to the next boundary,
#' # and does not stop at the end of the month.
#' example_series %>%
#'   as_period(1~m, side = "end") %>%
#'   time_ceiling(1~m)
#'
#' @export
time_ceiling <- function(x, period, ...) {
  UseMethod("time_ceiling")
}

#' @export
time_ceiling.default <- function(x, period, ...) {
  stop("Object is not of class `tbl_time`.", call. = FALSE)
}

#' @export
time_ceiling.tbl_time <- function(x, period, ...) {

  # Period and index
  period <- split_period(period)
  index <- rlang::sym(retrieve_index(x, as_name = TRUE))

  # Unit for lubridate
  lub_unit <- paste(period[["num"]], period[["period"]])

  # Apply floor
  mutate(x,
         !! index := lubridate::ceiling_date(!! index, unit = lub_unit, ...))

}
