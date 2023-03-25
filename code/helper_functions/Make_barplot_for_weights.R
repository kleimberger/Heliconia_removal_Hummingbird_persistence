make_barplot <- function(data, xvar, yvar, xlabel, ylabel, highlight_column, titlelabel = "", flip_axes = FALSE, text_size){
  
  plot <- data %>% 
    ggplot(aes(x = forcats::fct_reorder(.data[[xvar]], .data[[yvar]]), y = .data[[yvar]], fill = .data[[highlight_column]])) +
    geom_bar(stat = "identity", width = c(0.6)) +
    labs(x = xlabel, y = ylabel, title = titlelabel) +
    theme_bw(base_size = text_size) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = text_size * 0.75, face = "italic"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())+
    scale_fill_manual(values = c("grey60", "#BA0022"), guide = "none")
  
  if(flip_axes == "TRUE"){
    
    plot <- data %>% 
      ggplot(aes(x = forcats::fct_reorder(.data[[xvar]], .data[[yvar]]), y = .data[[yvar]], fill = .data[[highlight_column]])) +
      geom_bar(stat = "identity", width = c(0.6)) +
      labs(x = xlabel, y = ylabel, title = titlelabel) +
      theme_bw(base_size = text_size) +
      theme(axis.text.y = element_text(size = text_size * 0.75, face = "italic"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank()) +
      scale_fill_manual(values = c("grey60", "#BA0022"), guide = "none") +
      coord_flip() +
      scale_y_continuous(expand = c(0, 0.01)) #Make bars go closer to y axis
  }
  
  #Italicize Heliconia
  if(titlelabel == "Heliconia specialists"){
    
    plot <- plot +
      labs(title = italic(Heliconia)~"specialists")
    
  }
  
  return(plot)
  
}
