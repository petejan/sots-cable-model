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

if [ -z "$1" ] 
 then
  file=sofs1
else
  file="${1%.*}"
fi

cable -in ${file}.cbl -bom -DPERIOD=0 -DCF=1 -DSWH=0 -DWIND=0 > output/${file}.bom
if [ $? -eq 0 ]
then
  echo "Successfully created BOM file"
else
  echo "Could not create BOM file" >&2
  exit 1
fi

#nodes=$(grep '[0-9]. term_' output/${file}.bom | cut -b 59-)
#awk -F' '  '/^[0-9]/ { print $7 "," $2 "," $6 }' output/${file}.bom > output/${file}-nodes.csv

echo "FILENO,SWH,PERIOD,WIND,PROB" > output/${file}-simValue.csv

seq 0 $((${tLen}-1)) | xargs -P 6 -n 1 ./process-xargs-case.sh ${file}

sort -g output/${file}-simValue.csv > output/${file}-simValue1.csv

echo
echo "Survival Simulation"
echo -DPERIOD=${PERIOD[${#PERIOD[@]}-1]} -DCF=2 -DSWH=${SWH[${#SWH[@]}-1]} -DWIND=${WIND[${#WIND[@]}-1]}
#cable -in ${file}.cbl -out output/${file}-survival.crs -sample ${DT} -snap_dt ${SNAP_DT} -nodes ${nodes} -DPERIOD=${PERIOD[${#PERIOD[@]}-1]} -DCF=2 -DSWH=${SWH[${#SWH[@]}-1]} -DWIND=${WIND[${#WIND[@]}-1]} -quiet 
cable -in ${file}.cbl -out output/${file}-survival.crs -sample ${DT} -snap_dt ${SNAP_DT} -first -last -connectors -DPERIOD=${PERIOD[${#PERIOD[@]}-1]} -DCF=2 -DSWH=${SWH[${#SWH[@]}-1]} -DWIND=${WIND[${#WIND[@]}-1]} -quiet 
if [ $? -eq 0 ]
then
  echo "Successfully created file survival file"
else
  echo "Could not create survival file" >&2
  exit 1
fi

res2mat -in output/${file}-survival.crs -out output/${file}-survival.mat

