# In order to map these 1,000 points first, view will be automatically set to NYC. 
# If we want to add a filter functionality into the map in the future, we’ll have to first 
# create a reactive object and put our dataset in it. 
# This will allow us to instantly filter the dataset and update the map accordingly.

server <- function(input,output, session){
  
  data <- reactive({
    x <- df
  })
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(lng = ~Longitude,
                 lat = ~Latitude,
                 popup = paste("Offense", df$Offense, "<br>",
                               "Year:", df$CompStat.Year))
    m
  })
}