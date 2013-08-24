#!/bin/sh -x
# This bash script creates the platform database, superuser and regular user
# Right now, the script prompts the admin for passwords for each

SUPERUSER="kinisi_dba"; 
APPUSER="kinisi_user"; 
DATABASE="platform"; 

echo ""
echo "This script creates the Kinisi platform database, superuser and regular user."
echo "The script prompts the administrator for passwords for both users." 
echo ""
echo "Now creating the superuser..."
echo "Superuser account name: $SUPERUSER"
echo ""
sudo -u postgres createuser --superuser --pwprompt --createdb ${SUPERUSER}
echo "Operation completed." 
echo ""
echo "Now creating the application user..." 
echo "Application user account name: $APPUSER"
echo ""
sudo -u postgres createuser --pwprompt --no-createdb --no-superuser --no-createrole ${APPUSER}
echo "Operation completed." 
echo ""
echo "Now creating the Kinisi database..." 
echo "Kinisi database name: $DATABASE_NAME" 
echo ""
createdb -U ${SUPERUSER} ${DATABASE}
echo "Operation completed."
echo ""
echo "Users and database operations completed. Please check for any errors above." 
echo ""

