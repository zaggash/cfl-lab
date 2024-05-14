#/usr/bin/env bash
#
ARG1="$1"
WSPACE=${ARG1// /}

ARG2="$2"
COMMAND=$ARG2

export TF_WORKSPACE=$WSPACE
export TF_VAR_prefix=$WSPACE

date

echo -n "Using workspace: " && terraform workspace show
case $COMMAND in 
  apply)
    terraform apply --auto-approve
    ;;
  destroy)
    #read -p "Are you sure? " -n 1 -r
    #echo
    #if [[ $REPLY =~ ^[Yy]$ ]]
    #then
      terraform state rm $(terraform state list | grep --color=never -e rancher2_app_v2 -e rancher2_namespace -e rancher2_secret_v2 -e module.rancher_install.helm_release -e rancher2_machine_config_v2 -e rancher2_node_pool -e rancher2_cluster_sync )
      terraform destroy --auto-approve
    #fi
    ;;
  plan)
    terraform plan
    ;;
  output)
    terraform output
    ;;
  state)
    terraform state "${@:3}"
    ;;
  *)
    echo "Second argument must be 'apply', 'destroy', 'plan' or 'output'. Current: $COMMAND"
    ;;
esac

date
