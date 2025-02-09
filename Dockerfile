FROM node:20-slim

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

COPY dist ./
COPY package.json ./
COPY yarn.lock ./
RUN yarn install

CMD ["node", "app.js"]
