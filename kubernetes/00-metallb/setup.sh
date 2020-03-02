#!/bin/bash

# This runs the helm commands to setup the helm chart.
helm install metallb -f values.yml stable/metallb