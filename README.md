- IMAPI Angular service: https://github.com/Kolman-Freecss/kf-imapi-angular
- IMAPI Incident Service: https://github.com/Kolman-Freecss/kf-imapi-incident-service
- IMAPI Response Team Service: https://github.com/Kolman-Freecss/kf-imapi-response-service
- IMAPI Notification Service: https://github.com/Kolman-Freecss/kf-imapi-notification-service
- IMAPI Authentication Gateway Service: https://github.com/Kolman-Freecss/kf-imapi-auth-gateway
- IMAPI DevOps / Kafka Event Handling: https://github.com/Kolman-Freecss/kf-imapi-devops

## Endpoints Utils

- Prometheus targets: http://localhost:9090/targets?search=

## Getting started

### Grafana & Prometheus Configuration

- Start Grafana and Prometheus services.
```bash
docker-compose up -d
```
- Access Grafana at http://localhost:3000 and login with the default credentials (admin:admin).
- Add Prometheus as a data source in Grafana.
  - URL: http://prometheus:9090
  - Access: Server (default)
  - Save & Test
- Create a new dashboard in Grafana.
  - Add a new panel.
  - Select Prometheus as the data source.
  - Write a query to fetch the data from Prometheus.
  - Save the panel.
  - Save the dashboard.
- (TODO) Import the Grafana dashboard from `grafana-dashboard.json`.
- (TODO) Access the dashboard at http://localhost:3000/d/IMAPI-DevOps/imapi-devops


### AWS Configuration

- Configure the AWS CLI with the credentials of the AWS account.
```bash
aws configure
```

- Execute Terraform code in `.terraform` to deploy the infrastructure in AWS cloud.
```bash
terraform init
terraform apply
```

### AWS EKS Method

Not implemented because of AWS pricing. But a skeleton is available in the `death-eks-expense-method` folder.

- Configure Kubectl to connect to the AWS EKS Kubernetes cluster.
```bash
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
# Test the connection
kubectl get nodes
```

- Deploy Kafka in AWS EKS Kubernetes cluster.
```bash
kubectl apply -f kafka-deployment.yaml
```

## TroubleShooting

- Connection through different endpoints like (Host-Docker) (Host-Host) (Docker-Docker)
  - Check in Confluence: https://www.confluent.io/blog/kafka-client-cannot-connect-to-broker-on-aws-on-docker-etc/
- Kafka Broker need more memory
  - KAFKA_MESSAGE_MAX_BYTES, KAFKA_REPLICA_FETCH_MAX_BYTES, KAFKA_REPLICA_FETCH_RESPONSE_MAX_BYTES
- Take care about the common problem: host.docker.internal | localhost

---

Shield: [![CC-BY-NC-ND 4.0][CC-BY-NC-ND-shield]][CC-BY-NC-ND]

This work is licensed under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.][CC-BY-NC-ND]

[![CC-BY-NC-ND 4.0][CC-BY-NC-ND-image]][CC-BY-NC-ND]

[CC-BY-NC-ND-shield]: https://img.shields.io/badge/License-CC--BY--NC--ND--4.0-lightgrey
[CC-BY-NC-ND]: http://creativecommons.org/licenses/by-nc-nd/4.0/
[CC-BY-NC-ND-image]: https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png
