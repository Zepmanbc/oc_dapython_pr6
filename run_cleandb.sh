cp -rf ~/OpenClassroom/Projets/06\ -\ Concevez\ la\ solution\ technique\ d’un\ système\ de\ gestion\ de\ pizzeria/oc_dapython_pr6/doc/sql/* ~/.www/
docker exec -t LAMP /bin/bash -c "chmod +x /var/www/html/clean.sh"
docker exec -t LAMP /bin/bash -c "./var/www/html/clean.sh"
rm -rf ~/.www/*