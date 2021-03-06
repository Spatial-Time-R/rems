# Copyright 2016 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

#' Combine rows from different EMS data sets
#'
#' Mostly used to combine '2yr' and 'historic' data obtained through
#' \link{get_ems_data} and \link{read_historic_data}.
#'
#' @param ... the datasets you want to combine
#'
#' @return a data frame with rows of inputs combined
#' @export
#' @importFrom dplyr bind_rows
bind_ems_data <- function(...) {
  dplyr::bind_rows(...)
}

#' Simple filtering of ems data by emsid and or dates.
#'
#' @param x The ems data frame to filter
#' @param emsid A character vector of the ems id(s) of interest
#' @param parameter a character vector of parameter names
#' @param param_code a character vector of parameter codes
#' @param from_date A date string in a standard unambiguous format (e.g., "YYYY/MM/DD")
#' @param to_date A date string in a standard unambiguous format (e.g., "YYYY/MM/DD")
#'
#' @return A filtered data frame
#' @export
#' @importFrom dplyr filter_
filter_ems_data <- function(x, emsid = NULL, parameter = NULL, param_code = NULL,
                            from_date = NULL, to_date = NULL) {
  # See which arguments have been given a value
  argslist <- names(as.list(match.call()))[c(-1,-2)]
  if (!is.null(from_date)) from_date <- as.POSIXct(from_date, tz = ems_tz())
  if (!is.null(to_date)) to_date <- as.POSIXct(to_date, ems_tz())
  # Create the dots objects to be passed in to filter_, then remove the elements
  # didn't get passed a value, and remove names

  emsid <- pad_emsid(emsid)

  dots <- list(emsid = ~EMS_ID %in% emsid,
               parameter = ~PARAMETER %in% parameter,
               param_code = ~PARAMETER_CODE %in% param_code,
               from_date = ~COLLECTION_START >= from_date,
               to_date = ~COLLECTION_START <= to_date)
  dots <- unname(dots[argslist])

  dplyr::filter_(x, .dots = dots)
}
