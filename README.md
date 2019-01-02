# zgk-k8s-app-front (Based on hello-world vue project)
Project only for practising Kubernetes 

## Running on Docker
```
docker run -p 8080:8080 -e VUE_APP_URL_API="http://localhost:8000" zgk-k8s-app-front
```