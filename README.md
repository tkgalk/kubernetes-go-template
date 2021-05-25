# kubernetes-go-template

Template for monorepo Go project using `kind` for local development.

## Run Locally

Clone the project. Make sure tho have these installed:
- Go,
- `kind`,
- `kubectl`,
- `skaffold`,
- Docker.

Go to the project directory.

```bash
cd my-project
```

Set up the local cluster:

```bash
make deploy-local-cluster
```

## Skaffold
Now to run the application locally for development - run `skaffold dev`. Any changes should be detected and appropriate containers should be automatically tagged and pushed to your local Kubernetes.

## Makefile commands
- deploy-local-cluster - builds local `kind` cluster for development.
- destroy-local-cluster - removes the local cluster.

For more info check `Makefile`.

## To deploy a new container
`docker build -t localhost:5000/project-test:0.1`  
`docker build -t localhost:5000/project-user:0.1`  
`docker push localhost:5000/project-test:0.1`  
`docker push localhost:5000/project-user:0.1`  
`kubectl -f apply ./deployment/local/k8s`  

# To do:
- Better local workflow using `skaffold`.
- Example of front-end service.
