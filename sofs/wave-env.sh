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

# this file sets up the wave cases

SNAP_DT=1
DT=0.1

# SOFS-1 simulation conditions
SWH=(1.4 2.3 3.2 4.1 5.0 5.9 6.8 7.8 8.7 9.6 10.5 11.4 12.3 13.2 14.2 15.09 16.0 16.9)
PERIOD=(5.2 5.9 6.8 7.6 8.4 9.2 9.9 10.7 11.5 12.3 13.1 13.9 14.7 15.5 16.3 17.1 17.9 18.7)
WIND=(7.1 8.3 9.6 10.8 12.0 13.2 14.5 14.7 16.9 18.1 19.4 20.6 21.8 23.1 24.3 25.5 26.7 27.9)
PROB=(0.00 0.12 5.22 17.10 23.57 23.28 14.83 8.16 4.14 1.83 0.96 0.51 0.18 0.06 0.0034 0.01 0.01 0.001)

# orcina simulation cases
#SWH=(1.32 2 3 4 5 6 7 8 8.97 10.12 11 12 19)
##PERIOD=(9.2 8.2 10.5 11.3 11.9 13.6 14.3 12.4 14.5 13.6)
#PERIOD=(8.6114       9.2261       9.9583        10.73       11.173       11.688       12.219        12.75         13.7         14.8 15 16 16)
##WIND=(2.36 3.62 6.36 7.79 12.45 5.25 12.55 13.45 16.30 15.87)
#WIND=(5.4514       6.5134       8.0668       9.3144       11.435       12.921        13.72       14.574       15.173       14.733 15 15 17)
##WIND=(3.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0)
#PROB=(0.62315       14.866       32.777       23.807       14.438       9.2951       4.2116       1.5603       0.3067    0.0043347 0.001 0.001 0.001)

#finding SOFS-7 when load disconnects
#SWH=(10 11 12 13 14 15 16 17 18)
#PERIOD=(16 16 16 16 16 16 16 16 16)
#WIND=(15 15 15 15 15 15 15 15 15)
#PROB=(0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1)

#SWH=(1.4 3.2 10.5 16.9)
#PERIOD=(5.2 6.8 13.1 18.7)
#WIND=(7.1 9.6 19.4 27.9)
#WIND=(7.1 7.1 7.1 7.1)

#SWH=(3.2)
#PERIOD=(6.8)
#WIND=(9.6)
#PROB=(100)

#SWH=(11)
#PERIOD=(15)
#WIND=(15)
#PROB=(100)

#SWH=(5.0  5.0  5.0  5.0)
#PERIOD=(8.4  8.4  8.4  8.4)
#WIND=(7.1  9.6 19.4 27.9)

LEN_PP=1725
LEN_NY=2200
LEN_WIRE=350

tLen=${#SWH[@]}
