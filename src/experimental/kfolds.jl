struct KFolds
    dataset::Persa.AbstractDataset
    index::Array
    k::Int
end

KFolds(dataset::Persa.AbstractDataset, k::Int) = KFolds(dataset, splitKFold(length(dataset), k), k)

getTrainIndex(kfold::KFolds, fold::Int) = findall(r -> r != fold, kfold.index)
getTestIndex(kfold::KFolds, fold::Int) = findall(r -> r == fold, kfold.index)

Base.iterate(kf::KFolds, state=1) = state > kf.k ? nothing : (kf[state], state + 1)

Base.getindex(kf::KFolds, idx) = (Persa.Dataset(kf.dataset[getTrainIndex(kf, idx)],
                                                kf.dataset.users,
                                                kf.dataset.items,
                                                kf.dataset.preference),
                                  Persa.Dataset(kf.dataset[getTestIndex(kf, idx)],
                                                kf.dataset.users,
                                                kf.dataset.items,
                                                kf.dataset.preference))
Base.length(kf::KFolds) = kf.k

function splitKFold(y, num_folds)
  i = shuffle(collect(1:y));
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
