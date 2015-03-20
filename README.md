# run_analysis.R
The course project for the Coursera Getting and Cleaning Data Course

run_analysis.R performs the following tasks:
1.	It merges the training and the test sets to create a single data set.
2.	It extracts only the measurements on the mean and standard deviation for each (non-identifier) variable.
3.	It uses easily identifiable labels to name the activities in the data set
4.	It creates a second, independent, tidy (and much smaller) data set with the average of each variable for each activity and each subject.

It does this in the following manner:
1.	The script starts by opening the plyr package (which must have previously been installed using install.packages) and creating a folder called "data" in the working directory if there is not one already.
2.	Then it downloads the dataset using the URL privided. The zip file is saved in the "data" folder and is then unzipped into a "UCI HAR Dataset" folder, located within the "data" folder.
3.	It loads the various data sets, presents their structure and then "rbinds" the various train and test datasets (i.e. combines the datasets toegether by rows).
4.	After this it combines the subject, activity and features data by column into one data frame called "Data".
5.	"Data" is then subsetted to keep the various identifiers plus the mean and standard deviation variables.
6.	Then it changes the names of the various types of activities into more readable forms.
7.	Then it makes a second, independent, tidy (and much smaller) data set containing the row names, the subject and activity identifiers and then the mean and standard deviation data for each of the other variables.
8.	This final data frame is then saved as a text file "tidydata.txt".
