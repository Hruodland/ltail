#!/usr/bin/gawk -f
#Gawk script to tail a logfile showing only rows not seen yet since last exec.
#
#Usage: ltail.awk <logfile>
#
#OS: Originally made on Linux, xubuntu 16-18.04.
#
#
#Supports file rotate (checks the inode for change);
#Side effects: Adds linenumber to the output., creates <logfilename>.pos files.
#
#Data row format of the <file>.pos file:
#Row content
# 1  last row in the log file read.
# 2  inode of the file as last read.
# 3  last filesize in bytes.
#
#License: MIT
#
#1.0 20180914 Roland van Veen, pretty printed code version.
#
#--------------------------------------------------------------------

	# BEGIN rule(s)
	BEGIN {
		#LINT=1
		ar = 0
		inode = 0
		lastinode = -1
		lastpos = 1
		myfile = ""
		filesize = 0
		lastfilesize = -1
	}

	# Rule(s)

	{
		if (FNR > lastpos) {
			printf "%6d %s\n", FNR, $0
			next
		}
		if (FNR == 1) {
			myfile = FILENAME ".pos"
			cmd = "touch " myfile
			system(cmd)
			getline ar < myfile
			if (ar >= 0) {
				lastpos = ar
			}
			getline lastinode < myfile
			getline lastfilesize < myfile
			close(myfile)
			cmd = "stat -c\"%i\" " FILENAME
			cmd | getline inode
			close(cmd)
			cmd = "stat -c\"%s\" " FILENAME
			cmd | getline filesize
			close(cmd)
			if (inode != lastinode || lastfilesize > filesize) {
				lastpos = 0
			}
		}
	}

	{
		if (FNR > lastpos) {
			printf "%6d %s\n", FNR, $0
			next
		}
		if (FNR == 1) {
			myfile = FILENAME ".pos"
			cmd = "touch " myfile
			system(cmd)
			getline ar < myfile
			if (ar >= 0) {
				lastpos = ar
			}
			getline lastinode < myfile
			getline lastfilesize < myfile
			close(myfile)
			cmd = "stat -c\"%i\" " FILENAME
			cmd | getline inode
			close(cmd)
			cmd = "stat -c\"%s\" " FILENAME
			cmd | getline filesize
			close(cmd)
			if (inode != lastinode || lastfilesize > filesize) {
				lastpos = 0
			}
		}
	}

	# END rule(s)

	END {
		myfile = FILENAME ".pos"
		cmd = "truncate -s 0 " myfile
		system(cmd)
		print(FNR) >> myfile
		print(inode) >> myfile
		print(filesize) >> myfile
		close(myfile)
	}


#eof
