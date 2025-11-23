# ==============================================================================
# Uptime Kuma - Development Makefile
# ==============================================================================

.PHONY: help up build down stop restart logs shell clean prune status

# Variables
COMPOSE = docker compose
SERVICE = uptime-kuma

# Default target: Show help
.DEFAULT_GOAL := help

# ==============================================================================
# Main Commands
# ==============================================================================

help: ## Show this help message
	@echo "Usage: make [command]"
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

up: ## Start the containers in detached mode
	$(COMPOSE) up -d

build: ## Rebuild the image and start the containers (Use this after Dockerfile changes)
	$(COMPOSE) up -d --build

down: ## Stop and remove containers and networks
	$(COMPOSE) down

stop: ## Stop the containers without removing them
	$(COMPOSE) stop

restart: ## Restart the containers (Use this after backend code changes)
	$(COMPOSE) restart

# ==============================================================================
# Debugging & Maintenance
# ==============================================================================

logs: ## Follow the logs of the main container
	$(COMPOSE) logs -f $(SERVICE)

shell: ## Open an interactive bash shell inside the container
	$(COMPOSE) exec $(SERVICE) bash

status: ## Show the status of the containers
	$(COMPOSE) ps

clean: ## Stop containers and remove volumes (WARNING: Deletes database data)
	$(COMPOSE) down -v --remove-orphans

prune: ## Clean up unused Docker images and build cache to free space
	docker system prune -f