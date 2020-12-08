library(shiny)
library(DT)
library(dplyr)
library(tibble)
library(ggplot2)

dataInput <- as.tibble(read.csv("filmdeathcounts.csv")) %>%
  mutate(Body_per_minute=Body_Count / Length_Minutes)

shinyServer(function(input, output) {
  output$movie_select <- renderDataTable({dataInput[c("Film")]}, filter="top", rownames=FALSE)
  
  observeEvent(input$clean, {
    output$movie_select <- renderDataTable({dataInput[c("Film")]}, filter="top", rownames=FALSE)
  })
  
  output$body_count_cmp <- renderPlot({
    subset = dataInput[as.numeric(input$movie_select_rows_selected), ] %>%
      arrange(desc(Body_Count))
    
    ggplot(subset, aes(y=reorder(Film, -Body_Count), x=Body_Count)) + geom_bar(stat="identity") + xlab("Zabici") + ylab("Film")
  })
})