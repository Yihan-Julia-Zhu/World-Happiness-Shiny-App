library(shiny)
library(shinythemes)
library(shinydashboard)
library(ggplot2)

fluidPage(
  theme = shinytheme("cerulean"),
  
  titlePanel("Pursuit of Happiness"),
  
  sidebarLayout(
    sidebarPanel(
      
      fluidRow(
        
        strong("Background:"),p("As per the Merriam-Webster dictionary happiness is defined as a 
state of well-being and contentment. Over the years, several attempts have been made to quantify happiness in order to assess 
the overall happiness of the world. One such significant survey was conducted 
by", a("Gallup World Poll",href="http://www.gallup.com/opinion/gallup/182843/happiest-people-world-swiss-latin-americans.aspx",target="_blank"),
                                "and the data from this study was compiled in the", a("World Happiness Report",href="http://worldhappiness.report/",target="_blank"),
                                "is 
available on" , a("Kaggle",href="https://www.kaggle.com/unsdsn/world-happiness",target="_blank"),
                                "for the years 2015, 2016 and 2017. As per this study, six key variables play a role in 
determining the overall happiness of a nation. These are--GDP per Capita, Family, 
Life Expectancy, Freedom, Generosity and Government Corruption. The purpose of this application 
is to provide life to the available raw data with visual graphics.")),
      
      selectInput("measure", "Select a variable", c("Happiness_Rank","Happiness_Score","REGION",
                                                    "Economy_GDP_Pc","Life_Expectancy",
                                                    "Freedom",
                                                    "Govt_Corruption","Generosity")),
      
      selectInput("year", "Select a year",
                  choices = as.character(unique(Happiness_Data$Year))),
      
      
      br(),
      br(),
    
      
      h6("The code and data can be found in", a("the github repo",href="https://github.com/Yihan-Julia-Zhu/World-Happiness-Shiny-App",target="_blank"))
    ),
    
    
    
    mainPanel(
      tabsetPanel(
        
        #### tab1 ####
        tabPanel("Geo Map", fluidRow(tags$h3("World Happiness Map"),
                                     
                                     p("Select a variable and a year from the sidebar panel and 
                                    
                                    click on any country to read additional information. The 
coloring scheme is from Green (most satisfactory) to Red (least satisfactory).  
                                    "),
                                     htmlOutput("map",
                                                click = "plot_click", height = "auto"),
                                     
                                     tableOutput("info"))),
        
        #### tab2 ####
        tabPanel("Box Plot",fluidRow(tags$h3("Distribution of Happiness Scores across Regions"),
            p("Select a year from the side panel to view the box plots on the happiness score. In these plots, 
              the happiness score is examined for various regions in the world. Higher score, means a happier region.")
          ),
          
          
          
          plotOutput("Box_Plot")),
        
        #### tab3 ####
        tabPanel("Tree Map", 
                 
                 fluidRow(
                   tags$h3("Top10 Happiest and Least Happiest Countries"),
                   p("Select a year from the side panel to view the tree plot that lists the top ten 
happiest and least happiest countries in the world. ")
                 ),
                 
                 
                 plotOutput("Misc_Plot1"),plotOutput("Misc_Plot2"))
        
      ))
  )
)
      
        
        
        
        