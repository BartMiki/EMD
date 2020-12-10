library(shiny)
library(DT)

# https://www.imdb.com/search/title/?title=The+Matrix&release_date=1999-01-01,1999-12-31&view=simple&count=1
# https://martijnvanvreeden.nl/getting-my-imdb-ratings-with-r-and-rvest/

shinyUI(fluidPage(
  titlePanel("Filmy - zabójstwa"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Wybierz filmy do porównania"),
      dataTableOutput("movie_select"),
      actionButton("clean", "Wyczyść wyszukiwanie"),
      h3("Linki do wybranych filmów"),
      tags$ul(uiOutput("movie_urls"))
      ),
    
    mainPanel(
      h1("Porównanie zabitych w wybranych filmach"), 
      plotOutput("body_count_cmp"),
      plotOutput("body_ratio_cmp"),
      plotOutput("body_to_permin_cmp"),
      plotOutput("body_rating_cmp")
      )
  ))
)