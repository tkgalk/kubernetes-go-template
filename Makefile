build-test:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o ./bin/test ./cmd/test/main.go

build-user:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o ./bin/user ./cmd/user/main.go

build-docker-test:
	docker build -t project-test -f ./docker/test.Dockerfile .

build-docker-user:
	docker build -t project-user -f ./docker/user.Dockerfile .

deploy-local-cluster:
	# creates (if one doesn't exist) a local Docker registry on localhost:5000
	sh ./deployment/local/registry.sh
	# creates a `kind` cluster locally using the local registry
	kind create cluster --config ./deployment/local/cluster.yaml
	# sets `kubectl` to use local `kind` cluster
	kubectl cluster-info --context kind-kind
	# connects networks in Docker allowing `kind` to access the registry; ignores errors
	-docker network connect "kind" "kind-registry"
	# installs nginx ingress
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

destroy-local-cluster:
	kind delete cluster