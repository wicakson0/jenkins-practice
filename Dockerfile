# Use a lightweight JDK base image
FROM eclipse-temurin:17-jdk-alpine as build

# Set environment variable
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Copy the JAR built by Maven
COPY target/jenkinspractice-0.0.1-SNAPSHOT.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]