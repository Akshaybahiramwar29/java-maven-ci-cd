# Dockerfile
FROM ecplise-temurin:17-slim

# Set working directory
WORKDIR /app

# Copy everything from project
COPY target/*.jar app.jar

# Run the app
ENTRYPOINT ["java","-jar","app.jar"]
