#' Get one or more user timelines
#'
#' `get_timeline()` returns the timeline of any Twitter user (i.e. what they
#' have tweeted). `get_my_timeline()` returns the home timeline for the 
#' authenticated user (i.e. the tweets you see when you log into Twitter).
#'
#' @inheritParams TWIT_paginate_max_id
#' @param user Character vector of screen names or user ids. 
#'   See [as_screenname()] for more details.
#' @param home Logical, indicating whether to return a "user" timeline
#'   (the default, what a user has tweeted/retweeted) or a "home" timeline 
#'   (what the user would see if they logged into twitter). 
#' @param check `r lifecycle::badge("deprecated")`
#' @param ... Further arguments passed on as parameters in API query.
#' @return A tbl data frame of tweets data with users data attribute.
#' @references <https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline>
#' @examples
#'
#' \dontrun{
#' tw <- get_timeline("JustinBieber")
#' tw
#' 
#' # get tweets that arrived since the last request
#' get_timeline("JustinBieber", since_id = tw)
#' # get earlier tweets
#' get_timeline("JustinBieber", max_id = tw)
#'
#' # get timelines for mulitple users
#' tw <- get_timeline(c("KFC", "PizzaHut", "McDonalds"))
#' tw
#' }
#'
#' @family tweets
#' @export
get_timeline <- function(user = NULL,
                         n = 100,
                         since_id = NULL,
                         max_id = NULL,
                         home = FALSE,
                         parse = TRUE,
                         check = TRUE,
                         retryonratelimit = NULL,
                         verbose = TRUE,
                         token = NULL,
                         ...) {

  if (!isFALSE(home)) {
    lifecycle::deprecate_stop("1.0.0", "get_timeline(home)")
  }
  
  user <- user %||% api_screen_name()
  
  rt <- lapply(user, get_timeline_user, 
    n = n, 
    since_id = since_id,
    max_id = max_id,
    home = FALSE, 
    parse = parse,
    check = check,
    retryonratelimit = retryonratelimit,
    verbose = verbose,
    token = token,
    ...
  )
  
  if (parse) {
    rt <- do.call("rbind", rt)
    rt <- as_tbl(rt)
  } 
  
  rt
}


#' @rdname get_timeline
#' @export
get_my_timeline <- function(n = 100,
                            since_id = NULL,
                            max_id = NULL,
                            parse = TRUE,
                            check = TRUE,
                            retryonratelimit = NULL,
                            verbose = TRUE,
                            token = NULL,
                            ...) {

  get_timeline_user(
    user = api_screen_name(),
    n = n,
    home = TRUE,
    since_id = since_id,
    max_id = max_id,
    parse = parse,
    retryonratelimit = retryonratelimit,
    verbose = verbose,
    token = token
  )
}

get_timeline_user <- function(user,
                              n = 200,
                              since_id = NULL,
                              max_id = NULL,
                              home = FALSE,
                              parse = TRUE,
                              retryonratelimit = NULL,
                              verbose = TRUE,
                              token = NULL,
                              ...) {
  api <- if (home) "/1.1/statuses/home_timeline" else "/1.1/statuses/user_timeline"

  params <- list(
    # tweet_mode = "extended",
    # include_ext_alt_text = "true",
    ...
  )
  params[[user_type(user)]] <- user

  result <- TWIT_paginate_max_id(token, api, params, 
    n = n,
    page_size = 200,
    since_id = since_id,
    max_id = max_id,
    retryonratelimit = retryonratelimit,
    verbose = verbose,
  )
  
  if (parse) {
    result <- tweets_with_users(result)
  }
  result
}

#' @export
#' @rdname get_timeline
#' @usage NULL
get_timelines <- function(user,
                          n = 100,
                          max_id = NULL,
                          home = FALSE,
                          parse = TRUE,
                          check = TRUE,
                          token = NULL,
                          ...) {
  
  lifecycle::deprecate_warn("1.0.0", "get_timelines()", "get_timeline()")
  
  get_timeline(user, n, max_id = max_id, home = home, parse = parse, token = token, ...)
}

