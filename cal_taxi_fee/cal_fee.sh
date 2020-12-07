#!/bin/bash
regx="^[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3} [0-9]{1,8}.[0-9]{1}$"
past=`date -j -f "%H:%M:%S" "00:00:00" "+%s"`
fee=0
cnt=0

function demo() {
  while IFS='$\n' read -r line; do
    if [[ "$line" =~ $regx ]]; then
     nano=$(echo "$line" | awk '{print $1}')
     current=`date -j -f "%H:%M:%S" ${nano%.*} "+%s"`

     if [ $past -gt $current ]; then
      #echo "past is bigger than current"
      exit 1
     fi

     span=$((current - past))
     if [ $span -ge 300 ]; then
       #echo "current is after Last more than 5 minutes"
       exit 1
     fi
     past=$current

     dstr=`echo "$line" | awk '{print $2}'`
     distance=${dstr%.*}
     if [ $distance -eq 0 ] && [ $cnt -ge 1 ]; then
       #echo "distinc is zero"
       exit 1
     fi

     if [ 1000 -ge $distance ]; then
      fee=400
      #echo $fee
     else
       if [ 10000 -ge $distance ]; then
            fee=$((((distance - 1000)/400)*40 + 400))
            #echo $fee
       else
            fee=$((((distance - 10000)/350)*40 + 1320))
            #echo $fee
       fi
     fi
     cnt=$cnt+1
    else
      #echo "format error"
      exit 1
    fi
  done

  if [ $cnt -lt 2 ]; then
       #echo "less than 2 rows"
       exit 1
  fi
  echo $fee
}

demo
