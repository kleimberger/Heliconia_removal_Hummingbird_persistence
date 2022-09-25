# Heliconia_removal_Hummingbird_persistence

Analyses for [hummingbird persistence manuscript](https://www.biorxiv.org/content/10.1101/2022.02.24.481682v2) (second chapter of dissertation)

**Question** 

How do hummingbirds respond after a plant species is lost from the community? Do they abandon the area, or do they expand their diet to feed on new plant species – thus allowing them to persist? 

And does loss of a common plant species cause cascading effects for the pollination success of the remaining flowering plants?

**Approach**

I temporarily removed the inflorescences of a locally common flowering plant, *Heliconia tortuosa*, from forested study sites surrounding the Las Cruces Biological Station in southern Costa Rica. This experiment followed a Before-After-Control-Impact design.

I gathered data on hummingbird abundance, space use, and plant-hummingbird interactions using four complementary approaches:

1.	Mist net captures
    -	Number of hummingbirds captured

2.	Movements of radio-tagged hummingbirds
    -	Proportion of time spent in removal area

3.	Trail cameras positioned at flowering plants
    -	Number of visits per hour

4.	Plant pollination success
    -	Proportion of flowers pollinated

To determine whether *Heliconia* removal affected these response variables, I conducted statistical analyses using generalized linear mixed models (Poisson, betabinomial, and negative binomial families).

**Results**

No evidence that hummingbirds changed their movements and foraging patterns to cope with removal of a locally common resource. Similarly, no evidence of changes in plant pollination success.

**Repository organization**

Code sub-folders should be run in the following order:

1. response_variables
2. resource_estimate
3. making_maps
4. statistical_analysis

```bash

code
   |-- helper_functions
   |   |-- Calculate_basic_summary_stats.R
   |   |-- Extract_data_from_safely_and_quietly_lists.R
   |   |-- Make_barplot_for_weights.R
   |   |-- Modeling_helper_functions.R
   |   |-- Plotting_helper_functions.R
   |   |-- Summarize_camera_data.R
   |-- making_maps
   |   |-- Making_maps_Calculating_distance_between_sites.Rmd
   |-- resource_estimate
   |   |-- 01_handling_unknown_count_units.Rmd
   |   |-- 02_estimating_flowers_per_inflorescence.Rmd
   |   |-- 03_summarizing_nectar_measurements.Rmd
   |   |-- 04_calculating_calories_per_flower.Rmd
   |   |-- 05_calculating_calories_per_plant.Rmd
   |   |-- 06_summarizing_resource_availability.Rmd
   |   |-- knitted_markdown_files
   |   |   |-- 01_handling_unknown_count_units.html
   |   |   |-- 02_estimating_flowers_per_inflorescence.html
   |   |   |-- 03_summarizing_nectar_measurements.html
   |   |   |-- 04_calculating_calories_per_flower.html
   |   |   |-- 05_calculating_calories_per_plant.html
   |   |   |-- 06_summarizing_resource_availability.html
   |-- response_variables
   |   |-- 01_delineating_focal_areas.Rmd
   |   |-- 02_filtering_summarizing_camera_data.Rmd
   |   |-- 03_calculating_capture_effort.Rmd
   |   |-- 04_calculating_capture_and_recapture_rates.Rmd
   |   |-- 05_processing_telemetry_data.Rmd
   |   |-- 06_calculating_telemetry_time_at_location.Rmd
   |   |-- 07_calculating_telemetry_effort.Rmd
   |   |-- 08_creating_telemetry_response_variables.Rmd
   |   |-- 09_processing_summarizing_pollen_tubes.Rmd
   |   |-- 10_summarizing_camera_methods.Rmd
   |   |-- knitted_markdown_files
   |   |   |-- 01_delineating_focal_areas.html
   |   |   |-- 02_filtering_summarizing_camera_data.html
   |   |   |-- 03_calculating_capture_effort.html
   |   |   |-- 04_calculating_capture_and_recapture_rates.html
   |   |   |-- 05_processing_telemetry_data.html
   |   |   |-- 06_calculating_telemetry_time_at_location.html
   |   |   |-- 07_calculating_telemetry_effort.html
   |   |   |-- 08_creating_telemetry_response_variables.html
   |   |   |-- 09_processing_summarizing_pollen_tubes.html
   |   |   |-- 10_summarizing_camera_methods.html
   |-- statistical_analysis
   |   |-- 01_analyzing_camera_data.Rmd
   |   |-- 02_analyzing_capture_data.Rmd
   |   |-- 03_analyzing_relative_body_mass.Rmd
   |   |-- 04_analyzing_telemetry_data.Rmd
   |   |-- 05_analyzing_pollen_tubes.Rmd
   |   |-- 06_compiling_visualizing_results.Rmd
   |   |-- knitted_markdown_files
   |   |   |-- 01_analyzing_camera_data.html
   |   |   |-- 02_analyzing_capture_data.html
   |   |   |-- 03_analyzing_relative_body_mass.html
   |   |   |-- 04_analyzing_telemetry_data.html
   |   |   |-- 05_analyzing_pollen_tubes.html
   |   |   |-- 06_compiling_visualizing_results.html
   
  ```
