# run_analysis
Getting Cleaning Data Course Project

Instructions for run_analysis.R file included in the same repo.

run_analysis code deliveres secondary data file "second_dataset" as described in course project instructions 1 - 5 steps.
the code starts with Samsung data download from the web. to avoid the download first two lines of the code can be skipped but the Samsung data needs to be stored in working directory and named 'data.zip'.
run_analysis.R will unzip files and place them in original directories, that will be created as needed. 
That step is followed by data reading from those created directories. It is important not to modify unzipped data, not to add, rename, or delete any files from there. 

Lines 12 to 32 perfoms data reading.

Step 1.
Lines 35 to 45 performs data merging as described in instructions Step 1.
variable names are similr to those as original data file names. activities, number coded, are in variable y. 

Step 2.
Lines 47 to 53 extracts variables associated with mean and standard deviation from X data as described in instructions Step 2.

Step 3.
Lines 57 to 72 perform renaming of activities from code number to character describing activity ("walking", "sitting", etc)
code descibtions are in activities file. Those lines perform task described in the instructions Step 3.

Step 4.
Lines 73  to 80 perform renaming of variables to more suitable format as per instructions Step 4. Note, that original variable names
have symbols like ")", and "-". After renaiming those symbols no longer there. After that step data are stored in data matrix called DATA, where 1st column is subject (study person), 2nd is activity ("sitting", etc) and subsequent columns are mean and standard deviation values for many inputs.

Step 5. 
Lines 83 to 85 perform data grouping and summarizing following the instructions Step 5. The final output is named "second_dataset" 

Finally, last few lines of the code, save "second_dataset" into "seconddatafile.txt" within the initial working directory and deletes all other variables and data from R environment. Only second_dataset is output.

