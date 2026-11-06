FROM mcr.microsoft.com/playwright:v1.39.0-jammy
RUN npm install -g netlify-cli@20.1.1 node-jq --no-audit --no-fund --ignore-scripts
