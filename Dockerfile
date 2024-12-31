FROM node:20-alpine AS pre-build
COPY package*.json ./

FROM node:20-alpine

WORKDIR /app/

COPY --from=pre-build package*.json ./

# Install Python and build dependencies
RUN apk add --no-cache python3 make g++

COPY dist ./
COPY package.json ./
COPY yarn.lock ./
RUN yarn install

CMD ["node", "app.js"]
