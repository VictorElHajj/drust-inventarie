# drust-inventarie
Ett nytt inventariesystem som ska vara lite mer användarvänligt. Det är en web-app som använder sig av IHP

# Attributions
This project is built using the Integrated Haskell Platform
https://github.com/digitallyinduced/ihp/blob/master/LICENSE

# Deploy with docker
1. Download project and name the folder 'src'.

`clone git@github.com:VictorElHajj/drust-inventarie.git src`

Edit `src/Config/Config.hs` like this to change environment and hostname
```haskellconfig
haskellconfig :: ConfigBuilder
config = do
    option Production
    option (AppHostname "YOUR_HOST_NAME")
    option (BaseUrl "https://YOUR_HOST_NAME")
```

2. Build the image with `sudo docker build -t drust-inventarie ./src` this will take a while.
3. Create a docker-compose.yml

This needs a postgresql database with the UUID-extension (included in the 'postgres' image).

Example docker-compose.yml provided below. Just change username/password/database name/hostname This assumes you are running Traefik as reverse-proxy and have already set up TLS.

The important part is that the project needs the ENV variables PORT and DATABASE_URL set up to access the postgressql db.

```docker-compose
version: "3.3"

networks:
    external-net:
        external: true
    db-net:

volumes:
  drust_postgres_data:
        driver: local

services:
    ihp-inventarie:
        image: drust-inventarie
        restart: always
        container_name: drust-inventarie
        networks:
          - db-net
          - external-net
        environment:
          - PORT=8080
          - DATABASE_URL=postgres://username:password@postgres:5432/database
        labels:
          - 'traefik.enable=true'
          - 'traefik.http.routers.drust.rule=Host(`YOUR_HOSTNAME`)'
          - 'traefik.http.routers.drust.entrypoints=websecure'
          - 'traefik.http.routers.drust.tls=true'
          - 'traefik.http.routers.drust.tls.certresolver=le'
        expose:
          - 8080
        depends_on:
          - postgres
    postgres:
        image: postgres
        restart: always
        hostname: postgres
        environment:
          - POSTGRES_USER=username
          - POSTGRES_PASSWORD=password
          - POSTGRES_DB=database
        networks:
          - db-net
        volumes:
          - ./src/Application/Schema.sql:/docker-entrypoint-initdb.d/1-Schema.sql
          - ./src/Application/Fixtures.sql:/docker-entrypoint-initdb.d/2-Fixtures.sql
          - drust_postgres_data:/var/lib/postgresql/data
        labels:
          - "traefik.enable=false"
~                                            
```

4. Run with `sudo docker-compose up`

# Updating
Go into the src folder and pull the latest version, rebuild the image and then finally restart. There should hopefully be no breaking changes in a while (config format was recently changed for example).
