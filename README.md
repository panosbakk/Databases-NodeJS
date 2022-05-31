# Databases Project

## Dependencies
1. [NodeJS](https://nodejs.org/en/)
2. [MySQL for Windows](https://dev.mysql.com/downloads/installer/)

## Required NodeJS Dependencies
1. [express](https://www.npmjs.com/package/express) - minimal and flexible Node.js web application framework that provides a robust set of features to develop web and mobile applications
2. [mysql2](https://www.npmjs.com/package/mysql2) - mysql driver
3. [ejs](https://www.npmjs.com/package/ejs) - a templating engine
4. [faker](https://www.npmjs.com/package/faker/v/5.5.3) - to create dummy data
5. [express-session](https://www.npmjs.com/package/express-session) - Create session middleware
6. [connect-flash](https://www.npmjs.com/package/connect-flash) - The flash is a special area of the session used for storing messages

## Optional NodeJS Dependencies
1. [nodemon](https://www.npmjs.com/package/nodemon) - a command-line interface (CLI) utility developed by @rem that wraps your Node app, watches the file system, and automatically restarts the process
2. [chalk](https://www.npmjs.com/package/chalk) - style terminal strings 
3. [custom-env](https://www.npmjs.com/package/custom-env) - configure different environments for your project. For example you can create a file named ```.env.localhost``` and keep the variables when you're in the development phase. Usually used so as to keep credentials safe, so as they don't get uploaded to any hosting platforms that are used for Version Control like GitHub

### custom-env Example
1. Create a file named .env.localhost
2. Import it by using ```require('custom-env').env('localhost');```
3. ```.env.localhost``` content
```
SERVER_PORT=3000
DB_HOST=localhost
DB_PORT=3306
DB_USER=dbuser
DB_PASS=dbpass
DB=db-name
```
