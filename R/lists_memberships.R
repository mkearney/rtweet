#' Get Twitter list memberships (lists containing a given user)
#'
#' Due to deleted or removed lists, the returned number of memberships
#' is often less than the provided n value. This is a reflection of the API and
#' not a unique quirk of rtweet.
#' 
#' @inheritParams TWIT_paginate_cursor
#' @inheritParams get_timeline
#' @param filter_to_owned_lists When `TRUE`, will return only lists that
#'   authenticating user owns.
#' @param previous_cursor `r lifecycle::badge("deprecated")` Please use 
#'   `cursor` instead.
#' @examples
#' \dontrun{
#'
#' ## get up to 1000 Twitter lists that include Nate Silver
#' ns538 <- lists_memberships("NateSilver538", n = 1000)
#'
#' ## view data
#' ns538
#'
#' }
#'
#' @references <https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-memberships>
#' @export
lists_memberships <- function(user = NULL,
                              n = 200,
                              cursor = "-1",
                              filter_to_owned_lists = FALSE,
                              token = NULL,
                              parse = TRUE,
                              retryonratelimit = NULL,
                              verbose = TRUE,
                              previous_cursor = NULL) {
  params <- list()
  if (!is.null(user)) {
    params[[user_type(user)]] <- user
  }
  if (isTRUE(filter_to_owned_lists)) {
    params$filter_to_owned_lists <- TRUE
  }

  r <- TWIT_paginate_cursor(token, "/1.1/lists/memberships", params, 
    n = n,
    cursor = cursor, 
    retryonratelimit = retryonratelimit,
    verbose = verbose,
    page_size = 1000,
    get_id = function(x) x$lists$id_str
  )
  
  if (parse) {
    r <- parse_lists_list(r)
  }

  r
}

parse_lists_list <- function(x) {
  lists <- lapply(x, function(x) x$lists)
  dfs <- lapply(lists, wrangle_into_clean_data, type = "list")
  dfs <- lapply(dfs, tibble::as_tibble)
  df <- do.call("rbind", dfs)
  
  copy_cursor(df, x)
}
