#############################
##Make interaction plot
############################
#Plot estimated marginals means for:
#control pre, control post, treatment pre, treatment post
make_interaction_plot <- function(ggeffects_df, yvar, ymin, ymax, ybreak, yaccuracy, text_size, point_size, line_size, as_percent = TRUE){
  
  #Colors and shapes
  colors <- c("#0E0D37", "#BA0022") #blue, red
  shapes <- c(16, 17) #circle, triangle (filled)

  #Label for y-axis
  if(yvar == "sightings"){ylabel <- c("Visits per hour")}
  if(yvar == "num_birds"){ylabel <-  c("Number of birds captured")}
  if(yvar == "prop_time_in_patch"){ylabel <- c("Time spent in focal area (%)")}
  if(yvar == "prop_with_tubes"){ylabel <- c("Flowers pollinated (%)")}
  if(yvar == "relative_mass"){ylabel <- c("Relative body mass")}
  
  #Group/legend labels
  group_labels <- c("control" = "Control", "treatment" = "Treatment")
  legend_label <- c(expression(paste(italic("Heliconia "), "removal", sep = "")))
 
  if(as_percent == TRUE){
    
    if(yvar == "prop_with_tubes" | yvar == "prop_time_in_patch"){
      
      ggeffects_df <- ggeffects_df %>%
        mutate(predicted = predicted * 100, 
               conf.low = conf.low * 100,
               conf.high = conf.high * 100)
      
      ymax <- ymax * 100
      ymin <- ymin * 100
      
      if(yvar == "prop_time_in_patch"){ylabel <- c("Time spent in focal area (%)")}
      if(yvar == "prop_with_tubes"){ylabel <- c("Flowers pollinated (%)")}

      }
    
  }
  
  plot <- ggeffects_df %>%
    mutate(group = factor(group, levels = c("control", "treatment"), labels = c("Control", "Treatment"))) %>%
    mutate(x = factor(x, levels = c("pre", "post"), labels = c("Pre", "Post"))) %>%
    ggplot(data = ., aes(x = x, y = predicted, colour = group, shape = group)) + 
      geom_point(aes(x = x, y = predicted, colour = group), position = position_dodge(width = 0.25), size = point_size) +
      geom_line(aes(group = group), position = position_dodge(0.25), alpha = 0.6, size = line_size) +
      geom_errorbar(aes(ymin = conf.low, ymax = conf.high), position = position_dodge(width = 0.25), width = 0.00, size = line_size) +
      theme_bw(base_size = text_size) +
      theme(legend.position = "bottom",
            legend.direction = "horizontal",
            legend.text = element_text(size = text_size),
            legend.title = element_text(size = text_size),
            panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
      scale_y_continuous(limits = c(ymin, ymax), breaks = seq(from = ymin, to = ymax, by = ybreak), labels = scales::number_format(accuracy = yaccuracy)) +
      scale_color_manual(values = colors, labels = group_labels) +
      scale_shape_manual(values = shapes, labels = group_labels) +
      labs(x = "Experimental period", y = ylabel, colour = legend_label, shape = legend_label)
  
  if(yvar == "relative_mass"){
    
    plot <- plot +
      scale_y_continuous(limits = c(0.9, 1.1), breaks = c(0.9, 1.0, 1.1), labels = scales::number_format(accuracy = 0.1))
    
  }
  
  return(plot)
  
}

##################################
#Make control vs. treatment plot
##################################
#This plot is similar to interaction plot, but for response variables not calculated at the level of experimental period (control vs. treatment only)
make_control_vs_treatment_plot <- function(ggeffects_df, yvar, ymin, ymax, ybreak, yaccuracy, text_size, point_size, line_size, as_percent = TRUE){
  
  #Colors and shapes
  colors <- c("#0E0D37", "#BA0022") #blue, red
  shapes <- c(16, 17) #circle, triangle (filled)
  legend_label <- c(expression(paste(italic("Heliconia "), "removal", sep = "")))
  
  #Label for y-axis
  if(yvar == "recap_rate"){ylabel <- c("Proportion of birds recaptured")}
  
  if(as_percent == TRUE){
    
    if(yvar == "recap_rate"){
      
      ggeffects_df <- ggeffects_df %>%
        mutate(predicted = predicted * 100, 
               conf.low = conf.low * 100,
               conf.high = conf.high * 100)
      
      ymax <- ymax * 100
      ymin <- ymin * 100
      ybreak <- 25
      yaccuracy <- NULL
      ylabel <- c("Probability of recapture (%)")
      
      }
  }
  
  plot <- ggeffects_df %>%
    mutate(x = factor(x, levels = c("control", "treatment"), labels = c("Control", "Treatment"))) %>%
    ggplot(data = ., aes(x = x, y = predicted, colour = x, shape = x)) +
    geom_point(aes(x = x, y = predicted), position = position_dodge(width = 0.25), size = point_size) +
    geom_errorbar(aes(ymin = conf.low, ymax = conf.high), position = position_dodge(width = 0.25), width = 0.0, size = line_size) +
    scale_y_continuous(limits = c(ymin, ymax), breaks = seq(from = ymin, to = ymax, by = ybreak), labels = scales::number_format(accuracy = yaccuracy)) +
    scale_color_manual(values = colors) +
    scale_shape_manual(values = shapes) +
    theme_bw(base_size = text_size) +
    theme(legend.position = "none",
          legend.direction = "horizontal",
          legend.text = element_text(size = text_size),
          legend.title = element_text(size = text_size),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    labs(x = "", y = ylabel, colour = legend_label, shape = legend_label)
  
  return(plot)
  
}

###########################################################
#Make plot of interaction contrast + CI ("contrast plot")
###########################################################
#Will need to customize axes, etc. separately, but this will make the basic plot
#estimate_name = name of the column that has the point estimate (e.g., odds.ratio, ratio, etc.)
make_contrast_plot <- function(contrasts_df, xvar, xlabel = "", text_size, point_size, line_size){
  
  legend_text_labels <- c(expression("All species"), expression(paste(italic("Heliconia "), "specialists", sep = "")))
  
  fill_color = "#999999" #fill for shading
  alpha_value = 0.75 #alpha for shading
 
  plot_data <- contrasts_df %>%
    mutate(order = seq.int(nrow(.)))
  
  #For body mass, line needs to be at ZERO, not one
  if("body_mass" %in% contrasts_df$analysis){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio)) +
      geom_point(position = position_dodge(.5), shape = 18, size = point_size) +
      geom_errorbar(aes(ymax = upper.CL, ymin = lower.CL, group = bird_group), position = position_dodge(.5), width = 0, size = line_size) + # error bars show 95% confidence intervals
      geom_hline(yintercept = 0, color = "black", linetype = "dashed", alpha = 0.8, size = line_size) + # add a line at 0 (no effect)
      theme_bw(base_size = text_size) +
      scale_shape_manual(values = c(16, 17), labels = legend_text_labels, limits = c("all_spp", "greh_visa")) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            legend.position = "bottom",
            legend.justification = "center",
            legend.text = element_text(size = text_size),
            legend.title = element_text(size = text_size)) +
      labs(x = xlabel, y = "Experimental effect", shape = "Bird group")
  
  return(plot)
    
  }
  
  #For pollination, will not have separate bird groups
  if("pollen_tubes" %in% contrasts_df$analysis){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio)) +
      annotate("rect", xmin = -Inf, xmax = Inf, ymax = 0.5, ymin = 0, alpha = alpha_value, fill = fill_color) +
      geom_point(position = position_dodge(.5), shape = 18, size = point_size) + 
      geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL),  position = position_dodge(.5), width = 0, size = line_size) + # error bars show 95% confidence intervals
      geom_hline(yintercept = 1, color = "black", linetype = "dashed", alpha = 0.8, size = line_size) + # add a line at 1 (no effect)
      theme_bw(base_size = text_size) +
      scale_shape_manual(values = c(16)) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            legend.position = "bottom",
            legend.justification = "center",
            legend.text = element_text(size = text_size),
            legend.title = element_text(size = text_size)) +
      labs(x = xlabel, y = "Experimental effect")

    return(plot)
    
  }
  
  #For hummingbird-centric variables, will have separate bird groups
  if(!("pollen_tubes" %in% contrasts_df$analysis)){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio)) +
      annotate("rect", xmin = -Inf, xmax = Inf, ymax = 0.5, ymin = 0, alpha = alpha_value, fill = fill_color) +
      geom_point(position = position_dodge(.5), shape = 18, size = point_size) + 
      geom_errorbar(data = plot_data, aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio, ymin = lower.CL, ymax = upper.CL, group = bird_group), position = position_dodge(.5), width = 0, size = line_size) + # error bars show 95% confidence intervals
      geom_hline(yintercept = 1, color = "black", linetype = "dashed", alpha = 0.8, size = line_size) + # add a line at 1 (no effect)
      theme_bw(base_size = text_size) +
      labs(x = xlabel, y = "Experimental effect") +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            legend.position = "none")

    return(plot)
    
  }
  
}
