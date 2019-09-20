#Codebook for final exercise of the Coursera "getting and cleaning data course project"
###By vdM

1. The environment was cleared and the libraries used were loaded
2. The raw dataset was downloaded and unzipped in the folder "UCI HAR Dataset"
3. Each datafile was assigned to a variable
- features:     features.txt; 561 observations of 2 variables
    - contains accelerometer and gyroscope data from 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- activities:   activity_labels.txt; 6 observations of 2 variables
    - activities performed when corresponding measurements were taken, including labels
- subjectTest:  subject_test.txt; 2947 observations of 1 variable
    - test subjects (9/30)
- xTest:        X_test.txt; 2947 observations of 561 variables
    - test data
- yTest:        y_test.txt; 2947 observations of 1 variable
    - test data of activities labels
- subjectTrain: subject_train.txt; 7352 observations of 1 variable
    - Train subjects (21/30)
- xTrain:       X_train.txt; 7352 observations of 561 variables
    - train data
- yTrain:       y_train.txt; 7352 observations of 1 variable
    - train data of activities labels

4. Merging data using rbind() and cbind() commands
5. Linking activity names to respective codes
6. Making names sensible; using dots "." to improve readability
- "Acc", to "accelerometer"
- "Gyro", to "gyroscope"
- "BodyBody", to "body"
- "Mag", to "magnitude"
- "^t", to "time"
- "^f", to "frequency"
- "timeBody", to "time body"
- "frequencyBody", to "frequency body"
- "timeGravity", to "time gravity"
- "-mean()", to "mean"
- "-std()", to "std"
- "-freq()", to "frequency"
7. Grouping each variable for each activity and each subject, and subsequently calculating the mean
8. Exporting data to "finalDataset.txt" 