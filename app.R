library(shiny)
library(shinyWidgets)
library(ggridges)
library(tidyverse)
library(viridis)
library(plotly)
library(colorspace)

data <- haven::read_dta("data.dta")
#cols <- c(#a50026','#d73027','#f46d43','#fdae61','#fee090','#ffffbf','#e0f3f8','#abd9e9','#74add1','#4575b4','#313695'])
cols <- rainbow_hcl(20)


# Define UI for application
ui <- fluidPage(
   
   # Application title
   titlePanel("Educational selectivity of immigrants in Germany"),
   
   # Sidebar with input 
   sidebarLayout(
      sidebarPanel(
         selectInput("origingroup",
                     "Select country:",
                     choices = list(
                        "All"=c("All"),
                        "Guest worker:"=c("Turkey", "Italy", "Spain", "Greece", "Portugal"),
                        "Eastern Europe:"=c("Poland", "Croatia","Kazakhstan","Romania","Russian Federation","Serbia","Ukraine"),
                        "Western Europe:"=c("Austria","France","Netherlands","United Kingdom"),
                        "Other:"=c("Iran","Morocco","Viet Nam", "USA")),
                     selected="All"),
        radioButtons("sex",
                     "Sex:",
                     choices = c("Both"= 999,
                                 "Male" = 0,
                                 "Female" = 1),
                     selected=999),
        sliderInput("residency",
                     "Years since immigration",
                     value=5,
                     min=0,
                     max=50),
        sliderTextInput("timeframe_start",
                    "Time frame (start):",
                    choices=c(1976,1978,1980,1982,1985,1987,1989,1991,1993,1995,1996:2013),
                    selected=1976,
                    grid=T),
        sliderTextInput("timeframe_end",
                        "Time frame (end):",
                        choices=c(1976,1978,1980,1982,1985,1987,1989,1991,1993,1995,1996:2013),
                        selected=2013,
                        grid=T),
        #radioButtons("colorscheme",
         #            "Choose a color scheme:",
          #           choices = c("plasma" = "C",
           #                      "viridis" = "D",
            #                     "cividis" = "E"),
             #        selected="E"),
        radioButtons("aggregation",
                     "Level of aggregation:",
                     choices = c("Yearly" = "mig_year",
                                 "5-Years" = "year"),
                     selected="year")
      ),
      
      mainPanel(
        #textOutput("intro"),
        
        
        tabsetPanel(
          #tabPanel("Introduction",        
          #         textOutput("intro")
          #),
          tabPanel("Distributions",        
                  plotOutput("joyPlot")
                 ),
         tabPanel("Average trend lines",
                    plotlyOutput("trendplot")
                  ))
        )
      #mainPanel(
      #  textOutput("Intro"),
      #  plotOutput("joyPlot"),
      #  plotOutput("trendplot")
      #)

   )
)

