# ----- Stage 1: build -----
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY social-benefits-calculator /app
RUN mvn -q package -DskipTests

# ----- Stage 2: runtime -----
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built jar
COPY --from=builder /app/target/social-benefits-calculator-*.jar app.jar

# Expose port and configure profile
EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=dev

# Run the app
#CMD ["java", "-jar", "app.jar"]
ENTRYPOINT ["java", "-jar", "app.jar"]