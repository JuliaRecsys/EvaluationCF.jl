using Persa
using Test
using DataFrames
using EvaluationCF

function createdummydataset()
    df = DataFrame()
    df[!, :user] = [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6]
    df[!, :item] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 4]
    df[!, :rating] = [2.5, 3.5, 3.0, 3.5, 2.5, 3.0, 3, 3.5, 1.5, 5, 3, 3.5, 2.5, 3.0, 3.5, 4.0, 3.5, 3.0, 4.0, 2.5, 4.5, 3.0, 4.0, 2.0, 3.0, 2.0, 3.0, 3.0, 4.0, 5.0]
    return df
end
####

dataframe = createdummydataset()
dataset = Persa.Dataset(dataframe)

@testset "Resampling Tests" begin
    @testset "Holdout" begin
        margin = 0.5

        ds_train, ds_test = EvaluationCF.HoldOut(dataset; margin = margin)[0]

        @test length(ds_train) == length(dataset) * margin
        @test length(ds_test) == length(dataset) * (1 - margin)
    end

    @testset "Holdout" begin
        k = 10

        folds = EvaluationCF.KFolds(dataset; k = k)

        i = 0

        for (ds_train, ds_test) in folds
            i = i + 1
            @test length(ds_train) == length(dataset) * (1 - (1 / k))
            @test length(ds_test) == length(dataset) * (1 / k)
        end

        @test i == k
    end
end

@testset "Metrics Tests" begin

end