library(shiny)
library(DT)
library(dplyr)
library(tibble)
library(ggplot2)
library(purrr)
library(rvest)
library(memoise)

get_url <- function(movie, year){
  movie_name = gsub(" ", "+", movie)
  paste0("https://www.imdb.com/search/title/?title=",movie_name,"&release_date=",
         toString(year),"-01-01,",
         toString(year),"-12-31&view=simple&count=1")
}

get_movie_url <- function(url){
  page = read_html(url)
  movie.nodes <- html_nodes(page,'.col-title a')  
  movie.link = sapply(html_attrs(movie.nodes),`[[`,'href')
  
  paste0("https://www.imdb.com", movie.link)
}

get_movie_url_memo <- memoise(get_movie_url)

dataInput <- as.tibble(read.csv("filmdeathcounts.csv")) %>%
  mutate(Body_per_minute=Body_Count / Length_Minutes) %>%
  mutate(Url = pmap_chr(list(Film, Year), get_url))

shinyServer(function(input, output) {
  output$movie_select <- renderDataTable({dataInput[c("Film")]}, filter="top", rownames=FALSE)
  
  observeEvent(input$clean, {
    output$movie_select <- renderDataTable({dataInput[c("Film")]}, filter="top", rownames=FALSE)
  })
  
  output$movie_urls <- renderUI({
    subset = dataInput[as.numeric(input$movie_select_rows_selected), ] %>%
      mutate(MovieUrl = pmap_chr(list(Url), get_movie_url_memo))
    
    apply(subset, 1, function(x) {tags$li(tags$a(x['Film'], href=x['MovieUrl']))})
  })
  
  output$body_count_cmp <- renderPlot({
    subset = dataInput[as.numeric(input$movie_select_rows_selected), ] %>%
      arrange(desc(Body_Count))
    
    ggplot(subset, aes(y=reorder(Film, -Body_Count), x=Body_Count, fill=Body_Count)) + 
      geom_bar(stat="identity") + 
      # scale_fill_manual(palette="Reds") +
      xlab("Zabici") + ylab("Film") + 
      labs(title="PoróWnanie zabitych w wybranych filmach")
  })
  
  output$body_ratio_cmp <- renderPlot({
    subset = dataInput[as.numeric(input$movie_select_rows_selected), ] %>%
      arrange(desc(Body_per_minute))
    
    ggplot(subset, aes(y=reorder(Film, -Body_per_minute), x=Body_per_minute, fill=Body_per_minute)) + 
      geom_bar(stat="identity") + 
      # scale_fill_manual(palette="Reds") +
      xlab("Zabici na minutę") + ylab("Film") + 
      labs(title="PoróWnanie zabitych na minute w wybranych filmach")
  })
  
  output$body_to_permin_cmp <- renderPlot({
    subset = dataInput[as.numeric(input$movie_select_rows_selected), ] %>%
      arrange(desc(Body_per_minute))
    
    ggplot(subset, aes(y=Body_per_minute, x=Body_Count, color=Film)) + 
      geom_point(size=8) + 
      # scale_fill_manual(palette="Reds") +
      xlab("Zabici na minutę") + ylab("Zabici") + 
      labs(title="Stosunek zabitych do zabitych na minutę")
  })
  
  output$body_rating_cmp <- renderPlot({
    subset = dataInput[as.numeric(input$movie_select_rows_selected), ] %>%
      arrange(desc(Body_per_minute))
    
    ggplot(subset, aes(y=IMDB_Rating, x=Body_Count, color=Film)) + 
      geom_point(size=8) + 
      # scale_fill_manual(palette="Reds") +
      xlab("Zabici") + ylab("Ocena IMDB") + 
      labs(title="Stosunek zabójstw do oceny w IMDB")
  })
})