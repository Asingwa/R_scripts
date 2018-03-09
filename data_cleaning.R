# Libraries

library(dplyr)

# Data cleaning. 
# There are various reasons for cleaning data before using it for analysis. 

# Let us use a dataset that is availabe within base R

data_to_clean <- airquality

# We will start by exploring this data set in order to know various attributes about it. For instance
# how many rows and columns does it have, what are the names of the columns and what are their data types.

# Number of columns
length(data_to_clean)
ncol(data_to_clean)

# Names of columns
names(data_to_clean)

# Structure of dataframe
str(data_to_clean)

dplyr::glimpse(data_to_clean)

# In the case where you want to know the data type of the object you are working on
class(data_to_clean)

class(data_to_clean$Wind)
class(data_to_clean$Month)

# Note that month has been categorised as type integer. We would like this to be factor or categorical.

data_to_clean$Month <- as.factor(data_to_clean$Month)

# Sometimes it is necessary to leave the categorical variables with numerical values. However, let's say that in
# our case, we would like the variable month to be indicated by the month name. Let's change this
levels(data_to_clean$Month) # To see the levels. Notice that they are not stored as integers but as string

levels(data_to_clean$Month) <- list(May = "5", June="6", July="7", August="8", September = "9")
levels(data_to_clean$Month)

# We may want to know the number of observation per category of a variable. In our instance use could use Month.
xtabs(~data_to_clean$Month, data = data_to_clean)

# To present this data into a data frame simply...
as.data.frame(xtabs(~data_to_clean$Month, data = data_to_clean))
# Part of cleaning data is identifying outliers. Scatter plots help us to visualize data and detect outliers
# To see the relationship between the variables in our data frame
plot(data_to_clean)

# Let us focus on the relationship between Ozone and Temperature. 
attach(data_to_clean) # When using one data set it can be convenient to store the variables in working memory so that
# you don't have to use '$' all through. Remember to detach() after.

plot(Ozone, Temp)

# We can see outliers here. It is possible to determine those outliers from the scatter plot.

outlier_index <- identify(Ozone, Temp) # This allows you to click on points of interest on a plot and store their index.

# Click the outliers and once done click FINISH.
# The points will be indicated by their index values.

# To label the points with other values, for instance, the month
plot(Ozone, Temp)
outlier_index <- identify(Ozone, Temp, labels = Month, plot=TRUE)

# Dealing with outliers is beyond the scope of this lab session. :-)

# paste(as.character(Date), "_", as.character(Month))
detach(data_to_clean)


# Now let's try some summary stats
summary(data_to_clean)
# Here we get the summary stats. However, notice that there are NA values.

mean(data_to_clean$Ozone)


mean(data_to_clean$Ozone, na.rm = TRUE)

# So what do we do with the the NAs?

# To see how many missing values are in each variable or column
colSums(is.na(data_to_clean))

# We could remove all observations with NA. Note that may significantly reduce the sample size.
no_na <- na.omit(data_to_clean)
summary(no_na)
mean(no_na$Ozone)

# We may substitute all the NAs with 0 or with the mean of the variable excluding NA. 
# With 0
with_zero <- data_to_clean
with_zero$Ozone[is.na(with_zero$Ozone)] = 0
mean(with_zero$Ozone)

# or with the mean of the variable excluding NA
with_mean <- data_to_clean
with_mean$Ozone[is.na(with_mean$Ozone)] = mean(with_mean$Ozone, na.rm=TRUE)
mean(with_mean$Ozone)

# Maintains the mean since all new values were the same as the mean

# To demonstrate this further if necessary.
tester <- c(1,1,NA)
mean(tester)
mean(tester, na.rm=TRUE)
mean(na.omit(tester))



