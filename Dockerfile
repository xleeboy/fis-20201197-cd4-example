# Use the official Nginx base image
FROM nginx:latest

# Copy custom configuration file to the container
COPY /source/nginx.conf /etc/nginx/nginx.conf

# Copy custom index.html file to the container
COPY /source/index.html /usr/share/nginx/html/index.html
COPY /source/*.html /usr/share/nginx/html/
COPY /source/*.png /usr/share/nginx/html/
# COPY /source/*.jpg /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
