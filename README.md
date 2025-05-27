# ELK Docker Manager

A simple Bash-based CLI tool to manage your ELK Stack (Elasticsearch, Logstash, Kibana, Filebeat) using Docker Compose.

## 🚀 Features

- One-click environment initialization (Docker, sysctl tuning)
- Start, Stop, Restart ELK containers
- Delete containers and volumes completely
- Compatible with ELK Stack 7.x for easier local testing (basic authentication)

## 📦 Prerequisites

- Docker
- Docker Compose

## 🛠️ Usage

```bash
chmod +x elk-manager.sh
./elk-manager.sh
```

You will see a menu like this:

```
==============================
     ELK Stack Manager
==============================
1) Initialize Environment
2) Start ELK Docker Containers
3) Stop ELK Docker Containers
4) Restart ELK Docker Containers
5) Delete ELK Environment (Containers + Volumes)
0) Exit
```

## 📁 Directory Structure

```
elk-docker-manager/
│
├── docker-compose.yml
├── elk-manager.sh
├── logstash/
│   ├── config/
│   │   └── logstash.yml
│   └── pipeline/
│       └── logstash.conf
└── filebeat/
    └── filebeat.yml
```

> Make sure to add your configuration under `logstash/config/`, `logstash/pipeline/`, and `filebeat/`.

## 📜 License

This project is licensed under the [MIT License](LICENSE).


## 🔐 Security Note

This tool uses a hardcoded password (`elastic:qwer1234`) for simplicity. Do **not** use this in production environments.

## 💡 Contributing

Pull requests are always welcome! 🛠️ Feel free to fork and improve.

