if [ -z "$1" ]; then
  nohup ./avalanche --metric-count=10000 > /dev/null 2>&1 &
else
  METRICS=$1
  SERIES=$2
  LABELS=$3

  ./avalanche \
    --metric-count $METRICS \
    --series-count $SERIES \
    --label-count $LABELS > /dev/null 2>&1 &
fi

