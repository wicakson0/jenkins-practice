# Use a lightweight JDK base image
FROM arm64v8/openjdk:17-jdk as build

# Set environment variable
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Copy the JAR built by Maven
COPY target/jenkinspractice-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 9125

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]