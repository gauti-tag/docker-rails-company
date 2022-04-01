Actions to perform to make it work

1. rename the 'project_name' in docker-compose.yml file in web service and for container_name
2. type the command: "docker-compose build"
3. to create new rails project run: "docker-compose run web rails new . --database=postgresql" and follow the instructions
4. set theses params at the defaut part to config/database.yml :
   host: database #name of db service specified in the docker-compose.yml file
   port: 5432
   username: <%= ENV["DB_USERNAME"] %>  #specified in the docker-compose.yml mapped 
   password: <%= ENV["DB_PASSWORD"] %>  #specidied in the docker-compose.yml mapped 
