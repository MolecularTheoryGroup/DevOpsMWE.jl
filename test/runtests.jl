using DevOpsMWE
using Test

@testset "DevOpsMWE.jl" begin
    @test greet() == "Hello, World!"
end
