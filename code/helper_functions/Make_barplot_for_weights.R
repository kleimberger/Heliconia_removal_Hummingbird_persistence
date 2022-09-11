make_barplot <- function(data, xvar, yvar, xlabel, ylabel, highlight_column, titlelabel, flip_axes = FALSE){
  
  plot <- data %>% 
    ggplot(aes(x = reorder(.data[[xvar]], -.data[[yvar]]), y = .data[[yvar]], fill = .data[[highlight_column]]))+
    geom_bar(stat = "identity", width = c(0.6))+
    labs(x = xlabel, y = ylabel, title = titlelabel)+
    theme_bw(base_size = 20) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 16, face = "italic"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())+
    scale_fill_manual(values = c("dark grey", "#BA0022"), guide = "none")
  
  if(flip_axes == "TRUE"){
    
    plot <- data %>% 
      ggplot(aes(x = reorder(.data[[xvar]], .data[[yvar]]), y = .data[[yvar]], fill = .data[[highlight_column]]))+
      geom_bar(stat = "identity", width = c(0.6)) +
      labs(x = xlabel, y = ylabel, title = titlelabel)+
      theme_bw(base_size = 20)+ #Increase text size for AOS talk
      theme(axis.text.y = element_text(size = 16, face = "italic"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank())+
      scale_fill_manual(values = c("dark grey", "#BA0022"), guide = "none") +
      coord_flip() +
      scale_y_continuous(expand = c(0, 0.05)) #Make bars go closer to y axis
  }
  
  #Italicize Heliconia
  if(titlelabel == "Heliconia specialists"){
    
    plot <- plot +
      labs(title = italic(Heliconia)~"specialists")
    
  }
  
  return(plot)
}