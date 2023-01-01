user:aviro wrote [here](https://unix.stackexchange.com/questions/730196/does-chmod-uw-means-give-the-user-owner-writing-permissions-2-something-some):

u+w adds the 2 to the original permission the owner had. 
So if originally he had only permissions to read (4) and execute (1), after running chmod u+w the owner's permission would be 1+2+4=7 instead of 5.
If he had only read permissions, after the chmod command, the owner will have 4+2=6 instead of just 4.

By the way, if the command was chmod u=w (equal sign instead of a plus sign), then you would be correct, and the owner's permission would change to 2 (only write). 
That's the difference between + and = in the chmod command.
