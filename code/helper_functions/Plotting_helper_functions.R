#############################
##Make interaction plot
############################
#Plot estimated marginals means for:
#control pre, control post, treatment pre, treatment post
make_interaction_plot <- function(ggeffects_df, yvar, ymin, ymax, ybreak, yaccuracy, as_percent = TRUE){
  
  #Colors and shapes
  colors <- c("#0E0D37", "#BA0022") #blue, red
  shapes <- c(16, 17) #circle, triangle (filled)
  
  #Label for y-axis
  if(yvar == "sightings"){ylabel <- c("Visits/day")}
  if(yvar == "num_birds"){ylabel <-  c("Birds captured")}
  if(yvar == "prop_time_in_patch"){ylabel <- c("Proportion time in focal area")}
  if(yvar == "prop_with_tubes"){ylabel <- c("Proportion flowers pollinated")}
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
      
      if(yvar == "prop_time_in_patch"){ylabel <- c("% time in focal area")}
      if(yvar == "prop_with_tubes"){ylabel <- c("% flowers pollinated")}

      }
    
  }
  
  plot <- ggeffects_df %>%
    mutate(group = factor(group, levels = c("control", "treatment"), labels = c("Control", "Treatment"))) %>%
    mutate(x = factor(x, levels = c("pre", "post"), labels = c("Pre", "Post"))) %>%
    ggplot(data = ., aes(x = x, y = predicted, colour = group, shape = group)) + 
      geom_point(aes(x = x, y = predicted, colour = group), position = position_dodge(width = 0.25), size = 3.5) +
      geom_line(aes(group = group), position = position_dodge(0.25), alpha = 0.6, size = 1) +
      geom_errorbar(aes(ymin = conf.low, ymax = conf.high), position = position_dodge(width = 0.25), width = 0.00, size = 1) +
      theme_bw(base_size = 18) +
      theme(legend.position = "bottom", legend.direction = "horizontal", panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
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
make_control_vs_treatment_plot <- function(ggeffects_df, yvar, ymin, ymax, ybreak, yaccuracy, as_percent){
  
  #Label for y-axis
  if(yvar == "recap_rate"){ylabel <- c("Proportion of birds recaptured")}
  
  if(as_percent == TRUE){
    
    if(yvar == "recap_rate"){
      
      gggeffects_df <- ggeffects_df %>%
        mutate(predicted = predicted * 100, 
               conf.low = conf.low * 100,
               conf.high = conf.high * 100)
      
      ymax <- ymax * 100
      ymin <- ymin * 100
      ylabel <- c("Probability of recapture (%)")}
    
  }
  
  plot <- ggeffects_df %>%
    mutate(x = factor(x, levels = c("control", "treatment"), labels = c("Control", "Treatment"))) %>%
    ggplot(data = ., aes(x = x, y = predicted)) + #Multiply by 100 to get percent
    geom_point(aes(x = x, y = predicted), position = position_dodge(width = 0.25), size = 4) +
    geom_errorbar(aes(ymin = conf.low, ymax = conf.high), position = position_dodge(width = 0.25), width = 0.0, size = 1) +
    scale_y_continuous(limits = c(ymin, ymax), breaks = seq(from = ymin, to = ymax, by = ybreak), labels = scales::number_format(accuracy = yaccuracy)) +
    theme_bw(base_size = 18) +
    theme(legend.position = "none",
          legend.direction = "horizontal",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          plot.title = element_text(hjust = 0.5)) +
    labs(x = "", y = ylabel, shape = "", color = "")
  
  return(plot)
  
}

###########################################################
#Make plot of interaction contrast + CI ("contrast plot")
###########################################################
#Will need to customize axes, etc. separately, but this will make the basic plot
#estimate_name = name of the column that has the point estimate (e.g., odds.ratio, ratio, etc.)
make_contrast_plot <- function(contrasts_df, xvar, shading = "none"){
  
  legend_text_labels <- c(expression("All species"), expression(paste(italic("Heliconia "), "specialists", sep = "")))
  
  size = 18 #base size
  
  plot_data <- contrasts_df %>%
    mutate(order = seq.int(nrow(.)))
  
  #For body mass, line needs to be at ZERO, not one
  if("body_mass" %in% contrasts_df$analysis & shading == "below"){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio)) +
      geom_rect(xmax = Inf, xmin = -Inf, ymax = 0, ymin = -Inf, fill = "grey90", alpha = 1) +
      geom_point(aes(shape = bird_group), position = position_dodge(.5), size = 3) +
      geom_errorbar(aes(ymax = upper.CL, ymin = lower.CL, group = bird_group), position = position_dodge(.5), width = 0.25, size = 1) + # error bars show 95% confidence intervals
      geom_hline(yintercept = 0, color = "black", linetype = "dashed", alpha = 0.8) + # add a line at 0 (no effect)
      theme_bw(base_size = size) +
      scale_shape_manual(values = c(16, 17), labels = legend_text_labels, limits = c("all_spp", "greh_visa")) +
      theme(legend.position = "top", legend.justification = "center", legend.text = element_text(size = 18), legend.title = element_text(size = 18),
            panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
      labs(x = "", y = "Change", shape = "Bird group")
    
    return(plot)
    
  }
  
  if(shading == "below"){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio)) +
        geom_rect(xmax = Inf, xmin = -Inf, ymax = 1, ymin = 0, fill = "grey90", alpha = 1)
  }
  
  if(shading == "above"){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio)) +
        geom_rect(xmax = Inf, xmin = -Inf, ymax = Inf, ymin = 1, fill = "grey90", alpha = 1)
    
  }
  
  if(shading == "none"){
    
    plot <- plot_data %>%
      ggplot(data = ., aes(x = forcats::fct_reorder(.data[[xvar]], order), y = ratio))
    
  }
  
  #For pollination, will not have separate bird groups
  if("pollen_tubes" %in% contrasts_df$analysis){
    
    plot <- plot +
      geom_point(position = position_dodge(.5), size = 3) + 
      geom_errorbar(position = position_dodge(.5), aes(ymax = upper.CL, ymin = lower.CL), width = 0.25, size = 1) + # error bars show 95% confidence intervals
      geom_hline(yintercept = 1, color = "black", linetype = "dashed", alpha = 0.8) + # add a line at 1 (no effect)
      theme_bw(base_size = size) +
      scale_shape_manual(values = c(16)) +
      theme(legend.position = "top", legend.justification = "center", legend.text = element_text(size = 18), legend.title = element_text(size = 18),
            panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
      labs(x = "", y = "Ratio")
    
    return(plot)
    
  }
  
  #For hummingbird-centric varibles, will have separate bird groups
  if(!("pollen_tubes" %in% contrasts_df$analysis)){
    
    plot <- plot +
      geom_point(aes(shape = bird_group), position = position_dodge(.5), size = 3) +
      geom_errorbar(aes(ymax = upper.CL, ymin = lower.CL, group = bird_group), position = position_dodge(.5), width = 0.25, size = 1) + # error bars show 95% confidence intervals
      geom_hline(yintercept = 1, color = "black", linetype = "dashed", alpha = 0.8) + # add a line at 1 (no effect)
      theme_bw(base_size = size) +
      scale_shape_manual(values = c(16, 17), labels = legend_text_labels, limits = c("all_spp", "greh_visa")) +
      theme(legend.position = "top", legend.justification = "center", legend.text = element_text(size = 18), legend.title = element_text(size = 18),
            panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
      labs(x = "", y = "Ratio", shape = "Bird group")
    
    return(plot)
    
  }
  
}
