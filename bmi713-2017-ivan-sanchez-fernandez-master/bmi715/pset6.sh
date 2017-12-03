#!/bin/bash

##EXERCISE 1




#1.1 Using bash, create two directories called “pset6data” and “pset6scripts”.

#I create the directory pset6data
mkdir pset6data

#I create the directory pset6scripts
mkdir pset6scripts




#1.2 Inside pset6data directory, create 100 empty files called data1 data2 ... data100. Use the command
#touch to create empty files and a for loop with the command seq to generate the numbers from 1 to 100.
#See man touch and man seq if you need more usage information.

#I create the for loop to create the 100 empty files
for n in $(seq 1 1 100)
	do 
		touch pset6data/data$n
	done




#1.3 Enter the pset6data directory. Using a for loop, go through all files in the pset6data directory (use the
#wild card *). For each file, extract the number from the file name, add 1 to the extracted number, and
#then append it to the file contents ( write the number on the first and only line).
#The for loop must not loop through the numbers 1-100. Two ways to extract the number (eg. 43 from our
#file data43) include (1) removing the string ‘data’ from the name, or (2) extracting the number from the
#name using a regular expression.
#NOTE: Questions 1.2 and 1.3 shall not be done in one step.

#I enter the pset6data directory
cd pset6data

#I create the for loop to extract the number from the 100 files
for f in `ls data*`
	do
		number=${f#data}
		numberadded=$(( $number + 1 ))
		echo $numberadded >> $f
	done




#1.4 Using grep, show all the files in the pset6data directory whose contents contain a 0 (within the file, not
#in the file name). Report only the file name, not the string match. Check man grep if you don’t know the
#correct flag for reporting only the file name.

#I create the code to show the file names of all files with a 0 in their content
grep -l 0 data*

##OUTPUT (with # before each line of output to avoid the program to read it)
#data100
#data19
#data29
#data39
#data49
#data59
#data69
#data79
#data89
#data9
#data99




#1.5 Using find, report all the file names that contain a 0.

#I create the code to show the file names of all files with a 0 in their name
find *0


##OUTPUT (with # before each line of output to avoid the program to read it)
#data10
#data100
#data20
#data30
#data40
#data50
#data60
#data70
#data80
#data90






#####################################################################################

##EXERCISE 2. COMMAND LINES AND OUTPUTS. THE filefinder.sh IS A SEPARATE FILE

#Test 1
bash filefinder.sh pset6data data20
#OUTPUT (with # before each line of output to avoid the program to read it)
#data20 was found in the directory pset6data

#Test 2 (Modified pset6DATA to pset6DATA2 because Git Bash appears to be case insensitive)
bash filefinder.sh pset6DATA2 data20
#OUTPUT (with # before each line of output to avoid the program to read it)
#pset6DATA2 is not a valid directory

#Test 3 
bash filefinder.sh pset6data data200
#OUTPUT (with # before each line of output to avoid the program to read it)
#data200 is not in the directory pset6data








#####################################################################################

##EXERCISE 3. COMMAND LINES AND OUTPUTS. THE filefinder.R IS A SEPARATE FILE

#Test 1
Rscript filefinder.R -d pset6data -f data20
#OUTPUT (with # before each line of output to avoid the program to read it)
#"data20 was found in the directory pset6data"

#Test 2 (Modified pset6DATA to pset6DATA2 because Git Bash appears to be case insensitive)
Rscript filefinder.R -d pset6DATA2 -f data20
#OUTPUT (with # before each line of output to avoid the program to read it)
#"pset6DATA2 is not a valid directory"


#Test 3 
#Rscript filefinder.R -d pset6data -f data200
#OUTPUT (with # before each line of output to avoid the program to read it)
#"data200 is not in the directory pset6data"






#####################################################################################

##EXERCISE 4

1
#Enter into O2 with my login and password (password not provided)
ssh is79@o2.hms.harvard.edu


2
#Move to the interactive session with a single core
srun --pty -p interactive -n 1 -t 0-12:00 --mem 8G bash

#OUTPUT (with # before each line of output to avoid the program to read it)
#srun: job 4235371 queued and waiting for resources
#srun: job 4235371 has been allocated resources


3
#Change directory to unix-intro
cd unix-intro

#Copy the files 
cp /n/groups/hbctraining/unix-intro/other/*-slurm* .


4
#Open trimmomatic-serial-slurm.sbatch script with nano
nano trimmomatic-serial-slurm.sbatch

#OUTPUT (with # before each line of output to avoid the program to read it)
##!/bin/bash

##SBATCH -p short   # queue name
##SBATCH -t 0-2:00       # hours:minutes runlimit after which job will be killed.
##SBATCH -n 6      # number of cores requested
##SBATCH -J rnaseq_mov10_qc         # Job name
##SBATCH -o %j.out       # File to which standard out will be written
##SBATCH -e %j.err       # File to which standard err will be written

## Change directories into the folder with the untrimmed fastq files
#cd ~/unix-intro/raw_fastq/

#mkdir -p ../trimmed_fastq_SBATCH/

## Loading modules for tools
#module load trimmomatic/0.36
#module load fastqc/0.11.5

## Run Trimmomatic
#echo "Running Trimmomatic..."
#for infile in *.fq
#do

#  # Create names for the output trimmed files
#  base=`basename $infile .subset.fq`
#  outfile=$base.qualtrim25.minlen35.fq

#  # Run Trimmomatic command

#java -jar $TRIMMOMATIC/trimmomatic-0.36.jar SE \
#  -threads 4 \
#  -phred33 \
#  $infile \
#  ~/unix-intro/trimmed_fastq_SBATCH/$outfile \
#  ILLUMINACLIP:$TRIMMOMATIC/adapters/TruSeq3-SE.fa:2:30:10 \
#  TRAILING:25 \
#  MINLEN:35

#done

## Run FastQC on all trimmed files
#echo "Running FastQC..."
#fastqc -t 4 ../trimmed_fastq_SBATCH/*.fq


5
#Modify the number of cores to 4
#From the original
#SBATCH -n 6      # number of cores requested
#to 
#SBATCH -n 4      # number of cores requested


6
#Add lines to receive an email when code ends
#SBATCH --mail-type=END
#SBATCH --mail-user=ivan_sanchezfernandez@hms.harvard.edu

7
#Submit the job to O2
sbatch trimmomatic-serial-slurm.sbatch
#OUTPUT (with # before each line of output to avoid the program to read it)
#Submitted batch job 4246132


8
#Check my jobs in O2
squeue -u is79

#OUPUT I see 2 jobs running: Job 4235371 is running on interactive partition and job 4246132 is running on short partition (with # before each line of output to avoid the program to read it)
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REA                                                                                                                                                 SON)
#           4235371 interacti     bash     is79  R       8:39      1 compute-a-16                                                                                                                                                 -68
#           4246132     short rnaseq_m     is79  R       0:01      1 compute-a-16                                                                                                                                                 -36


9
#Check the unix-intro directory
ls
#OUTPUT: There is a new directory: "trimmed_fastq_SBATCH" (with # before each line of output to avoid the program to read it)
#4199637.err    raw_fastq             trimmomatic-multithreaded-slurm.sh
#4199637.out    README.txt            trimmomatic-on-input-file-slurm.sh
#genomics_data  reference_data        trimmomatic-serial-slurm.sbatch
#other          trimmed_fastq_SBATCH


#Check the trimmed_fastq_SBATCH directory

ls trimmed_fastq_SBATCH

#OUTPUT: 18 files and directories total (with # before each line of output to avoid the program to read it)
#Irrel_kd_1.qualtrim25.minlen35_fastqc.html
#Irrel_kd_1.qualtrim25.minlen35_fastqc.zip
#Irrel_kd_1.qualtrim25.minlen35.fq
#Irrel_kd_2.qualtrim25.minlen35_fastqc.html
#Irrel_kd_2.qualtrim25.minlen35_fastqc.zip
#Irrel_kd_2.qualtrim25.minlen35.fq
#Irrel_kd_3.qualtrim25.minlen35_fastqc.html
#Irrel_kd_3.qualtrim25.minlen35_fastqc.zip
#Irrel_kd_3.qualtrim25.minlen35.fq
#Mov10_oe_1.qualtrim25.minlen35_fastqc.html
#Mov10_oe_1.qualtrim25.minlen35_fastqc.zip
#Mov10_oe_1.qualtrim25.minlen35.fq
#Mov10_oe_2.qualtrim25.minlen35_fastqc.html
#Mov10_oe_2.qualtrim25.minlen35_fastqc.zip
#Mov10_oe_2.qualtrim25.minlen35.fq
#Mov10_oe_3.qualtrim25.minlen35_fastqc.html
#Mov10_oe_3.qualtrim25.minlen35_fastqc.zip
#Mov10_oe_3.qualtrim25.minlen35.fq


10
#Only files that end in .zip
ls trimmed_fastq_SBATCH/*.zip

#OUTPUT: 6 files (with # before each line of output to avoid the program to read it)
#trimmed_fastq_SBATCH/Irrel_kd_1.qualtrim25.minlen35_fastqc.zip
#trimmed_fastq_SBATCH/Irrel_kd_2.qualtrim25.minlen35_fastqc.zip
#trimmed_fastq_SBATCH/Irrel_kd_3.qualtrim25.minlen35_fastqc.zip
#trimmed_fastq_SBATCH/Mov10_oe_1.qualtrim25.minlen35_fastqc.zip
#trimmed_fastq_SBATCH/Mov10_oe_2.qualtrim25.minlen35_fastqc.zip
#trimmed_fastq_SBATCH/Mov10_oe_3.qualtrim25.minlen35_fastqc.zip









#######################################################

#EXERCISE 5

1
#Make sure that I am in an interactive session and in the unix-intro directory
[is79@compute-a-16-71 unix-intro]$ pwd
#OUTPUT (with # before each line of output to avoid the program to read it)
#//home/is79/unix-intro


2
#Open trimmomatic-multithreaded-slurm.shf with nano
nano trimmomatic-multithreaded-slurm.sh

#The sbatch command is:
sbatch -p short -n 6 -t 0-2:00 --mem=2G --job-name trim-multithread -o %j.out -e %j.err --wrap="sh trimmomatic-on-input-file-slurm.sh $fastq"

#Options explained below:
#-p short: partition is short
#-n 6: cores are 6
#-t 0-2:00: runtime is 0 days, 2 hours, 0 minutes
#--mem=2G: memory is 2 Gbytes
#--job-name trim-multithread: name of the job is trim-multithread
#-o %j.out: out file name will be the name of the job (as above) followed by.out
#-e %j.err: error file name will be the name of the job (as above) followed by.err
#--wrap="sh trimmomatic-on-input-file-slurm.sh $fastq": to execute "sh trimmomatic-on-input-file-slurm.sh $fastq"

#for fastq in ~/unix-intro/raw_fastq/*fq: for each fastq in in ~/unix-intro/raw_fastq/*fq, do the sbatch command
#sleep 1 # wait 1 second between each job submission: wait 1 second between each job submission


3
#Run trimmomatic-multithreaded-slurm.sh using sh instead of sbatch
sh trimmomatic-multithreaded-slurm.sh


4
#OUTPUT: I received 6 job submission notifications (with # before each line of output to avoid the program to read it)
#Submitted batch job 4253602
#Submitted batch job 4253603
#Submitted batch job 4253604
#Submitted batch job 4253605
#Submitted batch job 4253606
#Submitted batch job 4253607


5
#Check status of my jobs: I found that it is difficult to give the command 
squeue -u is79 -t RUNNING and squeue -u is79 -t PENDING because the console is printing 
"Submitted batch job ...", so the output depends on how fast I am able to insert the 
squeue -u is79 -t RUNNING and squeue -u is79 -t PENDING commands, but 2 representative outputs I got were:

squeue -u is79 -t RUNNING

#OUTPUT: (with # before each line of output to avoid the program to read it)

#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:27:41      1 compute-a-16-71
#           4220023     short trim-mul     is79  R       0:01      1 compute-a-16-120

squeue -u is79 -t PENDING
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4220407     short trim-mul     is79 PD       0:00      1 (None)






#If I submit with squeue -u is79 it only takes one step, but it is also highly variable
#OUTPUT: (with # before each line of output to avoid the program to read it)

#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REA                                                                                                                                                 SON)
#           4235371 interacti     bash     is79  R      18:55      1 compute-a-16                                                                                                                                                 -68
#           4253645     short trim-mul     is79  R       0:00      1 compute-a-16                                                                                                                                                 -151
#           4253646     short trim-mul     is79  R       0:00      1 compute-a-16                                                                                                                                                 -144
#           4253647     short trim-mul     is79  R       0:00      1 compute-a-16                                                                                                                                                 -144
#           4253643     short trim-mul     is79  R       0:03      1 compute-a-16                                                                                                                                                 -155
#           4253644     short trim-mul     is79  R       0:03      1 compute-a-16                                                                                                                                                 -142


                                                                                                                                     -124          

#I have tried a different approach, which is to modify the file itself checking for running and pending files in each loop within the file

#I added squeue -u is79 -t RUNNING
squeue -u is79 -t PENDING in the file itself

#! /bin/bash

for fastq in ~/unix-intro/raw_fastq/*fq
do
sbatch -p short -n 6 -t 0-2:00 --mem=2G --job-name trim-multithread -o %j.out -e %j.err --wrap="sh trimmomatic-on-input-file-slurm.sh $fastq"
squeue -u is79 -t RUNNING
squeue -u is79 -t PENDING
sleep 1 # wait 1 second between each job submission
done
exit

#And now what I get is
sh trimmomatic-multithreaded-slurm.sh


#OUTPUT: (with # before each line of output to avoid the program to read it)
#Submitted batch job 4223603
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:58:23      1 compute-a-16-71
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4223603     short trim-mul     is79 PD       0:00      1 (None)
#Submitted batch job 4223604
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:58:24      1 compute-a-16-71
#           4223603     short trim-mul     is79  R       0:01      1 compute-a-16-124
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4223604     short trim-mul     is79 PD       0:00      1 (None)
#Submitted batch job 4223605
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:58:25      1 compute-a-16-71
#           4223603     short trim-mul     is79  R       0:02      1 compute-a-16-124
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4223604     short trim-mul     is79 PD       0:00      1 (None)
#           4223605     short trim-mul     is79 PD       0:00      1 (None)
#Submitted batch job 4223606
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:58:26      1 compute-a-16-71
#           4223603     short trim-mul     is79  R       0:03      1 compute-a-16-124
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4223604     short trim-mul     is79 PD       0:00      1 (None)
#           4223605     short trim-mul     is79 PD       0:00      1 (None)
#           4223606     short trim-mul     is79 PD       0:00      1 (None)
#Submitted batch job 4223607
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:58:27      1 compute-a-16-71
#           4223605     short trim-mul     is79  R       0:01      1 compute-a-16-154
#           4223606     short trim-mul     is79  R       0:01      1 compute-a-16-138
#           4223603     short trim-mul     is79  R       0:04      1 compute-a-16-124
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4223607     short trim-mul     is79 PD       0:00      1 (None)
#Submitted batch job 4223608
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4198518 interacti     bash     is79  R    1:58:28      1 compute-a-16-71
#           4223605     short trim-mul     is79  R       0:02      1 compute-a-16-154
#           4223606     short trim-mul     is79  R       0:02      1 compute-a-16-138
#           4223603     short trim-mul     is79  R       0:05      1 compute-a-16-124
#             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
#           4223607     short trim-mul     is79 PD       0:00      1 (None)
#           4223608     short trim-mul     is79 PD       0:00      1 (None)#





6
#Check the unix-intro directory
ls -l
#OUTPUT: There is a new directory: "trimmed_fastq" (with # before each line of output to avoid the program to read it)

#-rw-rw-r-- 1 is79 is79 10589 Oct 11 09:53 4199637.err
#-rw-rw-r-- 1 is79 is79   377 Oct 11 09:53 4199637.out
#-rw-rw-r-- 1 is79 is79 10589 Oct 11 10:05 4199646.err
#-rw-rw-r-- 1 is79 is79   377 Oct 11 10:05 4199646.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:02 4214476.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:02 4214476.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:02 4214501.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:02 4214501.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:02 4214514.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:02 4214514.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:02 4214543.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:02 4214543.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:04 4215947.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:04 4215947.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:04 4215959.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:04 4215959.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:04 4215973.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:04 4215973.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:04 4215982.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:04 4215982.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:04 4215995.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:04 4215995.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:07 4217870.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4217870.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:07 4217902.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4217902.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:07 4217918.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4217918.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:07 4217944.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4217944.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:07 4218319.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4218319.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:07 4218345.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4218345.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:07 4218361.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4218361.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:07 4218394.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:07 4218394.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219264.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219264.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:09 4219295.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219295.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219311.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219311.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219338.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219338.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:09 4219588.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219588.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219606.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219606.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219636.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219636.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219786.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219786.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:09 4219813.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219813.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219830.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219830.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219859.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219859.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:09 4219959.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:09 4219959.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:10 4219997.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:10 4219997.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:10 4220010.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:10 4220010.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:10 4220023.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:10 4220023.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:10 4220343.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:10 4220343.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:10 4220379.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:10 4220379.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:10 4220394.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:10 4220394.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:14 4222725.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:14 4222725.out
#-rw-rw-r-- 1 is79 is79  1790 Oct 11 11:14 4222743.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:14 4222743.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:14 4222759.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:14 4222759.out
#-rw-rw-r-- 1 is79 is79  1791 Oct 11 11:14 4222781.err
#-rw-rw-r-- 1 is79 is79    56 Oct 11 11:14 4222781.out
#drwxrwsr-x 2 is79 is79    78 Oct  4 10:06 genomics_data
#drwxrwsr-x 2 is79 is79   421 Oct  4 12:11 other
#drwxrwsr-x 2 is79 is79   228 Oct  4 10:06 raw_fastq
#-rw-rw-r-- 1 is79 is79   377 Oct  4 13:14 README.txt
#drwxrwsr-x 2 is79 is79    62 Oct  4 10:06 reference_data
#drwxrwsr-x 2 is79 is79  1020 Oct 11 11:04 trimmed_fastq
#drwxrwsr-x 2 is79 is79  1020 Oct 11 09:53 trimmed_fastq_SBATCH
#-rw-rw-r-- 1 is79 is79   262 Oct 11 09:43 trimmomatic-multithreaded-slurm.sh
#-rw-rw-r-- 1 is79 is79   570 Oct 11 09:43 trimmomatic-on-input-file-slurm.sh
#-rw-r--r-- 1 is79 is79  1210 Oct 11 09:50 trimmomatic-serial-slurm.sbatch


# Check the output of the directory trimmed_fastq
ls -l trimmed_fastq

#OUTPUT: (with # before each line of output to avoid the program to read it)

#total 344459
#-rw-rw-r-- 1 is79 is79   344837 Oct 11 11:10 Irrel_kd_1.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   440669 Oct 11 11:10 Irrel_kd_1.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 53023554 Oct 11 11:10 Irrel_kd_1.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   343756 Oct 11 11:14 Irrel_kd_2.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   437879 Oct 11 11:14 Irrel_kd_2.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 45542596 Oct 11 11:14 Irrel_kd_2.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   346714 Oct 11 11:14 Irrel_kd_3.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   442671 Oct 11 11:14 Irrel_kd_3.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 34853307 Oct 11 11:14 Irrel_kd_3.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   342818 Oct 11 11:14 Mov10_oe_1.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   437213 Oct 11 11:14 Mov10_oe_1.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 69190854 Oct 11 11:14 Mov10_oe_1.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   351490 Oct 11 11:10 Mov10_oe_2.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   447321 Oct 11 11:10 Mov10_oe_2.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 62772476 Oct 11 11:10 Mov10_oe_2.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   327191 Oct 11 11:14 Mov10_oe_3.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   415438 Oct 11 11:14 Mov10_oe_3.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 39589644 Oct 11 11:14 Mov10_oe_3.qualtrim25.minlen35.fq


# Compare with the output of the directory trimmed_fastq
ls -l trimmed_fastq

#OUTPUT: (with # before each line of output to avoid the program to read it)
#total 344723
#-rw-rw-r-- 1 is79 is79   344837 Oct 11 10:05 Irrel_kd_1.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   440669 Oct 11 10:05 Irrel_kd_1.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 53023554 Oct 11 10:05 Irrel_kd_1.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   343756 Oct 11 10:05 Irrel_kd_2.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   437879 Oct 11 10:05 Irrel_kd_2.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 45542596 Oct 11 10:05 Irrel_kd_2.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   346714 Oct 11 10:05 Irrel_kd_3.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   442671 Oct 11 10:05 Irrel_kd_3.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 34853307 Oct 11 10:05 Irrel_kd_3.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   342818 Oct 11 10:05 Mov10_oe_1.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   437213 Oct 11 10:05 Mov10_oe_1.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 69190854 Oct 11 10:05 Mov10_oe_1.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   351490 Oct 11 10:05 Mov10_oe_2.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   447321 Oct 11 10:05 Mov10_oe_2.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 62772476 Oct 11 10:05 Mov10_oe_2.qualtrim25.minlen35.fq
#-rw-rw-r-- 1 is79 is79   327191 Oct 11 10:05 Mov10_oe_3.qualtrim25.minlen35_fastqc.html
#-rw-rw-r-- 1 is79 is79   415438 Oct 11 10:05 Mov10_oe_3.qualtrim25.minlen35_fastqc.zip
#-rw-rw-r-- 1 is79 is79 39589644 Oct 11 10:05 Mov10_oe_3.qualtrim25.minlen35.fq


#The output in trimmed_fastq and in trimmed_fastq_SBATCH appear to be the same



7
#I guess that the advantage of runinng the jobs this way (sh) is that there is more control
#on each loop as there is more information step by step and the user can see in real time which 
#jobs are being submitted, which jobs are running, which jobs are pending...











###################################QUESTION 6
14 hours



















