# 🤖 OpenClaw Assistant

This guide will help you get up and running using Docker Compose.

OpenClaw is a powerful automation and agent framework. This repository contains the configuration and workspace for running your own OpenClaw instance.

or 
[Run Model locally](https://dev.to/sienna/qwen3-coder-next-the-complete-2026-guide-to-running-powerful-ai-coding-agents-locally-1k95)

## 🚀 Quick Start

Follow these steps to set up the project on your local machine.

### 1. Prerequisites

Ensure you have the following installed:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes Docker Compose)

### 2. Configuration

OpenClaw requires a few tokens to function.

1.  **Copy the environment template:**
    ```bash
    cp .env.example .env
    ```
2.  **Edit the `.env` file:**
    - `OPENCLAW_GATEWAY_TOKEN`: Create a secure random string (e.g., using `openssl rand -hex 24`).
    - `DISCORD_BOT_TOKEN`: Your Discord bot token from the [Discord Developer Portal](https://discord.com/developers/applications).
    - `OPENCLAW_CONFIG_DIR`: Path to your config folder (default: `./openclaw-config`).
    - `OPENCLAW_WORKSPACE_DIR`: Path to your workspace folder (default: `./openclaw-workspace`).

### 3. Run the Application

Start the containers in detached mode:

```bash
docker-compose up -d
```

## 🌐 Accessing the UI

Once the containers are running, you can access the OpenClaw Control UI:

- **Web UI:** [http://localhost:18789](http://localhost:18789)
- **Token access:** If you need to authenticate, use the token you set in `.env`.

## 🛠️ CLI Usage

You can interact with the OpenClaw CLI container for administrative tasks:

```bash
docker-compose run openclaw-cli help
```

## 📋 Common Commands

| Command | Description |
| :--- | :--- |
| `docker-compose logs -f` | View real-time logs |
| `docker-compose restart` | Restart the services |
| `docker-compose down` | Stop and remove containers |
| `docker-compose pull` | Update to the latest images |

## 🔍 Troubleshooting

- **Containers won't start:** Check the logs using `docker-compose logs`.
- **Port conflicts:** If port `18789` is already in use, change the mapping in `docker-compose.yml`.
- **Permission issues:** Ensure the volumes directories (`openclaw-config`, `openclaw-workspace`) have the correct permissions for Docker.

---
*For more detailed information, visit the [official OpenClaw documentation](https://docs.openclaw.ai).*