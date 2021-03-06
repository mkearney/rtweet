#' Get tweets data for given statuses (status IDs).
#'
#' @inheritParams lookup_users
#' @param statuses User id or screen name of target user.
#' @references <https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-lookup>
#' @examples
#'
#' \dontrun{
#' statuses <- c(
#'   "567053242429734913",
#'   "266031293945503744",
#'   "440322224407314432"
#' )
#'
#' ## lookup tweets data for given statuses
#' tw <- lookup_tweets(statuses)
#' tw
#' }
#' @return A tibble of tweets data.
#' @family tweets
#' @export
lookup_tweets <- function(statuses, parse = TRUE, token = NULL,
                          retryonratelimit = NULL, verbose = TRUE) {
  chunks <- unname(split(statuses, (seq_along(statuses) - 1) %/% 100))
  params_list <- lapply(chunks, function(id) {
    list(
      id = paste(id, collapse = ","),
      tweet_mode = "extended",
      include_ext_alt_text = "true"
    )
  })
  
  results <- TWIT_paginate_chunked(token, "/1.1/statuses/lookup", params_list,
    retryonratelimit = retryonratelimit,
    verbose = verbose
  )

  if (parse) {
    results <- tweets_with_users(results)
  }
  results
}

#' @export
#' @rdname lookup_tweets
#' @usage NULL
lookup_statuses <- function(statuses, parse = TRUE, token = NULL) {
  lifecycle::deprecate_warn("1.0.0", "lookup_statuses()", "lookup_tweets()")
  
  lookup_tweets(statuses = statuses, parse = parse, token = token)
}

