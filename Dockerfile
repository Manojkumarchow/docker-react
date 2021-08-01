FROM node:alpine

WORKDIR '/app'

COPY package.json .

RUN npm config set unsafe-perm true
RUN npm install --force

COPY . .

RUN npm run build

# To use nginx to run the build files

FROM nginx

# we use the files that have run using the npm run build command and start our nginx
# we can use --from=builder, so that we can use from the top-phase (builder), but it might fail in
# some cases, so we are using --from=0
COPY --from=0 /app/build /usr/share/nginx/html