# Getting And Cleaning Data in R - CodeBook for Course Project

The data set is the result of processing a data from the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UCI Machine Learning Repository regarding Human Activity Recognition Using Smartphones</a>.  The actual dataset archive was downloaded here:<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">UCI HAR Dataset</a>

This dataset represents a merging of the training and test datasets available in the UCI HAR Dataset.  It has been filtered to contain only variables relating to the mean and standard deviations for various accelerometer measurements within the study.  Each data point represents the average of those measurements grouped by the test subject Id and the activity.

<pre>
Variable Explanations: 
Variable Name      Type    Explanation
=================  ======  =======================================================
Subject.Id         int     The identifier of the test/training subject
Activity.Name      Factor  A factor describing the activity 
tBodyAcc.mean.X    num     There are 48 data columns of this type. Please refer to
 .                         data descriptions available in the UCI HAR Dataset
 .                         for detailed meaning.
 .
fBodyGyro.mean.Z
</pre>
