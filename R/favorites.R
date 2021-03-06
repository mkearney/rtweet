#' Get tweets favorited by one or more users
#'
#' Returns up to 3,000 tweets favorited for each `user`.
#'
#' @inheritParams TWIT_paginate_max_id
#' @inheritParams get_timeline
#' @return A tibble with one row for each tweet.
#' @examples
#' \dontrun{
#' # get likes for a single user
#' kfc <- get_favorites("KFC")
#' kfc
#' # get newer likes since last request 
#' newer <- get_favorites("KFC", since_id = kfc)
#'
#' # get likes from multiple users
#' favs <- get_favorites(c("Lesdoggg", "pattonoswalt", "meganamram"))
#' favs
#' }
#' @family tweets
#' @references <https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-favorites-list>
#' @export
get_favorites <- function(user,
                          n = 200,
                          since_id = NULL,
                          max_id = NULL,
                          parse = TRUE,
                          retryonratelimit = NULL,
                          verbose = TRUE,
                          token = NULL) {
  rt <- lapply(user, get_favorites_user, 
    n = n,
    since_id = since_id,
    max_id = max_id,
    parse = parse,
    retryonratelimit = retryonratelimit,
    verbose = verbose,
    token = token
  )

  if (parse) {
    rt <- do_call_rbind(rt)
  }
  rt
}

get_favorites_user <- function(user, ..., parse = TRUE, token = NULL) {
  params <- list(
    tweet_mode = "extended",
    include_ext_alt_text = "true"
  )
  params[[user_type(user)]] <- user
  
  results <- TWIT_paginate_max_id(token, "/1.1/favorites/list", params,
    page_size = 200,
    ...
  )

  if (parse) {
    results <- tweets_with_users(results)
    results$favorited_by <- rep(user, nrow(results))
  }
  
  results
}
