#!/bin/sh

# This file is part of the sots-cable-model distribution (https://github.com/petejan/sots-cable-model).
# Copyright (c) 2018 Peter Jansen
# 
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>.

source wave-env.sh

#echo "input SWH : " ${SWH}

if [ -z "$1" ] 
 then
  file=sofs1
else
  file="${1%.*}"
fi

# get a list of nodes to sample
nodes=$(grep '[0-9]. term_' output/${file}.bom | cut -b 59-)

i=$2

  fileno=$(printf '%02d' $i)
  echo
  echo 'FILE SWH PERIOD :' ${fileno} ' ' ${SWH[i]} ' ' ${PERIOD[i]}

  cable -in ${file}.cbl -out output/${file}-n${fileno}.crs -sample ${DT} -snap_dt ${SNAP_DT} -nodes ${nodes} -DPERIOD=${PERIOD[i]} -DCF=0.2 -DSWH=${SWH[i]} -DLEN_PP=${LEN_PP} -DLEN_NY=${LEN_NY} -DLEN_WIRE=${LEN_WIRE} -DWIND=${WIND[i]} -quiet 
  if [ $? -eq 0 ]
  then
    echo "Successfully created file " ${fileno}
  else
    echo "Could not create file ${fileno}" >&2
    exit 1
  fi
  res2mat -in output/${file}-n${fileno}.crs -out output/${file}-n${fileno}.mat

  sleep 1

  echo "${i},${SWH[i]},${PERIOD[i]},${WIND[i]},${PROB[i]}" >> output/${file}-simValue.csv

