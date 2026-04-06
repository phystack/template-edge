FROM node:24-slim

WORKDIR /app/

# Install Python and build dependencies for node-gyp
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    python3-pip \
    build-essential \
    gcc \
    libc-dev \
    && rm -rf /var/lib/apt/lists/*

COPY package.json ./
COPY yarn.lock ./
COPY tsconfig.json ./
COPY src ./src
RUN yarn install
RUN npx tsc
RUN rm -rf src tsconfig.json node_modules
RUN yarn install --production

CMD ["node", "dist/app.js"]
