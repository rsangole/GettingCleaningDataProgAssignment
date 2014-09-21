Description of the script:

First, we set the working directory, and include needed libraries.

Then, the features.txt and activity_labels.txt are imported to incorporate into the final dataset.

Test and train datasets are imported using read.table. Generic column names V1, V2, V3... are corrected to the right column names from features.txt. This is done using setNames(). Then, test and train datasets are combined with subject and activity datasets using cbind(). Columns names for subject and activity are renamed appropriately.

Step 1 -> Combine test and train datasets into one, called 'combined' using rbind()

Step 2 -> Select only columns that contain mean() or std() programmatically using select(...,contains())

Step 3 -> Labels under activity_labels.txt are assigned to the activity numbers in the combined dataset as factors using gl() and factor().

Tidy long form of data is stored in 'tidy' variable using melt().

Factor variables for dataset, activity and measurement_type are converted into character variables for easier processing downstream.

Step 4 -> Rename measurement_type programatically to make it easier for user to read using sub().

Step 5 - Summarize means for each subject, for each activity and store 1 result per row using dcast() on the tidy dataset.

Write final result tidy dataset to a file for evaluation using write.table().