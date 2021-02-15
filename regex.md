The concepts of **pattern** and **matching** (via pattern-to-pattern comparison) are important for learning regex.

### Visual Studio Code

* Click `CTRL+Shift+P`, then choose Convert indentation to Tabs
* When deleting all lines, hitting Enter in the replace field might not be enough and we'll need to click the replace button instead

### Common regex

Common regex (POSIX/PCRE/Emacs) primarily use to search (match) data inside files.

	x		# Match Stream Letter or letters
	. 		# Match any single character
	? 		# Match any letter or number single character
	^ 		# Match a pattern that starts with following text in field
	$ 		# Match a pattern that ends with following text in field
	* 		# Repeat previous matching pattern till the end of line
	| 		# Match this and/or this
	\K 		# Negate all before it in that field, to match per instructions, all that is after it
	^xyz .* 	# Match all that starts with xyz and a space, and all after it in that field
	^[#;].* 	# Match all lines starting with a `;` or `#`
	^\s*$[\n\r]* 	# Match all empty lines (with their line feeds)

