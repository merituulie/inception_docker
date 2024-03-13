# Inception

This project implements a System Administration exercise using Docker. It virtualizes several microservices: MariaDB, Wordpress and NGINX setup for a Linux machine using Docker and docker-compose, build from scratch.

---

## 🚀 **Project Overview:**

- The project sets up a small infrastructure composed of different services within a virtual machine using Docker Compose.
- Each service runs in its own dedicated container.
- Dockerfiles for each service are written and called in the docker-compose.yml using the Makefile.
- Docker images are built from scratch rather than pulling ready-made images for each service.
- The project includes:
  - NGINX container with TLSv1.2 or TLSv1.3.
  - WordPress with php-fpm to enable fastcgi.
  - MariaDB
  - Volumes for WordPress database and website files.
  - Docker network to connect containers.
- Containers are configured to restart on crash.

## Setting Up

### Prerequisites

- Install [Docker](https://docs.docker.com/engine/install/)
- Install [Docker Compose](https://docs.docker.com/compose/install/linux/#install-the-plugin-manually)
- Install [Make](https://www.gnu.org/software/make)

Additionally, make sure you have a `.env` file with the necessary environment variables available in the root of the repository.

### Instructions

1. Clone the repository to your local machine.
2. Navigate to the cloned repository directory.
3. Create directories for MariaDB and WordPress data if they don't exist:

    ```bash
    mkdir -p /home/meskelin/data/maria-db
    mkdir -p /home/meskelin/data/wordpress-data
    ```

4. Add the domain name `meskelin.42.fr` to your hosts file if it's not already present:

    ```bash
    sudo grep -q "meskelin.42.fr" /etc/hosts || echo "127.0.0.1 meskelin.42.fr" | sudo tee -a /etc/hosts
    ```

5. Start the Docker containers:

    ```bash
    make up
    ```

### Additional Makefile Commands

- To display information about Docker images, containers, networks, and volumes:

    ```bash
    make info
    ```

- To stop the containers:

    ```bash
    make down
    ```

- To see the status of the containers:

    ```bash
    make ps
    ```

- To clean up stopped containers, networks, and volumes:

    ```bash
    make clean
    ```

- To remove all Docker resources, including images, volumes, networks, and containers, and reset the host file:

    ```bash
    make fclean
    ```

- To perform a thorough reset, stopping and removing all containers, images, and volumes, as well as removing associated networks:

    ```bash
    make reset
    ```
