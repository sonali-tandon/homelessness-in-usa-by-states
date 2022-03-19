library(plotly)
library(dplyr)
library(readr)
library(rio)
library(extrafont)
library(echarts4r)


path <- "D:/WinterQuarter/IMT 561/Homeless project/cocdatafinalcopy.xlsx" 
  #inner_join(state, by.x = State, by.y = state) %>%

print(path)

  

homeless_df <- import_list(path, setclass = "tbl", rbind = TRUE) %>%
  select(Year, Codeval, `Overall Homeless by State`, Female, Male, State)

print(homeless_df)



fontStyle = list(
  family = "DM Sans",
  size = 15,
  color = "black"
)

label = list(
  bgcolor = "#EEEEEE",
  bordercolor = "transparent",
  font = fontStyle
)

homeless_graph = plot_geo(homeless_df,
                          locationmode = 'USA-states',
                          frame = ~Year) %>%
  
  add_trace(locations = ~Codeval,
            z = ~`Overall Homeless by State`,
            reversescale = TRUE,
            zmin = 0,
            #zmax = max(homeless_df$`Overall Homeless by State`),
            zmax = 160000,
            color = ~`Overall Homeless by State`,
            text = ~paste(homeless_df$State, homeless_df$Codeval, sep = "<br />", homeless_df$`Overall Homeless by State`),
            hoverinfo = "text",
            colorscale = 'Viridis') %>%
  
  layout(geo = list(scope = 'usa'),
         font = list(family = "DM Sans"),
         title = "\nOverall Homeless Population in the US by state\n2007 - 2020") %>%
  style(hoverlabel = label) %>%
  config(displayModeBar = FALSE) 
  

homeless_graph
