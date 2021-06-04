# EvaluationCF.jl

*Package for evaluation of predictive algorithms. It contains metrics, data partitioning and more.*

[![][ci-img]][ci-url]
[![][codecov-img]][codecov-url]

**Installation**: at the Julia REPL, `Pkg.add("DatasetsCF")`

**Reporting Issues and Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)

## Example

```
julia> using Persa

julia> using DatasetsCF

julia> using ModelBasedCF

julia> using EvaluationCF

julia> dataset = DatasetsCF.MovieLens()
Collaborative Filtering Dataset
- # users: 943
- # items: 1682
- # ratings: 100000
- Ratings Preference: [1, 2, 3, 4, 5]

julia> sample = EvaluationCF.HoldOut(dataset)

julia> for (ds_train, ds_test) in sample
           model = ModelBasedCF.RandomModel(ds_train)
           mae = EvaluationCF.mae(model, ds_test)
           rmse = EvaluationCF.rmse(model, ds_test)
           coverage = EvaluationCF.coverage(model, ds_test)
           text =
           """ Experiment:
               MAE: $(mae)
               RMSE: $(rmse)
               Coverage: $(coverage)
           """

           print(text)
       end
 Experiment:
    MAE: 1.5095490450954905
    RMSE: 1.9079140406216837
    Coverage: 1.0
```

[ci-img]: https://img.shields.io/github/checks-status/JuliaRecsys/EvaluationCF.jl/master?style=flat-square
[ci-url]: https://github.com/JuliaRecsys/EvaluationCF.jl/actions

[codecov-img]: https://img.shields.io/codecov/c/github/JuliaRecsys/EvaluationCF.jl?style=flat-square
[codecov-url]: https://codecov.io/gh/JuliaRecsys/EvaluationCF.jl
