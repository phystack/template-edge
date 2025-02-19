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

COPY package.json ./
COPY yarn.lock ./
RUN yarn install --production
COPY dist ./

CMD ["node", "app.js"]
