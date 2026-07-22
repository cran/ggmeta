## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 3.6,
  dpi = 96
)
has_meta <- requireNamespace("meta", quietly = TRUE)

## ----setup, message = FALSE---------------------------------------------------
library(ggmeta)
library(ggplot2)

## ----model, eval = has_meta---------------------------------------------------
library(meta)

dat <- data.frame(
  study   = c("Adams 2019", "Baker 2020", "Chen 2020",
              "Diaz 2021", "Evans 2022", "Foster 2023"),
  event.e = c(12,  8, 25, 18, 30, 15), n.e = c(120,  90, 200, 150, 250, 130),
  event.c = c(20, 14, 30, 28, 35, 25), n.c = c(118,  92, 205, 148, 245, 128)
)
m <- metabin(event.e, n.e, event.c, n.c,
             data = dat, studlab = study, sm = "RR")

## ----predict, eval = has_meta-------------------------------------------------
ggforest(m, predict_args = list(
  cap_width = 0.1, colour = "firebrick", linewidth = 0.8, linetype = "solid"
))

## ----diamonds, eval = has_meta------------------------------------------------
ggforest(m,
  diamond_colours = c(common = "grey45", random = "#1B7837"),
  diamond_args    = list(colour = "grey20", alpha = 1)
)

## ----ci-ref, eval = has_meta--------------------------------------------------
ggforest(m,
  ci_args   = list(colour = "grey30", point_size_range = c(1, 5)),
  ref_args  = list(linetype = "dashed"),
  consensus = FALSE
)

## ----all, eval = has_meta, fig.width = 9--------------------------------------
ggforest(m, columns = TRUE,
  predict_args    = list(cap_width = 0.1, colour = "firebrick"),
  diamond_colours = c(common = "grey45", random = "#1B7837"),
  ci_args         = list(colour = "grey30")
)

## ----funnel, eval = has_meta, fig.width = 6, fig.height = 4.6-----------------
ggfunnel(m,
  point_args   = list(size = 3, fill = "#1B7837"),
  contour_args = list(colour = "grey70", linetype = "dotted", level = c(0.95, 0.99)),
  ref_args     = list(colour = "firebrick")
)

