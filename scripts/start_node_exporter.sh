if [ "$1" == "all" ]; then
  nohup ./node_exporter/node_exporter $(./node_exporter/node_exporter --help 2>&1 | grep '^  -collector\.' | cut -d '.' -f 2 | awk '{print "--collector." $1}' | tr '\n' ' ') > /dev/null 2>&1 &
else
  nohup ./node_exporter/node_exporter > /dev/null 2>&1 &
fi
