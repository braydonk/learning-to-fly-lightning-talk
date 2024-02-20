bash ./scripts/cleanup_scenario.sh
bash ./scripts/start_avalanche.sh 100000 10 10
bash ./scripts/start_node_exporter.sh all
nohup ./random_server/random_server &
nohup ./otelcol/otelcol-contrib --config scenarios/okay/config.yaml &
mv nohup.out otelcol.out
