FILE="metrics.json"
if [ ! -z "$1" ]; then
  FILE="$1"
fi

jq -r '.resourceMetrics[] | .scopeMetrics[] | .metrics[] | select(.name == "process.memory.usage") | .sum | .dataPoints[] | [.timeUnixNano, .asInt] | @csv' $FILE | \
	sed s/\"//g | \
	awk -F "," '{i = 0; printf "%s,%.2f\n", NR*5, $2/1000000}' > plot_source.csv

plot_script=$(cat <<EOF
unset key;
set terminal dumb;
set datafile separator ",";
set format y "%.0f MiB";
plot "plot_source.csv" using 1:2 with lines;
EOF
)
echo $plot_script | gnuplot "-"

