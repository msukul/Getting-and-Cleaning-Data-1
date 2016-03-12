require(plyr)

#Utils: function add suffix
aSuf<- function(x, suffix) {
  if (!(x %in% c("Subject","Activity"))) {
    paste(x,suffix, sep="")
  }
  else{
    x
  }
}

#Get data
pathf<-file.path(getwd(),"UCI HAR Dataset")

test<-file.path(pathf, "test")
train<-file.path(pathf, "train")

x<-read.table(file.path(test,"X_test.txt"))
y<-read.table(file.path(test,"Y_test.txt"))
subTest<-read.table(file.path(test,"subject_test.txt"))

xt<-read.table(file.path(train,"X_train.txt"))
yt<-read.table(file.path(train,"Y_train.txt"))
subtrain<-read.table(file.path(train,"subject_train.txt"))

#Get activity labels 
labels<-read.table(file.path(pathf,
                                     "activity_labels.txt"),
                           col.names = c("Id", "Activity")
)

#Get features labels
flabels<-read.table(file.path(pathf,
                                    "features.txt"),
                          colClasses = c("character")
)

#1.Merges the training and the test sets to create one data set.
datatrain<-cbind(cbind(xt, subtrain), yt)
datatest<-cbind(cbind(x, subTest), y)
sensor<-rbind(datatrain, datatest)

slabels<-rbind(rbind(flabels, c(562, "Subject")), c(563, "Id"))[,2]
names(sensor)<-slabels

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
sensormeanstd <- sensor[,grepl("mean\\(\\)|std\\(\\)|Subject|Id", names(sensor))]

#3. Uses descriptive activity names to name the activities in the data set
sensormeanstd <- join(sensormeanstd, labels, by = "Id", match = "first")
sensormeanstd <- sensormeanstd[,-1]

#4. Appropriately labels the data set with descriptive names.
names(sensormeanstd) <- gsub("([()])","",names(sensormeanstd))
#norm names
names(sensormeanstd) <- make.names(names(sensormeanstd))

#5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject 
fdata<-ddply(sensormeanstd, c("Subject","Activity"), numcolwise(mean))
#improve column names
fdataheaders<-names(fdata)
fdataheaders<-sapply(fdataheaders, aSuf, ".mean")
names(fdata)<-fdataheaders

write.table(fdata, file = "sensordataavgsubject.txt", row.name=FALSE)
