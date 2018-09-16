# ltail




### NAME
ltail.gawk

### SYNOPSIS
Script for doing a tail of a file  with everything since you last tailed it.
(ltail the name derived from  last-tail).

### DESCRIPTION
Script to see what is new in an ascii file( for example a log file).
Created for scripts monitoring log files. (Send an  email when new messages do not contain something).
There are other solutions /tools (pygtail,logcheck.) but when you are on a trimmed and locked down linux installation there is always gawk.

The last position read, filesize and inode information is persisted in a file with extension .pos.
To reset tailing a log file simply remove the file.


### USAGE
./ltail <filename\>


### EXAMPLES
-
### SEE ALSO
-


**License**: MIT

---


**Scripts**

|   Name         |  Type         | Description       |
| :------------- |:------------  | :-----------------|
| ltail.awk      | awk script    | Tail file  with restart at last position |




### Additional notes:


1. The script creates a file with extenson .pos at the same location as the logfile.
1. Script adds line numbers to the output. (Change the script of you do not want this).
 


---
