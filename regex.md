The concepts of **pattern** and **matching** (via pattern-to-pattern comparison) are important for learning regex.

## Visual Studio Code

### Find all CSS classes

```
class=".*?"
```

In this code `.*?` matches any characters, as few as possible (non-greedy).

### Change all whitespace character indentations to indentation character indentations, and, in the end of each relevant line -- add a comma after each single quote mark

* Click `CTRL+Shift+P`, then choose Convert indentation to Tabs
* When deleting all lines, hitting Enter in the replace field might not be enough and we'll need to click the replace button instead
* Add comma in the end of each line:

```
SEARCH:

'$

REPLACE:

',
```

## Common regex

Common regex (POSIX/PCRE/Emacs) primarily use to search (match) data inside files.

Match Stream Letter or letters (any letter is fine):

```
x
```

Match any single character:

```
.
```

Match any letter or number or single character

```
?
```

Match a pattern that starts with following a text in field:

```
^
```

Match a pattern that ends with following a text in field:

```
$
```

Repeat previous matching pattern till the end of line:

```
*
```

Match this ANDOR this

```
|
```

Match all that starts with xyz and a space, and all after it in that field:

```
^xyz .*
```

Negate all before it in that field, to match per instructions, all that is after it in that field:

```
\K
```

Match all lines starting with a `;` or `#` (good for removing all comments):

```
^[#;].*
```

Match all empty lines (with their line feeds):

```
^\s*$[\n\r]*
```

Match until this (until Whitespace; Caret in `[]` brackets is a negator):

```
[^\s-]
```

Match pretty much everything:

```
.*?
```	

## Regex I used in MediaWiki

Delete all simple references for an article:

```
<ref>.*?</ref>
<ref .*?>.*?</ref>
```

## Special regex

Everything which isn't a special character (`}` in this case):

```
[^}]+
```

## Shell wildcards

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

## man

To find a letter argument until a space in `man` do:

-X[, ]

* X here is the letter of the argument.
* [, ] here "the letter" with a comma or a whitespace if there is any right after --- until any other character.


## Asking questions about regex

* Background information on a regex problem

* Current state
* Desired state

### What I have tried to solve the problem:

1. Search (match)
1. Replace with
1. **Result by code (`Four_whitespace_characters_code`)**<br>
   **Result by quote (`>`)**

### Notes

### My question

How would you solve this problem or at least hint to solve it?
