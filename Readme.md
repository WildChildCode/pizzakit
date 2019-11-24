# Java EE web components code examples, introduced in University course 
>Or maybe "curse", I haven't decided yet=))))
## Base principles
- Examples placed to branches. Each Branch covers one topic
- Branches has "names" hierarchy, like 'Topic-1-...'. 'Topic-2-JSP-1-Scriptlets...' and so on. 
- Don't look at master branch - this is working branch +))) I create new branch everytime I have something to say 
## What software you will need to run examples
1. JDK (1.8 minimum) [latest version of oracle jdk](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
2. IDE (IneliJIDEA Ultimate, for example. As a student you can obtain free license [here](https://www.jetbrains.com/ru-ru/community/education/)) 
3. [Maven](https://maven.apache.org) (or use IDEA's on-board maven) 
4. [Apache-Tomcat](https://tomcat.apache.org) Application Server (If you are a newcomer, download zipped binaries (there are *.bat for Win and *.sh for bash in ./bin directory))
5. Browser (FireFox and etc.)
6. DataBase Management System, client and jdbc drivers
   - MySQL: [MySQL Community server](https://www.mysql.com/products/community/), MySQL Workbench and JDBC can bi installed through server installer
   - PostgerSQL: [PostgreSQL server](https://www.postgresql.org), [PgAdmin](https://www.pgadmin.org), [JDBC](https://jdbc.postgresql.org)
   - OracleXE: [Oracle XE server](https://www.oracle.com/database/technologies/appdev/xe.html), [OracleSqlDeveloper](https://www.oracle.com/database/technologies/appdev/sql-developer.html), [JDBC](https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html)
>Note 1: 
>JDBC drivers can be loaded by maven as dependency - see file pom.xml
>As a DBMS client you can use "Database" Tool of InteliJ IDEA, or [Jetbrains DataGrip](https://www.jetbrains.com/datagrip/) - universal tool for different databases

>Note 2: 
>I have used PostgreSQL 11, Appache-tomcat-9.0.29 app server to run the examples 
## Build and run examples
Read STARTAPPLICATION.PDF, you can find ste-by-step instructions "how to build and run application" there for every branch
## Project structure
- src/main/java - application classes
- src/test/java - class for tests (it's created by maven and isn't used in the project)
- web/ - root directory for the web module (files and directories here, except WEB-INF, used at front-end)
  - css/ - directory for *.css files (contains styles)
  - js/ - directory for *.js files (contains java scripts) 
  - resources/ - directory contains different resources, like static images, used in pages
  - jsp pages are stored here
  
