Shell wildcards (or shell globs) are a type of shell (file name) expansion, such as tilde expansion.<br>
Shell wildcards primarily use to search (match) file name data and philosophically can be grapsed as a type of regex dedicated to matching operations on file names.

	? 		# Match any single character;
	* 		# Match any string of characters;
	[est] 		# Match any character in set;
	[!set] 		# Match any character not in set;
	[!a-zA-Z] 	# Match any character that isn't a regular English letter;
	[!.;] 		# Match any character except a period and a semicolon;
	echo b{ed,s} 	# Don't use spaces unlness they are part of the file name; match bed or beds;
	echo {a..z} 	# Literal range
	echo {1..10} 	# Numerical range

