
#
# There is no react server in prod so we need nginx to forward our traffic
# Hence, we only run "npm run build" and not "npm run start"
#

FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
