#!/bin/bash
#PBS -N regrid 
#PBS -A P06010014
#PBS -l select=1:ncpus=1:mem=200GB
#PBS -l walltime=24:00:00
#PBS -k eod
#PBS -j oe
#PBS -q casper
#PBS -m abe

source /etc/profile.d/modules.sh
module purge
module load nco/4.7.4

MAPF=/glade/work/strandwg/E3SM_regridding/maps/map_ne30pg2_to_fv0.9x1.25_aave.20220202.nc ; export MAPF
BDIR=/glade/campaign/cgd/ccr/E3SMv2/ne30_original
NDIR=/glade/campaign/cgd/ccr/E3SMv2/FV_regridded

export CASE
export FREQ
NEWC=`echo $CASE | sed -e 's/LR/FV1/g'` ; export NEWC
NEWD=${NDIR}/${NEWC}/atm/proc/tseries/${FREQ}
mkdir -p ${NEWD}
cd ${BDIR}/${CASE}/atm/proc/tseries/${FREQ}
for IN in `/bin/ls *eam.h?.*nc` ; do
        OUT=`echo $IN | sed -e 's/LR/FV1/g'`
        if [ ! -f ${NEWD}/${OUT} ] ; then
                ncremap -m $MAPF -i ${IN} -o ${NEWD}/${OUT}
                date
        fi
done

exit
