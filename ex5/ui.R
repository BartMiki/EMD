library(shiny)
library(DT)

# https://www.imdb.com/search/title/?title=The+Matrix&release_date=1999-01-01,1999-12-31&view=simple&count=1
# https://martijnvanvreeden.nl/getting-my-imdb-ratings-with-r-and-rvest/

shinyUI(fluidPage(
  titlePanel("Filmy - zabójstwa"),
  
  sidebarLayout(
    sidebarPanel("Wybierz filmy do porównania", 
                 actionButton("clean", "Clean data"),
                 dataTableOutput("movie_select")),
    
    mainPanel("Porównanie zabitych w wybranych filmach", 
              plotOutput("body_count_cmp", click = "plot_click"))
  ))
)