
if [ ! -d results ]; then
    mkdir results
fi

source $VIVADO2020
for FILE in *; do 
    if [[ $FILE == *.v ]]; then
        vivado -mode tcl -source synth_design.tcl -tclargs $FILE -nojournal -nolog
        python3 mkdirs.py $FILE
    fi
done

rm *.jou
rm *.log