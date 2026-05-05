# Use nginx to serve static files
FROM nginx:alpine

# Copy index.html to nginx directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]