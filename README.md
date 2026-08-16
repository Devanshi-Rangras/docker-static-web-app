🚀 Production-Grade Containerized Static Web App

A lightweight, secure, and production-ready static web application deployed to AWS EC2 using Docker, and Nginx.

This project demonstrates core DevOps practices, including Docker containerization, non-root container security hardening, and custom Nginx web server optimizations

🔑 Key Features
- Security-Hardened Container: Runs under an unprivileged, non-root user to enforce the principle of least privilege.
- Custom Nginx Configuration: Pre-configured with essential security response headers
- Caching Policies: Disables browser caching for HTML files to ensure instant updates on new deployments
- Container Health Monitoring: A dedicated /health endpoint checked periodically by Docker via curl.

⚡ Quick Start

1.Build and start the container stack:
- docker compose up -d --build

2.Verify container health and status:
- docker compose ps

3.Check logs to confirm clean startup
- docker compose logs -f

4.Access the application:
Open your browser and navigate to http://localhost:8080

5.Stop the environment:
- docker compose down

🧪 Verification & Testing Commands

To verify that security headers, health endpoints, and caching policies are operating correctly inside the running container, execute the following commands:

# 1. Test the Healthcheck Endpoint (Should return HTTP 200 OK with 'healthy')
curl -i http://localhost:8080/health

# 2. Inspect Security Headers on the Main Page
curl -I http://localhost:8080/