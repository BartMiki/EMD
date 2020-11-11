    library(ggplot2)

Punkt 1
-------

Histogram zmiennej `depth`

    ggplot(diamonds, aes(depth)) + geom_histogram()

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](ex2_files/figure-markdown_strict/p1-1.png)

Punkt 2
-------

Histogram zmiennej `depth` z szerokością kubełka na 0.2

    ggplot(diamonds, aes(depth)) + geom_histogram(binwidth = 0.2)

![](ex2_files/figure-markdown_strict/p2-1.png)

Punkt 3
-------

Histogram zmiennej `depth` z szerokością kubełka na 0.2 oraz
ograniczeniem do przedziału osi x do \[50, 70\]

    ggplot(diamonds, aes(depth)) + geom_histogram(binwidth = 0.2) + xlim(c(55, 70))

    ## Warning: Removed 45 rows containing non-finite values (stat_bin).

    ## Warning: Removed 2 rows containing missing values (geom_bar).

![](ex2_files/figure-markdown_strict/p3-1.png)

Punkt 4
-------

Jak zmienna `cut` wpływa na histogram:

Za pomocą koloru

    ggplot(diamonds, aes(depth, color=cut)) + geom_histogram(binwidth = 0.2) + xlim(c(55, 70))

    ## Warning: Removed 45 rows containing non-finite values (stat_bin).

    ## Warning: Removed 10 rows containing missing values (geom_bar).

![](ex2_files/figure-markdown_strict/p4_1-1.png)

Za pomocą paneli

    ggplot(diamonds, aes(depth)) + geom_histogram(binwidth = 0.2) + xlim(c(55, 70)) + facet_wrap(~cut)

    ## Warning: Removed 45 rows containing non-finite values (stat_bin).

    ## Warning: Removed 10 rows containing missing values (geom_bar).

![](ex2_files/figure-markdown_strict/p4_2-1.png) \#\# Punkt 5 Histogram
zmiennej `price`

    ggplot(diamonds, aes(price)) + geom_histogram()

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](ex2_files/figure-markdown_strict/p5_1-1.png)

Histogram zmiennej `(price)` z szerokością kubełka na 50

    ggplot(diamonds, aes(price)) + geom_histogram(binwidth = 50)

![](ex2_files/figure-markdown_strict/p5_2-1.png)

Histogram zmiennej `depth` z szerokością kubełka na 50 oraz
ograniczeniem do przedziału osi x do \[0, 19000\]

    ggplot(diamonds, aes(price)) + geom_histogram(binwidth = 50) + xlim(c(0, 19000))

    ## Warning: Removed 2 rows containing missing values (geom_bar).

![](ex2_files/figure-markdown_strict/p5_3-1.png)

Jak zmienna `cut` wpływa na histogram:

Za pomocą koloru

    ggplot(diamonds, aes(price, color=cut)) + geom_histogram(binwidth = 50) + xlim(c(0, 19000))

    ## Warning: Removed 10 rows containing missing values (geom_bar).

![](ex2_files/figure-markdown_strict/p5_4-1.png)

Za pomocą paneli

    ggplot(diamonds, aes(price)) + geom_histogram(binwidth = 50) + xlim(c(0, 19000)) + facet_wrap(~cut)

    ## Warning: Removed 10 rows containing missing values (geom_bar).

![](ex2_files/figure-markdown_strict/p5_5-1.png)

Punkt 6
-------

Zwizualizuj relację między zmiennymi `carat` i `price`.

    ggplot(diamonds, aes(carat, price)) + geom_point()

![](ex2_files/figure-markdown_strict/p6-1.png)
