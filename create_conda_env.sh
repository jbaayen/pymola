#!/bin/bash
set -e
if [ "$#" -eq 1 ]; then
    config=$1
else
    echo "usage: $0 CONFIG"
    echo "         possible configs (testing, enduser)"
    exit 1
fi

conda update -q conda
# Useful for debugging any issues with conda
conda info -a
conda config --add channels conda-forge
conda create -n pymola python=3.5 || echo "environment already created"
conda install -n pymola cython gcc jinja2 matplotlib numpy scipy sympy
source activate pymola
# Note: casadi installed using pip since conda version currently
# not found by setup.py
pip install antlr4-python3-runtime casadi

if [ "$config" == "testing" ]; then
    conda install -n pymola coverage coveralls
elif [ "$config" == "eneduser" ]; then
    conda install -n pymola jupyter lapack pydotplus
    pip install control slycot
fi
