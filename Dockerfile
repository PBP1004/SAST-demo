FROM nginx:stable-alpine

# Create a non-root user (if not already present)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy files to nginx directory
COPY . /usr/share/nginx/html

# Fix permissions so non-root user can read files
RUN chown -R appuser:appgroup /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Ensure nginx runs as non-root user
USER appuser

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
