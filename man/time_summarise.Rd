% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/time_summarise.R
\name{time_summarise}
\alias{time_summarise}
\alias{time_summarize}
\title{Summarise a \code{tbl_time} by period}
\usage{
time_summarise(.data, period = "yearly", ..., start_date = NULL)

time_summarize(.data, period = "yearly", ..., start_date = NULL)
}
\arguments{
\item{.data}{A \code{tbl_time} object.}

\item{period}{A formula or character specification used for time-based grouping.

If a formula, e.g. \code{1~year}, the formula is split and parsed to form the
grouping period. The \code{period} argument accepts a formula of the form
\code{multiple ~ period} allowing for flexible period grouping.
The following are examples:
\itemize{
\item 1 Year: \code{1~y}
\item 3 Months: \code{3~m}
\item 90 Days: \code{90~d}
}

Note that while shorthand is used above, an attempt is made to recognize
more explicit period names such as:
\itemize{
\item 2 Year: \code{2~year} / \code{2~years} / \code{2~yearly}
}

The \code{period} argument also accepts characters that are converted to their
corresponding periods. The following are accepted:
\itemize{
\item \code{"yearly"} or \code{"y"}
\item \code{"quarterly"} or \code{"q"}
\item \code{"monthly"} or \code{"m"}
\item \code{"weekly"} or \code{"w"}
\item \code{"daily"} or \code{"d"}
\item \code{"hour"} or \code{"h"}
\item \code{"minute"} or \code{"M"}
\item \code{"second"} or \code{"s"}
}}

\item{...}{Not currently used.}

\item{start_date}{Optional argument used to specify the start date for the
first group. The default is to start at the closest period boundary
below the minimum date in the supplied index.}
}
\description{
\code{\link[=time_summarise]{time_summarise()}} works similarly to \code{\link[dplyr:summarise]{dplyr::summarise()}} but with the added
benefit of being able to summarise by a time period such as \code{"yearly"} or
\code{"monthly"}.
}
\details{
Groups applied using \code{\link[dplyr:group_by]{dplyr::group_by()}} are respected.

In \code{\link[dplyr:summarise]{dplyr::summarise()}}, one level of grouping is usually removed.
Because an added group for the time index is added in \code{time_summarise},
none of the original groups are removed.
}
\examples{

# Basic functionality -------------------------------------------------------

data(FB)
FB <- as_tbl_time(FB, date)

# Calculate the mean and standard deviation of the adjusted column
# at a yearly interval
FB \%>\%
  time_summarise(period = "yearly",
                 adj_mean = mean(adjusted),
                 adj_sd   = sd(adjusted))

# Want a more granular view? Look at monthly instead
FB \%>\%
  time_summarise(period = "monthly",
                 adj_mean = mean(adjusted),
                 adj_sd   = sd(adjusted))

# Grouped functionality -----------------------------------------------------

data(FANG)
FANG <- as_tbl_time(FANG, date) \%>\%
  dplyr::group_by(symbol)

# Groups are respected, allowing for very useful summaries
# grouped by symbol and by time period
FANG \%>\%
  time_summarise(period = "yearly",
                 vol_max   = max(volume),
                 vol_min   = min(volume),
                 # Like summarise, you can use columns you just computed
                 vol_range = vol_max - vol_min)


}
