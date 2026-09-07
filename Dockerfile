FROM nginx:alpine
COPY cafe-webpage-source-code/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
