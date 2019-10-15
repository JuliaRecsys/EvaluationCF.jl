# EvaluationCF.jl

*Package for evaluation of predictive algorithms. It contains metrics, data partitioning and more.*

| **Build Status**                                                                                |
|:-----------------------------------------------------------------------------------------------:|
| [![][travis-img]][travis-url] [![][coverage-img]][coverage-url] [![][codecov-img]][codecov-url] |


## Installation

The package can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```
pkg> add EvaluationCF
```

Or, equivalently, via the `Pkg` API:

```julia
julia> import Pkg; Pkg.add("EvaluationCF")
```

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

[contrib-url]: https://juliadocs.github.io/Documenter.jl/latest/man/contributing/

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://juliarecsys.github.io/EvaluationCF.jl/latest

[travis-img]: https://travis-ci.org/JuliaRecsys/EvaluationCF.jl.svg?branch=master
[travis-url]: https://travis-ci.org/JuliaRecsys/EvaluationCF.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/xx7nimfpnl1r4gx0?svg=true
[appveyor-url]: https://ci.appveyor.com/project/JuliaDocs/documenter-jl

[codecov-img]: https://codecov.io/gh/JuliaRecsys/EvaluationCF.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/JuliaRecsys/EvaluationCF.jl

[coverage-img]: https://coveralls.io/repos/JuliaRecsys/EvaluationCF.jl/badge.svg?branch=master&service=github
[coverage-url]: https://coveralls.io/github/JuliaRecsys/EvaluationCF.jl?branch=master

[issues-url]: https://github.com/JuliaRecsys/EvaluationCF.jl/issues
