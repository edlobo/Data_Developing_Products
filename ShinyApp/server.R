library(shiny)
library(dplyr)

data <- read.csv("/Users/elobo/HomeRstudio/Curso9/Shiny/DSuniversity/data/timesMergedData.csv")
# check cols with NA
        calc_NA <- function(x){sum(is.na(x))/length(x)*100}
        check_NA <- as.data.frame(apply(data,2,calc_NA))
# check with numbers
# table(check_NA[,1] > 20.0)
# take off columns with NAs
        valid <- check_NA[,1] > 20.0
        validnames <- rownames(check_NA)[!valid]

finaldf <- data[,validnames]
finaldf <- unique(finaldf)

shinyServer(function(input, output) {
        
        dataset <- reactive({
                finaldf %>% filter(STATE==input$text1, TYPE==input$button1)
        })
        
        output$distPlot1 <- renderPlot({

                G1 <- ggplot(data=dataset(), aes(x=PROGRAM)) + geom_bar(aes(fill=SCHOOL), alpha=0.8) + coord_flip()
                        #theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position="bottom") 
                
                G1
        })
        
        output$distPlot2 <- renderPlot({

                G2 <- ggplot(data=dataset(), aes(x=PROGRAM, colour=SCHOOL)) + geom_point(aes(y=DURATION), alpha=0.8, size=4) +
                        theme_bw() +
                        theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position="bottom")
                
                G2
        })
        
        schoolcount <- reactive({
                finaldf %>% filter(TYPE==input$button1, STATE==input$text1) %>% select(PROGRAM) %>% count()
        })
        
        output$text1 <- renderText({ 
                                paste("Number of programs: ", as.character(schoolcount()))
                        
                        })
       
})
