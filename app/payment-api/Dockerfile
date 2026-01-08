# Build stage
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /build

RUN apk add --no-cache maven

# Cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Build application
COPY src ./src
RUN mvn clean package -DskipTests -B


##################################################


# Runtime stage
FROM eclipse-temurin:17-jre-alpine

# Install runtime dependencies
RUN apk upgrade --no-cache && \
    apk add --no-cache curl && \
    rm -rf /var/cache/apk/*

# Create non-root user
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -S appuser -G appgroup

WORKDIR /app

# Copy JAR from build stage
COPY --from=build /build/target/payment-api-1.0.0.jar app.jar

RUN chown appuser:appgroup app.jar

USER appuser

EXPOSE 8080

ENV PAYMENT_DB_URL="jdbc:postgresql://localhost:5432/payments"\
    PAYMENT_DB_USER="" \
    PAYMENT_DB_PASSWORD="" \
    PAYMENT_WORKER_BASE_URL="http://payment-worker:8090"

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

CMD ["java", "-jar", "app.jar"]
