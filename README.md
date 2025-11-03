Website Uptime Monitor Telegram Bot (WUMTA Bot)
📘 Project Description

This project is a Python-based Telegram Bot that monitors website uptime and sends real-time alerts through Telegram.
The entire DevOps pipeline is automated using Jenkins, with Docker for containerization and AWS EC2 for hosting.
Monitoring and performance visualization are handled via Prometheus and Grafana.

⚙️ Tech Stack
Layer	Tools / Technologies
Source Control	Git + GitHub
CI/CD	Jenkins on AWS EC2
Application	Python Telegram Bot
Containerization	Docker + DockerHub
Infrastructure	AWS EC2 (Ubuntu)
Monitoring	Prometheus, Grafana, Node Exporter
Automation Scripts	Bash + Cron Jobs
🧩 Setup Instructions
1. Clone the Repository
git clone https://github.com/Alresh02/Devops-Capstone-Project-WUMTA_bot.git
cd Devops-Capstone-Project-WUMTA_bot

2. Build Docker Image (Locally)
docker build -t reshars/uptime-monitor:latest ./app

3. Run the Container

The bot runs in the background; no specific web port (like 5000) is exposed.

docker run -d --name uptime-monitor reshars/uptime-monitor:latest

4. Verify Running Container

Check logs to confirm the bot is active and responding:

docker logs -f uptime-monitor

🔁 CI/CD Flow (Jenkins Automation)

Code Push: Developer commits and pushes code to GitHub (branch: feature/jenkins or develop).

Build Trigger: Jenkins detects changes and starts the build pipeline.

Docker Build: Jenkins builds the Docker image for the Telegram Bot.

Push to DockerHub: The image is pushed to reshars/uptime-monitor.

Deploy on EC2: Jenkins connects to the AWS EC2 instance, pulls the latest image, stops old containers, and runs the new one.

Notification: A Telegram message is sent automatically for build success or failure.

☁️ Deployment Details

Deployed on: AWS EC2 (Ubuntu Server)

Access Method: Runs in the background; monitored via Docker logs

EC2 Public IP: 65.0.180.216

Container Name: uptime-monitor

📊 Monitoring & Maintenance

Prometheus & Grafana used for tracking EC2 metrics and container performance.

Node Exporter installed for system-level metrics.

Cron Jobs handle periodic backups and log cleanup automatically.