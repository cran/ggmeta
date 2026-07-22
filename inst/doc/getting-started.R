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

## ----meta-basic, eval = has_meta----------------------------------------------
library(meta)

m <- metabin(
  event.e = c(14, 30, 15, 22), n.e = c(100, 150, 100, 120),
  event.c = c(10, 25, 12, 18), n.c = c(100, 150, 100, 120),
  studlab = c("Study A", "Study B", "Study C", "Study D"),
  sm = "RR"
)

ggforest(m)

## ----df-basic-----------------------------------------------------------------
df <- data.frame(
  studlab  = c("Trial 1", "Trial 2", "Trial 3", "Trial 4"),
  estimate = c(0.82, 0.91, 0.68, 1.05),
  ci_lower = c(0.61, 0.74, 0.48, 0.80),
  ci_upper = c(1.10, 1.12, 0.96, 1.38)
)

ggforest(df, null_effect = 1)

## ----df-pool------------------------------------------------------------------
studies <- data.frame(
  studlab  = c("Trial 1", "Trial 2", "Trial 3", "Trial 4", "Trial 5"),
  estimate = c(0.10, 0.35, 0.22, 0.48, 0.05),
  se       = c(0.12, 0.10, 0.14, 0.16, 0.11)
)
studies$ci_lower <- studies$estimate - 1.96 * studies$se
studies$ci_upper <- studies$estimate + 1.96 * studies$se

ggforest(studies, add_summary = TRUE)

## ----columns, fig.width = 9---------------------------------------------------
ggforest(studies, add_summary = TRUE, columns = TRUE, effect_header = "SMD")

## ----text-cols, fig.width = 8.5-----------------------------------------------
studies$n <- c(120, 240, 150, 180, 110)

ggforest(studies, add_summary = TRUE) +
  geom_forest_text(aes(y = studlab, label = n), data = studies,
                   x = -0.35, hjust = 0.5) +
  expand_limits(x = -0.45)

## ----layouts------------------------------------------------------------------
p <- ggforest(df, null_effect = 1)
layout_jama(p)

## ----metaprop, eval = has_meta------------------------------------------------
prop <- metaprop(
  event = c(15, 20, 12, 25), n = c(50, 60, 55, 70),
  studlab = paste("Cohort", 1:4), sm = "PLOGIT"
)
ggforest(prop)

## ----save, eval = FALSE-------------------------------------------------------
# p <- ggforest(df, null_effect = 1)
# ggsave("forest.png", p, width = 7, height = 4, dpi = 300)

