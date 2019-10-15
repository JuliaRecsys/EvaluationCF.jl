struct KFolds{T <: Persa.AbstractDataset} <: ResamplingStrategy{T}
    dataset::T
    index::Array{Int}
    k::Int
end

function KFolds(dataset::Persa.AbstractDataset; k::Int = 10, is_shuffle::Bool = true)
  return KFolds(dataset, splitKFold(length(dataset), k, is_shuffle), k)
end

function getTrainData(kfold::KFolds{T}, fold::Int) :: T where T
    index = findall(r -> r != fold, kfold.index)
    return Persa.sample(kfold.dataset, index)
end

function getTestData(kfold::KFolds{T}, fold::Int) :: T where T
    index = findall(r -> r == fold, kfold.index)
    return Persa.sample(kfold.dataset, index)
end

Base.length(kf::KFolds) = kf.k

function splitKFold(y, num_folds, is_shuffle)
  if is_shuffle
    i = shuffle(collect(1:y));
  else
     i = collect(1:y);
  end

  fold_size = round(Int, floor(y/num_folds));
  remainder = y-num_folds*fold_size;
  groups = zeros(Int, y);
  cursor = 1;
  group = 1;

  while cursor<=y
    this_fold_size = group <= remainder ? fold_size+1 : fold_size;
    groups[i[cursor:cursor+this_fold_size-1]] .= group;
    group += 1;
    cursor += this_fold_size;
  end

  return groups;
end
