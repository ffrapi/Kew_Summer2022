# Installing Qiime2 <br>

## Useful links:  <br>
Overview: https://docs.qiime2.org/2024.2/install/ , https://docs.qiime2.org/2024.2/install/virtual/wsl/ <br>

## Step 1: Installing WSL on local computer: https://learn.microsoft.com/en-us/windows/wsl/install <br>

    wsl --install <br>
    wsl --list --online #to see list of Linux distributions  <br>
    wsl --install -d Ubuntu #install Linux distribution Ubuntu <br>

Following the last command, a window should pop up for Ubuntu <br>

Once you have set up the WSL, you can follow the native conda installation guide, choosing the Windows (via WSL) instructions to finish setting up QIIME 2. <br>
Link for this: https://docs.qiime2.org/2024.2/install/native/ <br>

## Step 2: Install miniconda for Linux: <br>
Link: https://docs.anaconda.com/free/miniconda/ <br>

These four commands quickly and quietly install the latest 64-bit version of the installer and then clean up after themselves. To install a different version or architecture of Miniconda for Linux, change the name of the .sh installer in the wget command. <br>

    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh

After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells: <br>
It is important to follow all of the directions provided in the Miniconda instructions, particularly ensuring that you run conda init at the end of the installation process, to ensure that your Miniconda installation is fully installed and available for the following commands. <br>

    ~/miniconda3/bin/conda init bash
    ~/miniconda3/bin/conda init zsh

### I specified the path to conda as follows: *CHECK IF THIS IS OKAY"  <br>

    conda=~/miniconda3/bin/conda 

## Step 3: Update and install miniconda: <br>

    ~/miniconda3/bin/conda update conda <br>
    ~/miniconda3/bin/conda install wget <br>

or alternatively, using the path specified above: <br>

    $conda update conda <br>
    $conda install wget  <br>

## Step 4: Install QIIME2 within a conda enviornment  <br>
Once you have Miniconda installed, create a conda environment and install the QIIME 2 2024.2 distribution of your choice within the environment. We highly recommend creating a new environment specifically for the QIIME 2 distribution and release being installed, as there are many required dependencies that you may not want added to an existing environment. You can choose whatever name you’d like for the environment. In this example, we’ll name the environments qiime2-<distro>-2024.2 to indicate what QIIME 2 release is installed (i.e. 2024.2). <br>
Link: https://docs.qiime2.org/2024.2/install/native/ <br>

### The code below will download the amplicon "package of qiime2" <br>
    wget https://data.qiime2.org/distro/amplicon/qiime2-amplicon-2024.2-py38-linux-conda.yml
    $conda env create -n qiime2-amplicon-2024.2 --file qiime2-amplicon-2024.2-py38-linux-conda.yml

### To download the other packages: <br>
    wget https://data.qiime2.org/distro/shotgun/qiime2-shotgun-2024.2-py38-linux-conda.yml
    conda env create -n qiime2-shotgun-2024.2 --file qiime2-shotgun-2024.2-py38-linux-conda.yml

optional cleanup: <br>

    rm qiime2-amplicon-2024.2-py38-linux-conda.yml
    rm qiime2-tiny-2024.2-py38-linux-conda.yml

## Step 4:Activate conda environment of Qiime2: <br>
    conda activate qiime2-amplicon-2024.2
    conda activate qiime2-shotgun-2024.2

If you want to deacivate: <br>

    conda deactivate

## Step 5: Check that qiime works <br>

    qiime --help


## EXTRA: UPDATING AND RE-ACTIVATING QIIME2 <br>

### Updating: In order to to update/upgrade to the newest release, you simply install the newest version in a new conda environment by following the instructions above. Then you will have two conda environments, one with the older version of QIIME 2 and one with the newer version.  <br>
        conda activate qiime2-amplicon-2024.2
        conda info
