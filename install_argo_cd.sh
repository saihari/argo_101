#!/bin/bash

# Check if Kubectl is Installed
if ! (command -v kubectl >/dev/null 2>&1) then
    echo "Error: command kubectl not found. Exiting."
    exit 1
fi


# Creating Argocd Namespace if doesn't exist
if (kubectl get namespace argocd &> /dev/null) then
    echo "Namespace argocd already exists."
else
    echo "Creating argocd namespace."

    kubectl create namespace argocd

    # Check Previous Command Result
    if [[ $? -ne 0 ]]; then
        echo "Error: creating namespace argocd. Exiting."
        exit 1
    fi
fi

# Installing Argocd from https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml if it doesn't exist
if (kubectl get deployment -n argocd argocd-server &> /dev/null) then
    echo "Argocd resources already exist in namespace argocd."
else
    echo "Installing argocd."

    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

    # Check Previous Command Result
    if [[ $? -ne 0 ]]; then
        echo "Error: applying argocd installation. Exiting."
        exit 1
    fi
fi