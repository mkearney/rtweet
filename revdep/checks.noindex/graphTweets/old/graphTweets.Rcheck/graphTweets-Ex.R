pkgname <- "graphTweets"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('graphTweets')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("dyn")
### * dyn

flush(stderr()); flush(stdout())

### Name: gt_dyn
### Title: Dynamise
### Aliases: gt_dyn

### ** Examples

## Not run: 
##D # simulate dataset
##D tweets <- data.frame(
##D   text = c("I tweet @you about @him and @her", 
##D            "I tweet @me about @you"),
##D   screen_name = c("me", "him"),
##D   created_at = c(Sys.time(), Sys.time() + 10000),
##D   status_id = c(1, 2),
##D   stringsAsFactors = FALSE
##D )
##D 
##D tweets %>% 
##D   gt_edges(text, screen_name, status_id, "created_at") %>% 
##D   gt_nodes() %>% 
##D   gt_dyn() %>% 
##D   gt_collect() -> net
## End(Not run)




cleanEx()
nameEx("edges_from_text")
### * edges_from_text

flush(stderr()); flush(stdout())

### Name: gt_edges_from_text
### Title: Edges from text
### Aliases: gt_edges_from_text gt_edges_from_text_

### ** Examples

# simulate dataset
tweets <- data.frame(
  text = c("I tweet @you about @him and @her", 
           "I tweet @me about @you"),
  screen_name = c("me", "him"),
  retweet_count = c(19, 5),
  status_id = c(1, 2),
  hashtags = c("rstats", "Python"),
  stringsAsFactors = FALSE
)

tweets %>% 
  gt_edges_from_text(status_id, screen_name, text)
    



cleanEx()
nameEx("graphTweets")
### * graphTweets

flush(stderr()); flush(stdout())

### Name: graphTweets
### Title: 'graphTweets' visualise Twitter Interactions.
### Aliases: graphTweets graphTweets-package
### Keywords: internal

### ** Examples

## Not run: 
##D library(rtweet)
##D 
##D tweets <- search_tweets("#rstats")
##D 
##D library(graphTweets)
##D 
##D # simple network
##D tweets %>% 
##D   gt_edges(screen_name, mentions_screen_name) %>% # get edges
##D   gt_nodes %>% # get nodes
##D   gt_graph %>% # build igraph object
##D   plot(.)
## End(Not run)




cleanEx()
nameEx("gt_collect")
### * gt_collect

flush(stderr()); flush(stdout())

### Name: gt_collect
### Title: Collect
### Aliases: gt_collect

### ** Examples

# simulate dataset
tweets <- data.frame(
  text = c("I tweet @you about @him", 
           "I tweet @me about @you"),
  screen_name = c("me", "him"),
  retweet_count = c(19, 5),
  status_id = c(1, 2),
  stringsAsFactors = FALSE
)

tweets %>% 
  gt_edges(text, screen_name, status_id) %>% 
  gt_nodes() %>% 
  gt_collect() -> net




cleanEx()
nameEx("gt_graph")
### * gt_graph

flush(stderr()); flush(stdout())

### Name: gt_graph
### Title: Graph
### Aliases: gt_graph

### ** Examples

# simulate dataset
tweets <- data.frame(
  text = c("I tweet @you about @him", 
           "I tweet @me about @you"),
  screen_name = c("me", "him"),
  retweet_count = c(19, 5),
  status_id = c(1, 2),
  stringsAsFactors = FALSE
)

tweets %>% 
  gt_edges(text, screen_name, status_id) %>% 
  gt_nodes() %>% 
  gt_graph() -> net




cleanEx()
nameEx("gt_save")
### * gt_save

flush(stderr()); flush(stdout())

### Name: gt_save
### Title: Save
### Aliases: gt_save

### ** Examples

## Not run: 
##D # simulate dataset
##D tweets <- data.frame(
##D   text = c("I tweet @you about @him", 
##D            "I tweet @me about @you"),
##D   screen_name = c("me", "him"),
##D   retweet_count = c(19, 5),
##D   created_at = c(Sys.time(), Sys.time() + 15000),
##D   status_id = c(1, 2),
##D   stringsAsFactors = FALSE
##D )
##D 
##D tweets %>% 
##D   gt_edges(text, screen_name, "created_at") %>% 
##D   gt_nodes(TRUE) %>% 
##D   gt_dyn() %>% 
##D   gt_save()
## End(Not run)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
