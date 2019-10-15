
struct HoldOut{T <: Persa.AbstractDataset} <: ResamplingStrategy{T}
    dataset::T
    index::Array{Int}
    k::Float64
end

function HoldOut(dataset::Persa.AbstractDataset; is_shuffle::Bool = true, margin::Float64 = 0.9)
    if is_shuffle == true
        return HoldOut(dataset, shuffle(collect(1:length(dataset))), margin)
    else
        return HoldOut(dataset, collect(1:length(dataset)), margin)
    end
end

Base.length(ho::HoldOut) = 1

function getTrainData(holdout::HoldOut{T}, _::Int) :: T where T
    index = findall(r -> r < length(holdout.dataset) * holdout.k, holdout.index)
    return Persa.sample(holdout.dataset, index)
end

function getTestData(holdout::HoldOut{T}, _::Int) :: T where T
    index = findall(r -> r >= length(holdout.dataset) * holdout.k, holdout.index)
    return Persa.sample(holdout.dataset, index)
end
