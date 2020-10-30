FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/iambsp/GroovyTest.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/GroovyTest/ /app
RUN mvn install -Dmaven.test.skip=true
#COPY /app/target/*.war /
#FROM openjdk:8-jre-alpine
#WORKDIR /app
#COPY --from=build /app/GroovyTest/target/* /app
#COPY /app/ .

FROM tomcat:8.5.35-jre10 as deploy
#FROM bitnami/tomcat:9.0
WORKDIR /app
COPY --from=build /app/target/BSP-SNAPSHOT-1.1.null.war /app
#COPY /app/target/BSP-SNAPSHOT-1.1.null.war /usr/local/tomcat/webapps/
RUN cp /app/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
#CMD chmod -R 777 /usr/local/tomcat/
#CMD [“catalina.sh”, “run”]
