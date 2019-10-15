#Mean absolute error (MAE)
function mae(model::Persa.Model, dataset::Persa.AbstractDataset)
    total = 0.0
    elements = 0

    for (u, v, r) in dataset
        value  = model[u, v]

        if !isnan(value)
            total += abs(r - value)
            elements += 1
        end
    end

    return total / elements
end

#Root mean squared error (RMSE)
function rmse(model::Persa.Model, dataset::Persa.AbstractDataset)
    total = 0.0
    elements = 0

    for (u, v, r) in dataset
        value  = model[u, v]

        if !isnan(value)
            total += (r - value)^2
            elements += 1
        end
    end

    return sqrt(total / elements)
end

#Coverage
function coverage(model::Persa.Model, dataset::Persa.AbstractDataset)
    elements = 0

    for (u, v, r) in dataset
        !isnan(model[u, v]) ? elements += 1 : nothing
    end

    return elements / length(dataset)
end
