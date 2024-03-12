#!/bin/bash

#SBATCH --job-name="Assembly_Unzip_20240304"
#SBATCH --export=ALL
#SBATCH --partition=medium
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --output=Assembly_Unzip_20240304.log
#SBATCH --error=Assembly_Unzip_20240304.elog
#SBATCH --mail-user=f.pitsillides@kew.org
#SBATCH --mail-type=END,FAIL

cd $PROJECTS/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output
unzip RHW1216.zip && rm RHW1216.zip
unzip RHW232.zip && rm RHW232.zip
unzip RHW305.zip && rm RHW305.zip
unzip RHW405.zip && rm RHW405.zip
unzip RHW480.zip && rm RHW480.zip
unzip RHW490.zip && rm RHW490.zip
unzip RHW736.zip && rm RHW736.zip
unzip RHW748.zip && rm RHW748.zip
unzip RHW796.zip && rm RHW796.zip
unzip RHW797.zip && rm RHW797.zip
unzip RHW822.zip && rm RHW822.zip
unzip RHW831.zip && rm RHW831.zip
unzip RHW835.zip && rm RHW835.zip
unzip RHW844.zip && rm RHW844.zip
unzip RHW900.zip && rm RHW900.zip
unzip FP2001.zip && rm FP2001.zip
unzip KDH1549.zip && rm KDH1549.zip
unzip KDH1621.zip && rm KDH1621.zip
unzip QL1023.zip && rm QL1023.zip
