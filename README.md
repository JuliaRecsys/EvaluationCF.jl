# EvaluationCF.jl

*Package for evaluation of predictive algorithms. It contains metrics, data partitioning and more.*

[![][ci-img]][ci-url]
[![][codecov-img]][codecov-url]

**Installation**: at the Julia REPL, `Pkg.add("DatasetsCF")`

**Reporting Issues and Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)

## Example

```
julia> using Persa, DatasetsCF, ModelBasedCF, EvaluationCF

julia> dataset = DatasetsCF.MovieLens()
Collaborative Filtering Dataset
- # users: 943
- # items: 1682
- # ratings: 100000
- Ratings Preference: [1, 2, 3, 4, 5]

julia> k = 10

julia> folds = EvaluationCF.KFolds(dataset; k = k)

julia> mae = 0; rmse = 0; coverage = 0;

julia> for (ds_train, ds_test) in folds
           model = ModelBasedCF.RandomModel(ds_train)
           mae += EvaluationCF.mae(model, ds_test)
           rmse += EvaluationCF.rmse(model, ds_test)
           coverage += EvaluationCF.coverage(model, ds_test)
       end

julia> print(""" Experiment:
            MAE: $(mae / k)
            RMSE: $(rmse / k)
            Coverage: $(coverage / k)
        """)
 Experiment:
    MAE: 1.5095299999999998
    RMSE: 1.884630523993449
    Coverage: 1.0
```

[ci-img]: https://github.com/JuliaRecsys/EvaluationCF.jl/actions/workflows/CI.yml/badge.svg?branch=master
[ci-url]: https://github.com/JuliaRecsys/EvaluationCF.jl/actions

[codecov-img]: https://img.shields.io/codecov/c/github/JuliaRecsys/EvaluationCF.jl
[codecov-url]: https://codecov.io/gh/JuliaRecsys/EvaluationCF.jl
