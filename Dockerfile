# ----- Stage 1: build -----
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY social-benefits-calculator/pom.xml .
COPY social-benefits-calculator/src ./src
RUN mvn -q package -DskipTests

# ----- Stage 2: runtime -----
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Environment variables for the application
ENV SPRING_PROFILES_ACTIVE=dev
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
