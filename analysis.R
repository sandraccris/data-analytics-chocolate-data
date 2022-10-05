#Install tidyverse package
install.packages ("tidyverse")
library (tidyverse)

#Find out more about how the data is organized. Data has 1795 Rows and 9 Columns.
View (flavors_of_cacao)
colnames(flavors_of_cacao)
glimpse(flavors_of_cacao)

#Rename Column "Company \n(Maker-if known)" to "Maker", Column "Cocoa Percent" to "cocoa_percent" and "Company Location" to company_location for clarity and consistency.
  flavor_df <- flavors_of_cacao %>% 
    rename(Maker=`Company 
(Maker-if known)`, cocoa_percent=`Cocoa
Percent`, company_location=`Company
Location`)
#Create new data frame with relevant variables to analysis. 
trimmed_flavors_df <- flavor_df %>% 
  select(Rating, cocoa_percent, Maker, company_location)
#Find the mean value for the variable Rating.
trimmed_flavors_df %>%
  summarise(mean_rating=mean(Rating))
#Rating greater than or equal to 3.5 points considered high rating. Super dark chocolate if the bar's cocoa percent is greater than or equal to 70%.
#Filter the data frame for chocolate bars that contain at least 70% cocoa and have a rating of at least 3.5 points.
best_trimmed_flavors_df <- trimmed_flavors_df %>% 
  filter(cocoa_percent>="70%", Rating >=3.5)
#Create a bar chart for visualization with Variable "company_location".
ggplot(data=best_trimmed_flavors_df)+geom_bar(mapping=aes(x=company_location, fill=Rating))+scale_x_discrete(guide=guide_axis(n.dodge = 3))+labs(title="Highest Rated Chocolate Bar by Country")
# Save plot as a png file with chocolate as the file name
ggsave("chocolate.png")
