Create a Dockerfile =>

#FROM
#WORKDIR
#COPY
#RUN
#EXPOSE
#CMD
#ENTRYPOINT
FROM openjdk:17-jdk-alpine
WORKDIR /application
COPY src/Main.java .
COPY quotes.txt .
EXPOSE 8000
RUN javac Main.java
CMD ["java","Main"]

-------------------

docker build -t aditijain13/java-app-image:latest .


docker run -d -p 8080:80 --name java-app aditijain13/java-app-image:latest 
e6372595f43ac5a056b6540001fa6021bc5f71103995d61e5bdf1b7c8083aee8

-------------------

docker ps
CONTAINER ID   IMAGE                               COMMAND       CREATED              STATUS              PORTS                                               NAMES
e6372595f43a   aditijain13/java-app-image:latest   "java Main"   About a minute ago   Up About a minute   8000/tcp, 0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   java-app

-----------------------

docker logs e63725
Server is running on port 8000...
