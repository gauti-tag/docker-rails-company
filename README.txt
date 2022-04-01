Actions to perform to make it work

1. rename the 'project_name' in docker-compose.yml file in web service and for container_name
2. type the command: "docker-compose build --no-cache"  #for the first time to avoid conflit
3. to create new rails project run: "docker-compose run web rails new . --database=postgresql" and follow the instructions
4. set theses params at the defaut part to config/database.yml :
   host: database #name of db service specified in the docker-compose.yml file
   port: 5432
   username: <%= ENV["DB_USERNAME"] %>  #specified in the docker-compose.yml mapped 
   password: <%= ENV["DB_PASSWORD"] %>  #specidied in the docker-compose.yml mapped 
   
5. update the .env file by setting DB_USERNAME, DB_PASSWORD, DB_DATA_LOCAL_PROJECT etc ...
6. uncomment "COPY package.json yarn.lock ./" in the Gemfile 
7. perform : docker-compose build or docker-compose build --no-cache #to avoid conflit
8. perform : docker-compose run web bundle
9. create the DataBase App : => docker-compose run web rails db:create
10. Migrate the DB : => docker-compose run web rails db:migrate
11. Run the container : => docker-compose up
12. Run the container in the detached mode : => docker-compose up -d



USEFULL COMMAND
- to down all containers
=> docker-compose down -v --remove-orphans
- to remove all containers with the exit mention
=> docker rm $(docker ps -aq)

