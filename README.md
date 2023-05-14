[![DOI](https://zenodo.org/badge/529424640.svg)](https://zenodo.org/badge/latestdoi/529424640)

# Tropical plant–hummingbird interactions withstand short-term experimental removal of a common flowering plant

Analyses for second chapter of dissertation, published in [*Oikos*](https://doi.org/10.1111/oik.09919)

**Question** 

How do hummingbirds respond after a plant species is lost from the community? Do they abandon the area, or do they expand their diet to feed on new plant species – thus allowing them to persist? 

And does loss of a common plant species cause cascading effects for the pollination success of the remaining flowering plants?

**Approach**

I temporarily removed the inflorescences of a locally common flowering plant, *Heliconia tortuosa*, from forested study sites surrounding the Las Cruces Biological Station in southern Costa Rica. This experiment followed a before-after-control-impact (BACI) design.

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

All of the code in the 'analysis' folder can be run with the [datasets on Dryad](https://doi.org/10.5061/dryad.jwstqjqbh).

```bash

code
   |-- analysis
   |   |-- 01_analyzing_camera_data.Rmd
   |   |-- 02_analyzing_capture_data.Rmd
   |   |-- 03_analyzing_relative_body_mass.Rmd
   |   |-- 04_analyzing_telemetry_data.Rmd
   |   |-- 05_analyzing_pollen_tubes.Rmd
   |   |-- 06_compiling_visualizing_results.Rmd
   |   |-- 07_analyzing_camera_data_visit_duration.Rmd
   |   |-- 08_comparing_site_characteristics_control_vs_treatment.Rmd
   |   |-- 09_visualizing_weights_and_percentage_resources_removed.Rmd
   |   |-- knitted_markdown_files
   |   |   |-- 01_analyzing_camera_data.html
   |   |   |-- 02_analyzing_capture_data.html
   |   |   |-- 03_analyzing_relative_body_mass.html
   |   |   |-- 04_analyzing_telemetry_data.html
   |   |   |-- 05_analyzing_pollen_tubes.html
   |   |   |-- 06_compiling_visualizing_results.html
   |   |   |-- 07_analyzing_camera_data_visit_duration.html
   |   |   |-- 08_comparing_site_characteristics_control_vs_treatment.html
   |   |   |-- 09_visualizing_weights_and_percentage_resources_removed.html
   |-- helper_functions
   |   |-- Calculate_basic_summary_stats.R
   |   |-- Extract_data_from_safely_and_quietly_lists.R
   |   |-- Make_barplot.R
   |   |-- Modeling_helper_functions.R
   |   |-- Plotting_helper_functions.R
   |   |-- Summarize_camera_data.R
   |-- maps
   |   |-- Camera_icon_for_map_circle.png
   |   |-- Camera_icon_for_map_no_circle.png
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
   |   |-- 05_filtering_data_for_relative_body_mass.Rmd
   |   |-- 06_processing_telemetry_data.Rmd
   |   |-- 07_calculating_telemetry_effort.Rmd
   |   |-- 08_calculating_telemetry_time_at_location.Rmd
   |   |-- 09_creating_telemetry_response_variables.Rmd
   |   |-- 10_processing_summarizing_pollen_tubes.Rmd
   |   |-- 11_filtering_summarizing_camera_data_visit_duration.Rmd
   |   |-- 12_summarizing_camera_methods.Rmd
   |   |-- knitted_markdown_files
   |   |   |-- 01_delineating_focal_areas.html
   |   |   |-- 02_filtering_summarizing_camera_data.html
   |   |   |-- 03_calculating_capture_effort.html
   |   |   |-- 04_calculating_capture_and_recapture_rates.html
   |   |   |-- 05_filtering_data_for_relative_body_mass.html
   |   |   |-- 06_processing_telemetry_data.html
   |   |   |-- 07_calculating_telemetry_effort.html
   |   |   |-- 08_calculating_telemetry_time_at_location.html
   |   |   |-- 09_creating_telemetry_response_variables.html
   |   |   |-- 10_processing_summarizing_pollen_tubes.html
   |   |   |-- 11_filtering_summarizing_camera_data_visit_duration.html
   |   |   |-- 12_summarizing_camera_methods.html
   |   |-- unit_circle.png
data
   |-- import
   
```
