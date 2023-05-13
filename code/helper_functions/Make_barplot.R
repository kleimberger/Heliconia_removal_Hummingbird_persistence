make_barplot <- function(data, xvar, yvar, xlabel, ylabel, highlight_column, titlelabel = "", flip_axes = FALSE, text_size){
  
  if(flip_axes == "FALSE"){desc = TRUE}
  if(flip_axes == "TRUE"){desc = FALSE}
  
  plot <- data %>% 
    ggplot(aes(x = forcats::fct_reorder(.data[[xvar]], .data[[yvar]], .desc = desc), y = .data[[yvar]], fill = .data[[highlight_column]])) +
    geom_bar(stat = "identity", width = c(0.6)) +
    labs(x = xlabel, y = ylabel, title = titlelabel) +
    theme_bw(base_size = text_size) + 
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    theme(plot.title = element_text(margin = margin(0,0,1,0))) + #Position title closer to plot
    scale_fill_manual(values = c("grey60", "#BA0022"), guide = "none") +
    scale_y_continuous(expand = c(0, 0.05)) #Make bars go closer to y axis
  
  if(flip_axes == "FALSE"){
    
    plot <- plot +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = text_size * 0.75, face = "italic")) +
      theme(plot.margin = margin(5.5, 5.5, 5.5, 18.5, "pt")) #top, right, bottom, and left margins
  }
  
  if(flip_axes == "TRUE"){
   
    plot <- plot +
      theme(axis.text.y = element_text(size = text_size * 0.75, face = "italic")) +
      coord_flip()
    
  }
  
  #Italicize Heliconia
  if(titlelabel == "Heliconia specialists"){
    
    plot <- plot +
      labs(title = italic(Heliconia)~"specialists")
    
  }
  
  return(plot)
  
}
