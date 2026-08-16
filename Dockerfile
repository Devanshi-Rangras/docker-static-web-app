# Stage 1: Production Docker image
FROM nginx:alpine AS production

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Install curl for health checks
RUN apk add --no-cache curl

# Create non-root user, configure permissions, and create PID file in a single layer
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup && \
    touch /var/run/nginx.pid && \
    mkdir -p /var/cache/nginx /var/log/nginx /var/run/nginx /tmp && \
    chown -R appuser:appgroup /usr/share/nginx/html \
                              /etc/nginx \
                              /var/cache/nginx \
                              /var/log/nginx \
                              /var/run/nginx \
                              /var/run \
                              /tmp

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy application files
COPY --chown=appuser:appgroup app/ /usr/share/nginx/html

# Expose target application port
EXPOSE 8080

# Configure health check against port 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
