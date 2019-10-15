module EvaluationCF

using Persa

using Random: shuffle

include("experimental/resampling.jl")
include("experimental/holdout.jl")
include("experimental/kfolds.jl")

include("metrics/accuracy.jl")

end # module
