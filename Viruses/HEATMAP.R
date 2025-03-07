library(tidyverse)
library(pheatmap)
library(RColorBrewer)

setwd("virtak/PanPhylo/")
# Load data
df <- read.csv("transposed_counts_heatmap_in.csv", header = TRUE, row.names = 1, check.names = F)

df_grouped <- df %>%
  group_by(Category) %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE))

df_grouped_filtered <- df_grouped %>%
  filter(Category != "UNK" & Category != "Not found" & Category != "other") 

# Set row names
df_grouped_filtered <- df_grouped_filtered %>%
  column_to_rownames("Category")

# Convert to matrix
matrix_data <- as.matrix(df_grouped_filtered)

annotation = read.csv("contig_annotation.csv")
annotation <- annotation %>%
  column_to_rownames("contig")

best_hit_class_list <- unique(annotation$Virus_class)
best_hit_class_colors <- setNames(c("dodgerblue","#98004F")[1:length(best_hit_class_list)], best_hit_class_list)

host_order_list <- unique(annotation$Host_order)
host_order_colors <- c("Flavobacteriales" = "#4DAF4A",
                       "Burkholderiales" = "#2765B8",
                       "Mycobacteriales" = "#FF7F00",
                       "Enterobacterales" = "#984EA3",
                       "Nanopelagicales" = "#FFFF33",
                       "Chitinophagales" = "#E41A1C")
  
lys_lyt_list <- unique(annotation$Lyt_Lys)
lys_lyt_colors <- setNames(c("darkcyan", "#D4C825")[1:length(lys_lyt_list)], lys_lyt_list)

animal_host_list <- unique(annotation$Animal_host)
animal_host_colors <- setNames(c("pink", "#999999")[1:length(animal_host_list)], animal_host_list)

ann_colors <- list(
  Virus_class = best_hit_class_colors,
  Host_order = host_order_colors,
  Lyt_Lys = lys_lyt_colors,
  Animal_host = animal_host_colors
)

normalize_row <- function(x) (x - min(x)) / (max(x) - min(x))  # Min-Max normalization
matrix_scaled <- t(apply(matrix_data, 1, normalize_row))
pheatmap(matrix_scaled, annotation_col = annotation, annotation_colors = ann_colors,
         treeheight_row = 30, treeheight_col = 30, 
         cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("white","lightgreen","green3","forestgreen","darkgreen"))(100),
         display_numbers = T, number_format = "%.1f", angle_col = 90, 
         filename = "heatmap_all_known_functions_norm_row.pdf", width = 14, height = 10)
