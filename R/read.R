#' @importFrom data.table fread
#' @importFrom tibble as_tibble
read_ems_data <- function(file) {
  message("Reading data from file...")
  dat <- data.table::fread(file, header = TRUE, colClasses = col_spec())
  dat$COLLECTION_START <- format_dates(dat$COLLECTION_START)
  dat$COLLECTION_END <- format_dates(dat$COLLECTION_END)
  tibble::as_tibble(dat)
}

format_dates <- function(dates_char) {
  dates_char <- sub("(\\d{4})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})","\\1/\\2/\\3T\\4:\\5:\\6", dates_char)
  fasttime::fastPOSIXct(dates_char, tz = "Etc/GMT+8")
}

col_spec <- function() {
  c(EMS_ID = "character"
    , MONITORING_LOCATION = "character"
    , LATITUDE = "numeric"
    , LONGITUDE = "numeric"
    , LOCATION_TYPE = "character"
    , COLLECTION_START = "character"
    , COLLECTION_END = "character"
    , REQUISITION_ID = "character"
    , SAMPLING_AGENCY = "character"
    , ANALYZING_AGENCY = "character"
    , COLLECTION_METHOD = "character"
    , SAMPLE_CLASS = "character"
    , SAMPLE_STATE = "character"
    , SAMPLE_DESCRIPTOR = "character"
    , PARAMETER_CODE = "character"
    , PARAMETER = "character"
    , ANALYTICAL_METHOD_CODE = "character"
    , ANALYTICAL_METHOD = "character"
    , RESULT_LETTER = "character"
    , RESULT = "numeric"
    , UNIT = "character"
    , METHOD_DETECTION_LIMIT = "numeric"
    , QA_INDEX_CODE = "character"
    , UPPER_DEPTH = "numeric"
    , LOWER_DEPTH = "numeric"
    , TIDE = "character"
    , AIR_FILTER_SIZE = "numeric"
    , AIR_FLOW_VOLUME = "numeric"
    , FLOW_UNIT = "character"
    , COMPOSITE_ITEMS = "numeric"
    , CONTINUOUS_AVERAGE = "numeric"
    , CONTINUOUS_MAXIMUM = "numeric"
    , CONTINUOUS_MINIMUM = "numeric"
    , CONTINUOUS_UNIT_CODE = "character"
    , CONTINUOUS_DURATION = "numeric"
    , CONTINUOUS_DURATION_UNIT = "character"
    , CONTINUOUS_DATA_POINTS = "numeric"
    , TISSUE_TYPE = "character"
    , SAMPLE_SPECIES = "character"
    , SEX = "character"
    , LIFE_STAGE = "character"
    , BIO_SAMPLE_VOLUME = "numeric"
    , VOLUME_UNIT = "character"
    , BIO_SAMPLE_AREA = "numeric"
    , AREA_UNIT = "character"
    , BIO_SIZE_FROM = "numeric"
    , BIO_SIZE_TO = "numeric"
    , SIZE_UNIT = "character"
    , BIO_SAMPLE_WEIGHT = "numeric"
    , WEIGHT_UNIT = "character"
    , BIO_SAMPLE_WEIGHT_FROM = "numeric"
    , BIO_SAMPLE_WEIGHT_TO = "numeric"
    , WEIGHT_UNIT_1 = "character"
    , SPECIES = "character"
    , RESULT_LIFE_STAGE = "character"
  )
}