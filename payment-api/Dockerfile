# Build
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /build
RUN apk add --no-cache maven
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -B && \
    java -Djarmode=layertools -jar target/payment-api-1.0.0.jar extract --destination extracted

# Runtime
FROM eclipse-temurin:17-jre-alpine AS runtime

LABEL maintainer="DevOps Team <devops@finpay.com>" \
      org.opencontainers.image.title="payment-api" \
      org.opencontainers.image.version="1.0.0"

RUN apk upgrade --no-cache && \
    apk add --no-cache curl dumb-init && \
    rm -rf /var/cache/apk/*

RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /build/extracted/dependencies/ ./
COPY --from=builder /build/extracted/spring-boot-loader/ ./
COPY --from=builder /build/extracted/snapshot-dependencies/ ./
COPY --from=builder /build/extracted/application/ ./

RUN chown -R appuser:appgroup /app
USER appuser:appgroup

EXPOSE 8080

ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+ExitOnOutOfMemoryError" \
    PAYMENT_DB_URL="jdbc:postgresql://localhost:5432/payments" \
    PAYMENT_DB_USER="payments" \
    PAYMENT_DB_PASSWORD="" \
    PAYMENT_WORKER_BASE_URL="http://payment-worker:8090"

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["dumb-init", "--"]
CMD ["sh", "-c", "exec java $JAVA_OPTS org.springframework.boot.loader.launch.JarLauncher"]