# Define server logic 
server <- function(input, output) {
  
   output$intro <- renderText({ "Introductory comments" })
   
   output$joyPlot <- renderPlot({
      if (input$origingroup!="All"){
        if (input$sex!=999) {
          data_plot <- data %>% 
            rename(year2=input$aggregation) %>%
            filter(max_five<=input$residency) %>%
            filter(int_year<=input$timeframe_end) %>%
            filter(int_year>=input$timeframe_start) %>%
            filter(country==input$origingroup) %>%
            mutate(year2=(year2*(-1))) %>%
            filter(gender==input$sex)
        } else {
          data_plot <- data %>% 
            rename(year2=input$aggregation) %>%
            filter(max_five<=input$residency) %>%
            filter(int_year<=input$timeframe_end) %>%
            filter(int_year>=input$timeframe_start) %>%
            filter(country==input$origingroup) %>%
            mutate(year2=(year2*(-1)))
        }
      } else {
        #data$year <- data[,input$aggregation]
        if (input$sex!=999) {
          data_plot <- data %>% 
            rename(year2=input$aggregation) %>%
            filter(max_five<=input$residency) %>%
            filter(int_year<=input$timeframe_end) %>%
            filter(int_year>=input$timeframe_start) %>%
            mutate(year2=(year2*(-1))) %>%
            filter(gender==input$sex)
        } else {
          data_plot <- data %>% 
            rename(year2=input$aggregation) %>%
            filter(max_five<=input$residency) %>%
            filter(int_year<=input$timeframe_end) %>%
            filter(int_year>=input$timeframe_start) %>%
            mutate(year2=(year2*(-1)))
        }
        
      }
      
      subtitle <- paste0("from ",input$origingroup, " (n=",nrow(data_plot),")")
      
      ggplot(data_plot, aes(x = as.numeric(select), y = as.factor(year2), fill = ..x..))+ 
        geom_density_ridges_gradient(scale=5, size=1, alpha=0.5) +
        scale_fill_viridis(name="Relative \neducation", option="E", direction=-1, limits=c(0,100), breaks=c(0,50,100))  + 
        labs(title = 'Educational selectivity',subtitle=subtitle, x="",y="Year of immigration")  +
        scale_x_continuous(limits=c(0, 100), expand = c(0.01, 0), breaks=c(25,50,75)) +
        scale_y_discrete(breaks=c("-1950","-1960","-1970","-1980","-1990","-2000","-2010"),labels=c("1950","1960","1970","1980","1990","2000","2010")) +
        theme_ridges() +
        geom_vline(xintercept = 50, color="black", size=1)
   })
   
   output$trendplot <- renderPlotly({
     if (input$sex!=999) {
      data_trend <- data %>%
          rename(year2=input$aggregation) %>%
          filter(max_five<=input$residency) %>%
          filter(int_year<=input$timeframe_end) %>%
          filter(int_year>=input$timeframe_start) %>%
          filter(gender==input$sex) %>%
          select(select, country, year2) %>%
          mutate(year2=abs(year2)) %>%
          group_by(country, year2) %>%
          summarise(select=mean(select))
     } else {
       data_trend <- data %>%
          rename(year2=input$aggregation) %>%
          filter(max_five<=input$residency) %>%
          filter(int_year<=input$timeframe_end) %>%
          filter(int_year>=input$timeframe_start) %>%
          select(select, country, year2) %>%
          mutate(year2=abs(year2)) %>%
          group_by(country, year2) %>%
          summarise(select=mean(select))
     }
     
     
     if (input$origingroup!="All"){
       cntries <- unique(data$country)
       ind <- which(cntries==input$origingroup)
       col_array <- c(rep("grey75", times=(ind-1)), cols[ind], rep("grey75", times=(length(cntries)-ind)))
     
       ggplotly(ggplot(data_trend, aes(x=as.numeric(year2))) + 
          geom_line(aes(y=select, col=as.factor(country)), size=1) +
          labs(x="Year of immigration", y="Relative education", title="Trends in average educational selectivity", subtitle="in Germany") + 
          theme_classic() + geom_hline(yintercept=50, col="black", linetype=1, size=0.5) +
          theme(legend.title = element_blank()) +
          scale_y_continuous(breaks=c(0,25,50,75,100), limits=c(0,100)) +
          scale_x_continuous(breaks=c(1950,1960,1970,1980,1990,2000,2010)) +
          scale_color_manual(values=col_array) +  
          geom_line(data=data_trend %>% filter(country==input$origingroup), aes(y=select), col=col_array[ind], size=1)) 
        
     } else {
       
       ggplotly(ggplot(data_trend, aes(x=as.numeric(year2))) + 
         geom_line(aes(y=select, col=as.factor(country)), size=1) +
         labs(x="Year of immigration", y="Relative education", title="Trends in average educational selectivity", subtitle="in Germany") + 
           theme_classic() + geom_hline(yintercept=50, col="black", linetype=1, size=0.5) +
         theme(legend.title = element_blank()) +
         scale_y_continuous(breaks=c(0,25,50,75,100), limits=c(0,100)) +
         scale_x_continuous(breaks=c(1950,1960,1970,1980,1990,2000,2010)) +
         scale_color_manual(values=rainbow_hcl(20)))  
     }
     
    })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

