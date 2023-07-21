# Build Stage
FROM maven:3.8.3-openjdk-8 AS build

WORKDIR /app

COPY pom.xml /app/
COPY src /app/src/

RUN mvn clean package

# Run Stage
FROM openjdk:8-jre

WORKDIR /app

COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 3333

ENTRYPOINT ["java", "-jar", "app.jar"]

