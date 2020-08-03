library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(ggplot2)
library(treemap)
library(googleVis)
library(RColorBrewer)

shinyServer(function(input, output,session) {
  
  output$choose_measure <- renderUI({
    selectInput("measure", "Statistic", measures)
  })
  
  # GEO map
  output$map <- renderGvis({
    gvisGeoChart(Happiness_Data[Happiness_Data$Year==as.numeric(input$year),],
                 locationvar="Country",
                 input$measure, options=list(region="world", displayMode="regions",
                                             resolution="countries",
                                             width="auto", height="auto",projection="mercator",
                                             colors=ifelse(input$measure %in% c("Govt_Corruption","Economy_GDP_Pc","Happiness_Score","Life_Expectancy","Freedom","Generosity", "REGION"),"['#780000', '#e71c1c', '#f9e407','#34f907','#0f5100']","['#0f5100','#34f907', '#f9e407','#e71c1c', '#780000']"),
                                             explorer=	"{actions:['dragToZoom', 'rightClickToReset']}"
                 ))
  })
  
  # Box plot
  output$Box_Plot <- renderPlot({
    
    
    df=Happiness_Data[Happiness_Data$Year==input$year,]
    g <- ggplot(df, aes(reorder(REGION,Happiness_Score),Happiness_Score))
    g + geom_boxplot(aes(fill=REGION), alpha=0.8) +
      labs(title=sprintf("Box plot %d",as.numeric(input$year)),
           y="Happiness Score",
           x="Region")+theme(axis.text=element_text(size=14),
                             axis.title=element_text(size=14,face="bold"))
    
  })
  
  # Tree plot
  output$Misc_Plot1 <- renderPlot({
    
    Tree_2015_top=Happiness_Data[Happiness_Data$Year==as.numeric(input$year),]%>% arrange(.,Happiness_Rank) %>% head(.,10)
    
    Tree_map_2015_top=treemap(Tree_2015_top, #Your data frame object
                              index=c("Happiness_Rank","Country"),  #A list of your categorical variables
                              vSize = "Happiness_Score",  #This is your quantitative variable
                              vColor="Happiness_Rank",
                              type="value",
                              title=sprintf("Happiest Nations in %d", as.numeric(input$year)),
                              palette=colorRampPalette(rev(brewer.pal(9, "YlGn")))(10),
                              lab = c(TRUE, TRUE),
                              fontsize.legend = 14, fontsize.title =14, fontsize.labels=14,
                              align.labels=list(
                                c("left", "top"), 
                                c("center", "center")
                              ),
                              format.legend = list(scientific = FALSE, big.mark = " "))
  })
  output$Misc_Plot2 <- renderPlot({
    Tree_2015_bottom=Happiness_Data[Happiness_Data$Year==as.numeric(input$year),]%>% arrange(.,desc(Happiness_Rank)) %>% head(.,10)
    
    Tree_map_2015_top=treemap(Tree_2015_bottom, #Your data frame object
                              index=c("Happiness_Rank","Country"),  #A list of your categorical variables
                              vSize = "Happiness_Score",  #This is your quantitative variable
                              vColor="Happiness_Rank",
                              type="value",
                              title=sprintf("Least Happy Nations in %d", as.numeric(input$year)),
                              palette=colorRampPalette(rev(brewer.pal(9, "RdPu")))(5),
                              lab = c(TRUE, TRUE),
                              align.labels=list(
                                c("left", "top"), 
                                c("center", "center")
                              ),
                              fontsize.legend = 14, fontsize.title =14, fontsize.labels=14,
                              format.legend = list(scientific = FALSE, big.mark = " "))
  })
  
  
  
})