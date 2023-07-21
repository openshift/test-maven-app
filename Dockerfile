#build:
FROM dockette/openjdk-mvn as build 

WORKDIR /app

COPY pom.xml /app
COPY src /app/src

RUN mvn package

#run
FROM openjdk:7u91-jre-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar /app/

EXPOSE 3333

ENTRYPOINT [ "java", "-jar", "app.jar" ]
