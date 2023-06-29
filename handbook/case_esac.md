Ensure that the user has created:

* Web application DB user
* Web application DB instance

read -p "Have you created a database for your web application already?" yn
case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please comeback after you create a database for your website;";;
esac
