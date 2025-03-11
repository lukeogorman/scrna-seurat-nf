[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A523.10.0-23aa62.svg?labelColor=000000)](https://www.nextflow.io/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![nf-test](https://img.shields.io/badge/tested_with-nf--test-337ab7.svg)](https://code.askimed.com/nf-test)

# Introduction
This is a general template for further nextflow pipelines. It is supposed to contain a basic workflow for nf-test, pipeline validation prior to the start of the main.nf. 

## Usage
Clone repository:
```bash
git clone https://gitlab.cmbi.umcn.nl/alemg/nf-pipeline-setup.git
```

## Running from command line
```bash
nextflow run main.nf -c nextflow.config -work-dir /your/work/dir -profile docker
```

## Running as a jobscript
Make sure to have the cores specified in ``-pe smp`` the same as in ``--cpus``.
In case nextflow is in your anaconda/miniconda environment, it is required to use ``eval "$(conda shell.bash hook)"`` prior to ``conda activate`` and ``nextflow run``.
```bash
#!/bin/bash
#$ -N jobname
#$ -o jobname.out
#$ -e jobname.err
#$ -V
#$ -q all.q@narrativum.umcn.nl
#$ -pe smp 5

eval "$(conda shell.bash hook)" 
conda activate nextflow
cd $HOME
nextflow run main.nf -c nextflow.config -work-dir /your/work/dir -profile docker

```

## Using nf-test
nf-test has already been initialised for this repository. 
The idea is to have a main.nf.test in the tests folder, and with the following command a snapshot van be updated [NEEDS TO BE UPDATED]:
```bash
nf-test test tests/main.nf.test --update-snapshot
nf-test test [<NEXTFLOW_FILES>|<SCRIPT_FOLDERS>]
```