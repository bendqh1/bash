## Keyboard shortcuts

    # Move to the start of line
    Ctrl + a
    
    # Move to the end of line
    Ctrl + e
    
    Move forward a word (a word contains alphabets and digits, no symbols)
    Meta + f
    
    # Move backward a word
    Meta + b
    
    # Clear the screen
    Ctrl + l

## Variables

Set a variable for a file and a variable for a string, echo them, and append the string to the file:

```shell
my_file="$HOME/public_html/benaharoni.com/web/core/themes/olivero/templates/layout/page.html.twig"
my_string="<span class=\"globalrs_dynamic_year\">{{ 'now' | date('Y') }}</span>"
echo $my_file
echo $my_string

cat $my_file

echo $my_string >> $my_file

tail $my_file
```

## aliases

The command `alias` shows all aliases.

## Misc

    ${BASH_VERSION}
    zip -r ./seo-wiki.zip ./seo-wiki.org/

## Notes

    # "meta" can be "F"

## Links

* https://unix.stackexchange.com/questions/653796/how-to-safely-remove-all-files-including-hidden-files-from-current-directory
* https://unix.stackexchange.com/questions/710901/what-is-the-meaning-of-chmod-r-a-x-a-rx-uw
