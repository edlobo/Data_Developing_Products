library(shiny)
library(ggplot2)

# Getting Data
 data <- read.csv("/Users/elobo/HomeRstudio/Curso9/Shiny/DSuniversity/data/timesMergedData.csv")

# check cols with NA
        calc_NA <- function(x){sum(is.na(x))/length(x)*100}
        check_NA <- as.data.frame(apply(data,2,calc_NA))
# check with numbers
# table(check_NA[,1] > 20.0)
# take off columns with NAs
        valid <- check_NA[,1] > 20.0
        validnames <- rownames(check_NA)[!valid]
#
        finaldf <- data[,validnames]
        finaldf <- unique(finaldf)

shinyUI(fluidPage(
        br(), 
        # Application title
        titlePanel("Data Science Program Offering in the US "),
        br(),
        # Sidebar with a slider input for number of bins 
        sidebarLayout(
                sidebarPanel(
                        selectInput('text1', h3('Select a state'),  
                                    choices = unique(finaldf$STATE[order(finaldf$STATE)]),  
                                    selected = "California"
                                    ),
                        radioButtons('button1', h3('Define type of Program'),  
                                     choices = unique(finaldf$TYPE),  
                                     selected = "M"
                                     )
                        
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                        tabsetPanel(
                                tabPanel("Documentation",
                                         
                                         helpText(br(),"Nowadays popularity on data manipulation, analysis and insight findings from data has been taking more adepts. ",
                                                  "Most univertities and colleges are now caring about this need by giving options on different disciplines to provide deep knowledge for improving these skills.",
                                                  br(),br(),"This shiny app is intended to show a general overview about what is the current program offer on Data Science for those who want to have an initial aprroach",
                                                  "on this field  by checking which options are available for a particular state along the US territory. From the input dataset, based on the user selection ",
                                                  "results are shown pointing program type and name, as well as duration in terms of program structure.",
                                                  br(),br(),"The app is designed to divide the main panel into two tabs, according to the to kind of information for the visual overview.",
                                                  br(),br(),"First tab there will be the program name offered by the school, on the other tab the duration,",
                                                 "The only action required by user will be to choose a target state in which he is interested to see the program offer.",
                                                 br(),br(),"Finally, there is also an option in which the user may choose by which type of program the particular school is giving,",
                                                 "so by selecting M from the buttom box a selection of Master Programs will delimit the search, same way by selecting option C for Certification Programs. "
                                         )
                                ),
                                tabPanel("Programs by School",
                                         br(),br(),
                                         plotOutput("distPlot1", height = "500px"),
                                         br(),
                                         #textOutput("text1", h3("Total programs found"))
                                         fluidRow(column(3, textOutput("text1"))),
                                         br()
                                ),
                                tabPanel("Program Duration",
                                         br(),br(),
                                         plotOutput("distPlot2", height = "800px")
                                        
                                )
                        )

                        
                )
        )
)
)
        
