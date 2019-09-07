#!/bin/bash

# MACHINE_TYPE = TBD

gcloud container clusters create mongo-cluster \
  --num-nodes=17 --zone=us-central1-a --machine-type=$MACHINE_TYPE --no-enable-ip-alias