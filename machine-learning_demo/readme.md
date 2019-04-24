# scikit-learn_demo
This is a basic demo of how to use scikit-learn to tune, train, and test a model.

This repository was created to go along with a guest lecture for Political Science 811: Introduction to Statistical Computing for Political Science at the University of Wisconsin–Madison. It contains a Pipenv and a script to  tune, train, and test a gradient boosting machine model on the IMDB database.

You need Python3 and Pipenv installed to use this repository. After downloading the repository, open a terminal with the root of the project in your working directory and run
```bash
pipenv sync
```
to install all dependencies (this may take a few minutes). Then you can run one of the Python scripts containing the machine learning program. If you do not want to worry about configuring parallelization, then you can just run
```bash
pipenv run python gbm_single_thread.py
```
to run the program. If you know how many workers and threads are appropriate for your machine, then edit the gbm.py script appropriately and then run
```bash
pipenv run python gbm_single_thread.py
```

This demo only trys 2 models when tuning hyper-parameters because it is a minimal example. In a real application, you would want to try many more sets of hyper-parameters by increasing the value of the `n_iter` variable in the python script.