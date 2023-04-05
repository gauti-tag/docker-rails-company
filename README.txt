Actions to perform to make it work

1. rename the 'project_name' in docker-compose.yml file in web service and for container_name
2. type the command: "docker-compose build --no-cache"  #for the first time to avoid conflit
3. to create new rails project run: "docker-compose run web rails new . --database=postgresql" and follow the instructions
   to create new API rails project run: "docker-compose run web rails new . --api --database=postgresql" and follow the instructions
4. set theses params at the defaut part to config/database.yml :
   host: database #name of db service specified in the docker-compose.yml file
   port: 5432
   username: <%= ENV["DB_USERNAME"] %>  #specified in the docker-compose.yml mapped 
   password: <%= ENV["DB_PASSWORD"] %>  #specidied in the docker-compose.yml mapped 
   
5. update the .env file by setting DB_USERNAME, DB_PASSWORD, DB_DATA_LOCAL_PROJECT etc ...
6. uncomment "COPY package.json yarn.lock ./" in the Gemfile 
7. specified DB_DATA_LOCAL_PROJECT of your database route to .env file
8. uncomment the working route DB_DATA_LOCAL_PROJECT  to docker-compose.yml
9. perform : docker-compose build or docker-compose build --no-cache #to avoid conflit
10. perform : docker-compose run web bundle
11. create the DataBase App : => docker-compose run web rails db:create
12. Migrate the DB : => docker-compose run web rails db:migrate
13. Run the container : => docker-compose up
14. Run the container in the detached mode : => docker-compose up -d

RESOLVED PROBLEMS
- update  gem 'spring' by  gem 'spring', '~> 3.1.1' to the Gemfile to make rails working well in container

COMMAND TO USED
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"] : to run the server 

USEFULL COMMAND
- to down all containers
=> docker-compose down -v --remove-orphans
- to remove all containers with the exit mention
=> docker rm $(docker ps -aq)
=> Kill all containers : docker kill $(docker ps -q)


docker network prune => remove or delete network unuse

