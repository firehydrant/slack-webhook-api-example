.PHONY: all config apply bundle

all: config

config:
	kubectl create configmap slack-webhook-api-example-code --from-file=files/ -o yaml --dry-run > manifests/configmap.yaml

apply:
	kubectl apply -f manifests/

bundle:
	docker run -v $(PWD)/files/:/usr/src/app -w /usr/src/app --entrypoint /usr/src/app/entrypoint.sh ruby:2.6.5 bundle
