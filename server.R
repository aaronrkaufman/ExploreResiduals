#setwd("D://Dropbox//Compactness shared//code//explore_shiny")

#load("mcmcresults.RData")
load("explore_errors.RData")
load('test.RData')
ensemble_preds = as.numeric(ensemble_preds)
test2 = test2[order(test2$district),]
test$district = as.character(test$district)
# add corners, add xvar, add yvar

xy_str <- function(e) {
  return(c(e$x, e$y))
}

#dat$rank_schwartzberg = rank(fulldat$schwartzberg)
#fulldat$name_1 = sapply(1:102, FUN=function(x) paste(fulldat$district[x], ".jpg", sep=""))
testranks = test$testranks
grofman = rank(test$grofman)
polsby = rank(test$polsby*-1) #rev
reock = rank(test$reock*-1) #rev
schwartzberg = rank(test$schwartzberg)
avgline = rank(test$avg_line)
varline = rank(test$var_line)
hull = rank(test$hull)
boyce = rank(test$boyce)
vertices = rank(test$vertices)
perim = rank(test$district_perim)
lenwid = rank(test$lenwid)
corners = rank(test$corners)
xvar = rank(test$xvar)
yvar = rank(test$yvar)
boyce = rank(test$boyce)

human1 = test2$rank1
human2 = test2$rank2

xy_range_str <- function(e) {
  if(is.null(e)) return("NULL\n")
  paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1), 
         " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
}




server = function(input, output, session) {
  
  # Currently selected dataset
  curdata <- reactive({
    switch(input$measure, "Reock" = reock, "Polsby" = polsby, "Grofman" = grofman, "Schwartzberg" = schwartzberg, "Boyce-Clark" = boyce,
           "Avg Edge Length" = avgline, "Edge Length Variance" = varline, "Convex Hull" = hull, "Vertex Count" = vertices,
           "Perimeter" = perim, "Length/Width" = lenwid, "Corner Count" = corners, "Corner Horizontal Variance" = xvar, 
           "Corner Vertical Variance" = yvar, "Ensemble Prediction" = ensemble_preds, "Hand-Coded Avg" = testranks, "Human 1" = human1, "Human 2" = human2)
  })
  
  curdata2 <- reactive({
    switch(input$measure2, "Reock" = reock, "Polsby" = polsby, "Grofman" = grofman, "Schwartzberg" = schwartzberg, "Boyce-Clark" = boyce,
           "Avg Edge Length" = avgline, "Edge Length Variance" = varline, "Convex Hull" = hull, "Vertex Count" = vertices,
           "Perimeter" = perim, "Length/Width" = lenwid, "Corner Count" = corners, "Corner Horizontal Variance" = xvar, 
           "Corner Vertical Variance" = yvar, "Ensemble Prediction" = ensemble_preds, "Hand-Coded Avg" = testranks, "Human 1" = human1, "Human 2" = human2)
  })
  
  
  
  output$plotui <- renderUI({
    plotOutput("plot", height=300, width=300,
               click = "plot_click",
               )
  })
  
  output$plot <- renderPlot({
    
    xvals <- rank(curdata())
    #print(xvals)
    yvals <- rank(curdata2())
    plot(xvals, yvals, xlab = input$measure, ylab=input$measure2, pty="s", main = paste("Correlation:", cor(xvals, yvals)))
    abline(lm(yvals~xvals), col="red")
    
  })
  
  plotclick_to_fn = function(pc){
    loc =xy_str(pc)
    #print(loc)
    #closest_point = sapply(1:102, FUN=function(x) dist(rbind(loc, cbind(fulldat$mcmcres, unlist(curdata()))[x,])))
    closest_point = sapply(1:102, FUN=function(x)  sqrt( (loc[1]-rank(curdata())[x])^2  + (loc[2] - rank(curdata2())[x])^2  )  ) 
    #print(closest_point)
    idx = which(closest_point ==min(closest_point))
    #print(idx)
    #filename <- normalizePath(file.path('./www/images',
    #                                    paste(fulldat$name_1[idx], sep="")))
    filename = normalizePath(file.path('./www/images', paste(district[idx], ".jpg", sep="")))
    #print(filename)
    return(filename)
  }
  
  observeEvent(input$plot_click,
  output$plot_clickinfo <- renderImage({
    list(src = plotclick_to_fn(input$plot_click),
         height=300)
  }, deleteFile = FALSE))
  
  observeEvent(input$plot_click,
               output$district_name <- renderText({expr = plotclick_to_fn(input$plot_click)})
  )
  

  observeEvent(input$measure1,
               output$plot_clickinfo <- renderText({NULL})) # nice hack
  observeEvent(input$measure2,
               output$plot_clickinfo <- renderText({NULL}))
  
}