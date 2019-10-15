abstract type ResamplingStrategy{T} end

function Base.getindex(sampling::ResamplingStrategy, idx::Int)
    if idx > length(sampling)
        throw(ArgumentError("index must satisfy 1 <= idx <= length(sampling)"))
    end

    return (getTrainData(sampling, idx), getTestData(sampling, idx))
end

Base.iterate(sample::ResamplingStrategy, state=1) = state > length(sample) ? nothing : (sample[state], state + 1)

get(sampling::ResamplingStrategy) = [sample for sample in sampling]
