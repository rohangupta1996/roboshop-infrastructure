git:
	#git pull
	rm -rf .terraform
dev-apply: git
	cd aws-parameter; terraform init -backend-config=env-dev/state.tfvars
	cd aws-parameter;terraform apply -auto-approve -var-file=env-dev/main.tfvars
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars
dev-destroy:
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -auto-approve -var-file=env-dev/main.tfvars