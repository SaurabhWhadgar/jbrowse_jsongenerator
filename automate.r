library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "JBrowse-JG"),
  dashboardSidebar(
    selectInput(inputId = 'filetype',
                label = 'Enter File Type',
                choices = c("BAM","BAM-Coverage","VCF"))
  ),
  
        
  dashboardBody(
    box(title = "Category of track", status = "primary", solidHeader = T, collapsible = T, width=4,
        textInput("category", "Category of track", "BAM / Population1")),
    box(title = "Key for track : Displayed on JBrowse", status = "primary", solidHeader = T, collapsible = T, width=4,
        textInput("key", "Key On JBrowse", "")),
    box(title = "Label for track", status = "primary", solidHeader = T, collapsible = T, width=4,
        textInput("label", "Label", "")),
    box(title = "File path including file-name and file-extension", status = "warning", solidHeader = T, collapsible = T, width=12,
        textInput("filepath", "File Path", "/data/bam/bamfile.bam")),
    box(title = "Generated Code", status = "primary", solidHeader = T, collapsible = T, width=12,
    textOutput("code"),
    verbatimTextOutput("placeholder", placeholder = TRUE)),
  
    tags$footer(HTML('<p><center> Saurbah Whadgar(MSc 07): Institute of Bioinformatics And Applied Biotechnology<center><p>'), align = "center", style = "
              position:absolute;
              bottom:25px;
              width:100%;
              height:50px;   /* Height of the footer */
              color: white;
              padding: 0px;
              background-color: black;
              z-index: 100;")
    
    )
  
  

)

server <- function(input, output) { 
  
 output$placeholder<-reactive({
  if(input$filetype =='BAM'){
          paste0('{\n','"category" :"', input$category,'",\n',
             '"key" : "',input$key,'",\n',
             '"label" : "',input$label,'",\n',
             '"storeClass"    : "JBrowse/Store/SeqFeature/BAM",\n',
             '"type"          : "JBrowse/View/Track/Alignments2",\n',
             '"baiUrlTemplate":"',input$filepath,'.bai",\n',
             '"urlTemplate"   : "',input$filepath,'"\n}\n')
  }
   
   else if(input$filetype =='BAM-Coverage'){
     paste0('{\n','"category" :"', input$category,'",\n',
            '"key" : "',input$key,'",\n',
            '"label" : "',input$label,'",\n',
            '"storeClass"    : "JBrowse/Store/SeqFeature/BAM",\n',
            '"type"          : "SNPCoverage",\n',
            '"urlTemplate"   : "',input$filepath,'"\n}\n')
   }
   
   else if (input$filetype =='VCF'){
     paste0('{\n','"category" :"', input$category,'"\n',
                   '"key" : "',input$key,'",\n',
                   '"label" : "',input$label,'",\n',
                   '"storeClass"    : "JBrowse/Store/SeqFeature/VCFTabix",\n',
                   '"type"          : "JBrowse/View/Track/HTMLVariants",\n',
                   '"urlTemplate"   : "',input$filepath,'"',"\n},\n")
   }


 })
 

  }

shinyApp(ui, server)