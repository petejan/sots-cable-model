#!/bin/sh

dir=$1
i=0
for f in $dir/*.cbl ; do
    echo $f
    if [ $i -eq 0 ]
    then
      bom_file="${f%.*}.bom"
      cable -in $f -out $bom_file -bom
    fi
    i=$(( i+1 ))
    res_file="${f%.*}.crs"
    mat_file="${f%.*}.mat"
    cable -in $f -out $res_file -sample 0.1 -snap_dt 1 -connectors -first -last -quiet
    if [ $? -eq 0 ]
    then
        res2mat -in $res_file -out $mat_file
    fi
done
