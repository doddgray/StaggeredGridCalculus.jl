using StaggeredGridCalculus
using Test
# using Statistics: mean
using StaticArrays

Base.isapprox(a::Tuple, b::Tuple; kws...) = all(p -> isapprox(p...; kws...), zip(a,b))

# @testset "StaggeredGridCalculus" begin

include("enumtype.jl")
include("util.jl")
include("grid.jl")
# # include("gridgen.jl")
include("differential.jl")
include("mean.jl")
include("pml.jl")

# end  # @testset "StaggeredGridCalculus"
