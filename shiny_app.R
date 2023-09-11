
# palmer penguins 데이터셋으로 shiny app 만들기

# 패키지를 불러온다.
library(shiny)
library(tidyverse)
library(palmerpenguins)

# ui.R 파일에 들어갈 shiny app의 레이아웃을 정의한다.

ui <- fluidPage(
  titlePanel("패키지를 활용한 shiny app 만들기"),
  sidebarLayout(
    sidebarPanel(
      selectInput("species", "펭귄 종류를 선택하세요", 
                  choices = unique(penguins$species))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# server.R 파일에 들어갈 shiny app의 서버를 정의한다.

server <- function(input, output) {
  output$plot <- renderPlot({
    penguins %>% 
      filter(species == input$species) %>% 
      ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
      geom_point()
  })
}

# shiny app을 실행한다.

shinyApp(ui = ui, server = server)

