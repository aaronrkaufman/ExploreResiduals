ui = fluidPage(
  # Some custom CSS
  titlePanel("Exploring Compactness Measures - Test"),
  
  fluidRow(
    column(width=4,
           wellPanel(
             # I should put the demographic questions here!
             h5("Created by: Aaron Kaufman"),
             tags$a("The Institute for Quantitative Social Science", 
                    href="http://www.iq.harvard.edu"),
             h5("Click on the plot to see images of the data points!"),
             div(class = "option-group",
                 selectInput("measure", "Measure 1",
                              choices = c( "Reock", "Polsby", "Grofman", "Schwartzberg", "Boyce-Clark", "Avg Edge Length", "Edge Length Variance", "Convex Hull",
                                           "Vertex Count", "Perimeter", "Length/Width", "Corner Count", "Corner Horizontal Variance", 
                                           "Corner Vertical Variance", "Ensemble Prediction", "Hand-Coded Avg", "Human 1", "Human 2"),
                             selected = "Ensemble Prediction"),
                 selectInput("measure2", "Measure 2",
                             choices = c( "Reock", "Polsby", "Grofman", "Schwartzberg", "Boyce-Clark", "Avg Edge Length", "Edge Length Variance", "Convex Hull",
                                          "Vertex Count", "Perimeter", "Length/Width", "Corner Count", "Corner Horizontal Variance", 
                                          "Corner Vertical Variance", "Ensemble Prediction", "Hand-Coded Avg", "Human 1", "Human 2"),
                             selected = "Hand-Coded Avg")))),
    column(width=8,
           mainPanel(
             tabsetPanel(position="above",
                         tabPanel("Plots",
                                          uiOutput("plotui"),
                                         imageOutput("plot_clickinfo"),
                                          textOutput("district_name")
                                  ),
                         tabPanel("Descriptions",
                                  h4("Description of Measures"),
                                  h5("Reock: Area of the district divided by the area of hte minimum circumscribing circle"),
                                  h5("Polsby: Area of the district divided by the area of the circle with the same perimeter as the district"),
                                  h5("Grofman: Perimeter divided by the square root of the area"),
                                  h5("Schwartzberg: Perimeter of the district divided by the perimeter of the cirlce with the same area as the district"),
                                  h5("Boyce-Clark: Take the distance from the centroid to each vertex. Then take the mean deviation from the average distance as a proportion of that average distance."),
                                  h5("Avg Edge Length: Average length of the line segment between each pair of consecutive vertices of the district"),
                                  h5("Edge Length Variance: Variance of the length of line segments between each pair of consecutive vertices"),
                                  h5("Convex Hull: Area of the district divided by the area of hte minimum bounding convex hull"),
                                  h5("Vertex Count: Number of vertices required to draw the district shape"),
                                  h5("Perimeter: Perimeter of the district"),
                                  h5("Length/Width: Length divided by width of the minimum bounding rectangle"),
                                  h5("Corner Count: Number of strong corners as determined by Shi-Tomasi Algorithm"),
                                  h5("Corner Horizontal Variance: The variance in the x coordinate of the Shi-Tomasi Corners"),
                                  h5("Corner Vertical Variance: The variance in the y coordinate of the Shi-Tomasi Corners"),
                                  h5("Ensemble Prediction: Predicted Compactness Ranks for each district as determined by my ML ensemble"),
                                  h5("Hand-Coded Avg: Average Rank produced by human coders"),
                                  h5("Human 1: Ranks produced by Benjamin Delsman, Harvard College Class of 2019"),
                                  h5("Human 2: Ranks produced by Aaron Kaufman and Mayya Komisarchik")
                                  
                                  )
                         )
               )
             
             )))#,
  
  
 # fluidRow(
  #  column(width = 6,
   #        uiOutput("plotui"),
    #       imageOutput("plot_clickinfo")
    #)
#  ))
