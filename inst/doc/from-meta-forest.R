## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4.2,
  dpi = 96
)
has_meta <- requireNamespace("meta", quietly = TRUE)

## ----setup--------------------------------------------------------------------
library(ggmeta)
library(ggplot2)

## ----side-by-side, eval = has_meta--------------------------------------------
library(meta)

m <- metabin(
  event.e = c(14, 30, 15, 22), n.e = c(100, 150, 100, 120),
  event.c = c(10, 25, 12, 18), n.c = c(100, 150, 100, 120),
  studlab = c("Study A", "Study B", "Study C", "Study D"),
  sm = "RR"
)

# meta::forest(m)   # base-graphics forest plot
ggforest(m)         # the same analysis, as a ggplot

## ----tweak, eval = has_meta---------------------------------------------------
ggforest(m) +
  labs(title = "Risk of the event", x = "Risk ratio (log scale)")

## ----cols, eval = has_meta, fig.width = 9-------------------------------------
ggforest(m, columns = TRUE)

## ----custom-col, eval = has_meta, fig.width = 8.5-----------------------------
td <- tidy_meta(m)
studies <- td[!td$is_summary, ]
studies$effect_txt <- format_effect(studies$estimate, studies$ci_lower, studies$ci_upper)

ggforest(m) +
  geom_forest_text(aes(y = studlab, label = effect_txt), data = studies,
                   x = 4.2, hjust = 0) +
  expand_limits(x = 7)

