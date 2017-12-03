
library(shiny)
library(ggplot2)


# ui.R
ui <- fluidPage(
  # Application title
  titlePanel("I have tried, but cannot render the plot and I am not sure why"),
  
  sidebarLayout(
    # Sidebar
    sidebarPanel( 
      
      # Radio button for separator
      radioButtons(inputId = "separator"
                   , label = "Select the separator in your dataset" 
                   , choices = c(Comma = "," 
                                 , Tab = "\t")
                   , selected = ","
      ),
      
      
      # File input
      fileInput("file1", "Choose File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      
      
      #Checkbox input
      checkboxInput("logscaled", "Log-transform and scale?", FALSE),
      

      # Select input X
      selectInput("inputx", "X axis",
                  c("PC1" = "PC1",
                    "PC2" = "PC2",
                    "PC3" = "PC3",
                    "PC4" = "PC4")),
      
      # Select input Y
      selectInput("inputy", "Y axis",
                  c("PC1" = "PC1",
                    "PC2" = "PC2",
                    "PC3" = "PC3",
                    "PC4" = "PC4")),            
                  
      
      
      actionButton("plotnow", "Plot!")
    ),
    # Show outputs
    mainPanel(tableOutput("table"),
              plotOutput("disPlot"))
  )
)

  
# server.R
server <- 
  # Define server logic required to plot and show tables
  shinyServer(function(input, output, session) {
    
    

    
    
    
    # table with the head of the imputed file
    output$table <- renderTable({

      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)

      

      
      data <- read.table(inFile$datapath, header = TRUE, sep = input$separator)
      
      #Rescale data if checked
      if (input$logscaled == TRUE) 
        data <- return(log2(data + 1))
      
        

      
      head(data)
      
    })
    
    
    # Plot
    output$distPlot <- renderPlot({
      
      ####Charge the data again
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      
      
      
      data <- read.table(inFile$datapath, header = TRUE, sep = input$separator)
      
      #Rescale data if checked
      if (input$logscaled == TRUE) 
        data <- return(log2(data + 1))
      
      #Transformations like in exercise 1
      datamatrix <- as.matrix(data)
      datamatrixscaled <- t(scale(t(datamatrix)))
      PCAgenes <- prcomp(t(datamatrixscaled), center = TRUE, scale = TRUE)
      PCAgenes$var <- PCAgenes$sdev ^ 2
      PCAgenesdf <- data.frame(as.factor(paste0("PC", seq(1 : 4))), (PCAgenes$var[1 : 4] / sum(PCAgenes$var)))
      colnames(PCAgenesdf) <- c("PC", "value")
      
      #Subselect the dataframe
      df <- PCAgenesdf[c(input$inputx, input$inputy), ]
      
      #I plot the projection onto the first two components
      pointsplot <- plot(df[ , 1], df[ , 2])
      pointsplot
      
    })

    

    

    
  })




# Run the app
shinyApp(ui = ui, server = server)