##EXERCISE 3

#Install optparse
#install.packages("optparse")

#Call the library silencing the warnings
#My R install packages in Documents instead of in the default site because it says it is not writable, so I have to call library from there
suppressWarnings(library("optparse", lib.loc = "C:\\Users\\IvanSanchezFernandez\\Documents\\R\\win-library\\3.4"))
#If in another computer, just use suppressWarnings(library("optparse"))


##################################COLLECT VARIABLES FROM GIT BASH
#Parse variables
option_list <- list(
  make_option(c("-d", "--directory"), 
                               action = "store",
                               default = NA,
                               type = "character",
                               help = "Enter the name of the directory after -d or --directory; for example: -d my/directory or --directory my/directory"),
  make_option(c("-f", "--file"), 
                               action = "store",
                               default = NA,
                               type = "character",
                               help = "Enter the name of the file after -f or --file; for example: -f test.txt or --file test.txt")
  )

opt <- parse_args(OptionParser(option_list = option_list))


##########################IF ELSE STRUCTURE

#Check if the directory exists
if (file.exists(opt$d) == FALSE) {
  #If directory does not exist, print not a valid directory
  print(paste0(opt$d, " is not a valid directory"))
  
#If directory exists
} else {
  #And the file is found
  if (file.exists(file.path(opt$d, opt$f))) {
    #If file found, then print that the file was found
    print(paste0(opt$f, " was found in the directory ", opt$d))
    
    #If the directory exists, but the file was not found  
  } else {
    print(paste0(opt$f, " is not in the directory ", opt$d))
  }
}














