#!/bin/bash
set -e

echo "" && Echo "     >>> Updating package lists... <<<" && echo ""
sudo apt-get update 

echo "" && Echo "     >>> Installing PHP PostgreSQL extension... <<<" && echo ""
sudo apt-get install -y php-pgsql 

echo "" && Echo "     >>> Verifying PHP PostgreSQL extension installation... <<<" && echo ""
php -m | grep -i pgsql