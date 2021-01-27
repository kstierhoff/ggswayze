# ggswayze
A ggplot2 geom for adding Patrick Swayze. This is an unofficial package of the memeverse.

This is a ripped-off from the [ggbernie] package by [@RCoderWeb](https://twitter.com/RCoderWeb)

## Installation
```r
# install.packages("remotes")
remotes::install_github("kstierhoff/ggswayze@main")
```

## Swayze breaking
```r
ggplot(mtcars) +
  geom_swayze(aes(mpg, wt), swayze = "breaking")
```

## Swayze housing

```r
ggplot(mtcars) +
  geom_swayze(aes(mpg, wt), swayze = "housing")
```

The `draw_key_swayze` function was inspired by `draw_key_lime` from `geom_lime`.
