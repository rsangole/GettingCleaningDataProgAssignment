The result dataset contains the subject numbers, activity labels, and measurement means for the 'test' and 'train' datasets combined; specifically combining X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt.

There are 68 total columns:
- Subject: Subjects are identified via integers 1,2,3... A total of 30 subjects exist in the file.
- Activity: Activity contains a total of 6 activities - laying, sitting, standing, walking, walking downstairs and walking upstairs.
- 66 columns containing averages of technical data. From the original input file, only columns containing mean() and std() are kept for further processing. All other columns are dropped. This reduces the columns from 564 to 66. The values under each column are the averages of measurements for each subject:activity combination.

For each subject, for each activity, there is one row of data. Thus, there are a total of 6 x 30 = 180 rows of data.

If the column name starts with Freq-, the averages are for frequency domain measurements. If the column name starts with Time-, the averages are for time domain measurements.

The column names for the measurement types (66 columns) are renamed from the original, to make them more readable to end-users. For example:
tBodyAccel-mean()-X  --->  Time-Accel-Mean-X
fBodyAccMag-mean()   --->  Freq-Acceleration_Magnitude-Mean
Time-, and Freq- indicate Time and Freq domain measurements respectively. -X, -Y and -Z indicate direction.

From the original dataset, y_train or y_test contains numbers corresponding to activities. The descriptions for these activities are in activity_labels.txt. These descriptions are updated in the final dataset. 