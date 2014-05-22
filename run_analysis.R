run_analysis <- function(){
        
        # Read file with labels and list files structure for meger.
        
        activity_labes = read.csv("./UCI HAR Dataset/activity_labels.txt",head=FALSE,sep=" ")
        features = read.csv("./UCI HAR Dataset/features.txt",head=FALSE,sep=" ")
        
        activity_labes_transp = t(activity_labes[,2])
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
                        datcombine = sapply(datcombine,as.numeric)
                        
                        if (basename(List_File_test_temp[i]) == "X.txt"){
                                
                                colnames(datcombine) = features_transp
                                write.csv(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                                x = datcombine
                                
                        }else
                        
                        if (basename(List_File_test_temp[i]) == "y.txt"){
                                
                                datcombine = merge(datcombine,activity_labes,by="V1")
                                names(datcombine)[1] = "activity_labes"
                                names(datcombine)[2] = "activity"
                                write.csv(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                                y = datcombine
                                
                        }
                        
                        else
                          
                          if (basename(List_File_test_temp[i]) == "subject.txt"){
                              
                                names(datcombine)[1] = "subject"
                                subject = datcombine
                                write.csv(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                            
                         
                        }                          
                       write.csv(datcombine,file=basename(List_File_test_temp[i]),row.names = FALSE)
                }
             }
        
            
             
        }
        
        #Create a tiny data with only mean and std
        
        split_mean = grep("mean", colnames(x))
        split_std = grep("std", colnames(x))
        tiny_x = x[,sort(c(split_mean,split_std))]      
        merge_subject_activ = cbind(subject,y)      
        tiny_data = cbind(merge_subject_activ,tiny_x)
        names(tiny_data)[1] = "subject"
        write.table(tiny_data,file="./tiny_data.txt",row.names = FALSE)
        
        
        #Create a tiny data with mean for each variable for each subject
        
        x = read.table("./X.txt",sep=",", header=TRUE)
        subject = read.table("./subject.txt",sep=",",header=TRUE)
        y = read.table("./y.txt",sep=",",header=TRUE)
        merge = cbind(subject,y,x,deparse.level=1)
        names(merge)[1] = "subject"
        subject_mean  = aggregate(merge[,4:length(merge)], by=list(merge$subject,merge$activity), FUN='mean')
        write.table(subject_mean,"./tiny_dat_by_subj.txt",row.names = FALSE)
        
}
