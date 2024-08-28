# Use the official Alpine image as the base image
FROM alpine:latest

# Install stress-ng
RUN apk add --no-cache stress-ng

# Copy the script into the container
COPY script.sh /usr/local/bin/script.sh

# Make the script executable
RUN chmod +x /usr/local/bin/script.sh

# Set the script as the entry point
ENTRYPOINT ["/usr/local/bin/script.sh"]