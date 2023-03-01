Here you find all outputs of the experiments described in the paper "Towards Automated Modeling Assistance: An Efficient Approach for Repairing Flawed Planning Domains" by Songtuan Lin, Alban Grastien, and Pascal Bercher, accepted by AAAI 2023.

 The experiments were run on two benchmark sets (G1 and G2). For each flawed domain (a domain repair problem instance) in the sets, you can find a repaired domain (named "domain-repaired.pddl") together with the repairs for the original (flawed) domain, which are recorded in the file named "diagnosis". The file "diagnosis" also records the runtime and the memory consumption for finding those repairs. You can also find the plots for depicting these runtime results (runtime-G1.png and runtime-G2.png).

You can access the benchmark sets without those outputs of the experiments via the URL: https://github.com/Songtuan-Lin/repairing-domains-benchmarks. There, you can also find the description about how these two benchmark sets are structured. Any new benchmark we might create in the future will also be added to this repository.   

# Reproducing the Experiment Results

The implementation of the domain repair approach proposed in the paper can be accessed via the URL: https://github.com/Songtuan-Lin/diagnoser. You can reproduce the experiment results by running the file evaluator.py inside the directory "evaluator". Our results were produced under the commit 11ae266a00d43e201047889fd7683c1381edde8f. Note that you might produce results that have minor difference from what we presented here even if you run the code under the same commit. This is due to the randomness existing in our approach. However, such a difference should be small. Further, we might also push some bug fixes in the future. Therefore, if you want to use the domain repairer for some reason other than reproducing the experiment results, we encourage you to run the code under the newest commit.

The detailed instructions for how to use the evaluator to reproduce the results are as follows:

### Requirement
The domain repairer is written in Python. So, you need to have that installed in your device. Executing the evaluator further requires the package tqdm (for the purpose of showing the evaluation progress), which can be installed by the command: pip install tqdm.

### Command-line Arguments for the Evaluator
The evaluator requires one positional argument whose value could be either "--single" or "--multiple". The argument decides on which benchmark set (G1 or G2) the experiments will be run. Having specified the positional argument, you should also specify the path to the respective benchmark set via the argument "--benchmark_dir" together with the error rates via the argument "--err_rates" so that the problem instances of the given error rates will be evaluated. For instance, the following command
```
python evaluator.py --single --benchmark_dir path-to_G1 --err_rates 0.1 0.3 0.5
```
will run the evaluation on the benchmark set G1, and the instances with the error rates 0.1, 0.3, and 0.5 will be evaluated.

## Collect the Experiment Results
Under the directory of each benchmark set, there is a Jupyter notebook called "collect_data.ipynb" which contains the code for collecting the experiment results, including the runtime, the memory consumption, and the precision of the found repairs.

Note that you need to have Jupyter Notebook installed in order to open those notebooks, which can be done by the following command:
```
pip install notebook
```
You can then use the following command to open the notebook, assuming that you are in the directory of the respective benchmark set:
```
jupyter notebook collect_data.ipynb
```