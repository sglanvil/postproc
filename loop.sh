set -e

declare -a member_array=("0111" "0121" "0131" "0171" "0181" "0191")
for i in "${member_array[@]}"; do
        export CASE="v2.LR.SSP370_$i"
        export FREQ="hour_6"
        echo $CASE $FREQ
        qsubcasper -v CASE,FREQ /glade/work/sglanvil/CCR/E3SM/regrid.sh
done
