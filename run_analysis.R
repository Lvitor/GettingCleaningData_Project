run_analysis <- function(){
        
        # Read file with labels and list files structure for meger.
        
        
        features = read.csv("./UCI HAR Dataset/features.txt",head=FALSE,sep=" ")
        features_transp = t(features[,2])
        
        List_File_test = list.files("./UCI HAR Dataset/test",recursive=TRUE)
        List_File_train = list.files("./UCI HAR Dataset/train",recursive=TRUE)
        
        List_File_test_temp = gsub("_test","",List_File_test)
        List_File_train_temp = gsub("_train","",List_File_train)
        
        # Join all files in only one and write at main directory
        
        for (i in 1:length(List_File_test_temp)){
             for (j in 1:length(List_File_train_temp)){
                                    
                                     
                     if (List_File_test_temp[i] == List_File_train_temp[j]) {
                        
                        dat_test = read.csv2(paste("./UCI HAR Dataset/test/",List_File_test[i],sep=""),
                                sep="",head=FALSE,dec=".")     
                        
                        dat_train = read.csv2(paste("./UCI HAR Dataset/train/",List_File_train[j],sep=""),
                                sep="",head=FALSE,dec=".")
                        
                        datcombine = rbind(dat_train,dat_test)
                        
                        
                        if (basename(List_File_test_temp[i]) == "X.txt"){
                                
                                colnames(datcombine) = features_transp
                                write.table(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                                x = datcombine
                                
                        }else
                        
                        if (basename(List_File_test_temp[i]) == "y.txt"){
                              
                                datcombine["name"] = 0
                                datcombine$name[datcombine$V1 == 1] = "WALKING"
                                datcombine$name[datcombine$V1 == 2] = "WALKING_UPSTAIRS"
                                datcombine$name[datcombine$V1 == 3] = "WALKING_DOWNSTAIRS"
                                datcombine$name[datcombine$V1 == 4] = "SITTING"
                                datcombine$name[datcombine$V1 == 5] = "STANDING"
                                datcombine$name[datcombine$V1 == 6] = "LAYING"
                                names(datcombine)[1] = "activity"
                                names(datcombine)[2] = "activity_labes"
                                write.csv(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                                y = datcombine
                                
                        }
                        
                        else
                          
                          if (basename(List_File_test_temp[i]) == "subject.txt"){
                              
                                names(datcombine)[1] = "subject"
                                subject = datcombine
                                write.csv(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                            
                         
                        }                          
                       
                }
             }
             
        }
        
        #Create a tiny data with only mean and std
        
        
        split_mean = grep("mean", colnames(x))
        split_std = grep("std", colnames(x))
        tiny_x = x[,sort(c(split_mean,split_std))]      
        tiny_data = cbind(subject,y,tiny_x)
        write.csv2(tiny_data,file="./tiny_data.txt",sep=";",row.names = FALSE)
        
        
        #Create a tiny data with mean for each variable for each subject
        
        
        merge = cbind(subject,y,x)
        subject_mean  = aggregate(merge[,3:length(merge)], by=list(merge$subject,merge$activity), FUN='mean')
        names(subject_mean)[1] = "subject"
        names(subject_mean)[2] = "activity"
        subject_mean$activity_labes[subject_mean$activity == 1] = "WALKING"
        subject_mean$activity_labes[subject_mean$activity == 2] = "WALKING_UPSTAIRS"
        subject_mean$activity_labes[subject_mean$activity == 3] = "WALKING_DOWNSTAIRS"
        subject_mean$activity_labes[subject_mean$activity == 4] = "SITTING"
        subject_mean$activity_labes[subject_mean$activity == 5] = "STANDING"
        subject_mean$activity_labes[subject_mean$activity == 6] = "LAYING"
        
        write.csv2(subject_mean,"./tiny_dat_by_subj.txt",sep=";",row.names = FALSE)
  
}
