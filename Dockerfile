# Dockerfile
FROM docker.io/eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy everything from project
COPY target/*.jar app.jar

# Expose port
EXPOSE 8081

# Run the app
ENTRYPOINT ["java","-jar","app.jar"]
