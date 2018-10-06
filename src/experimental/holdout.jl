struct HoldOut
    dataset::Persa.Dataset
    index::Array
    k::Float64
end

HoldOut(dataset::Persa.Dataset, margin::Float64) = HoldOut(dataset, shuffle(collect(1:length(dataset))), margin)

get(holdout::HoldOut) = (getTrainData(holdout), getTestData(holdout))

function getTrainData(holdout::HoldOut)
    index = findall(r -> r < length(holdout.dataset) * holdout.k, holdout.index)
    return Persa.Dataset(holdout.dataset[index], holdout.dataset.users, holdout.dataset.items, holdout.dataset.preference)
end

function getTestData(holdout::HoldOut)
    index = findall(r -> r >= length(holdout.dataset) * holdout.k, holdout.index)
    return Persa.Dataset(holdout.dataset[index], holdout.dataset.users, holdout.dataset.items, holdout.dataset.preference)
end
