#Installing Qiime2

#Useful links: 
#Overview: https://docs.qiime2.org/2024.2/install/ , https://docs.qiime2.org/2024.2/install/virtual/wsl/

#Step 1: Installing WSL on local computer: https://learn.microsoft.com/en-us/windows/wsl/install

wsl --install
wsl --list --online #to see list of Linux distributions 
wsl --install -d Ubuntu #install Linux distribution Ubuntu

#Following the last command, a window should pop up for Ubuntu 

#Once you have set up the WSL, you can follow the native conda installation guide, choosing the Windows (via WSL) instructions to finish setting up QIIME 2. 
#Link for this: https://docs.qiime2.org/2024.2/install/native/ 

#Install miniconda for Linux: 
#Link: https://docs.anaconda.com/free/miniconda/

#These four commands quickly and quietly install the latest 64-bit version of the installer and then clean up after themselves. To install a different version or architecture of Miniconda for Linux, change the name of the .sh installer in the wget command.
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

#After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells:
# It is important to follow all of the directions provided in the Miniconda instructions, particularly ensuring that you run conda init at the end of the installation process, to ensure that your Miniconda installation is fully installed and available for the following commands.
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

#I specified the path to conda as follows: 
conda=~/miniconda3/bin/conda 

##Update and install miniconda: 
$conda update conda
$conda install wget

##Install QIIME2 within a conda enviornment 
#Once you have Miniconda installed, create a conda environment and install the QIIME 2 2024.2 distribution of your choice within the environment. We highly recommend creating a new environment specifically for the QIIME 2 distribution and release being installed, as there are many required dependencies that you may not want added to an existing environment. You can choose whatever name you’d like for the environment. In this example, we’ll name the environments qiime2-<distro>-2024.2 to indicate what QIIME 2 release is installed (i.e. 2024.2).

wget https://data.qiime2.org/distro/amplicon/qiime2-amplicon-2024.2-py38-linux-conda.yml
$conda env create -n qiime2-amplicon-2024.2 --file qiime2-amplicon-2024.2-py38-linux-conda.yml




#CONTINUE FROM HERE
#optional cleanup: 
rm qiime2-amplicon-2024.2-py38-linux-conda.yml

#activate the conda environment 

$conda activate qiime2-<distro>-2024.2





#TEST INSTALLATION
qiime --help

