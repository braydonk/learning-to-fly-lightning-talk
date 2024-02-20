bash ./scripts/cleanup_scenario.sh
bash ./scripts/start_avalanche.sh 50000 1 5
bash ./scripts/start_node_exporter.sh
nohup ./random_server/random_server &
nohup ./otelcol/otelcol-contrib --config scenarios/better/config.yaml &
mv nohup.out otelcol.out
