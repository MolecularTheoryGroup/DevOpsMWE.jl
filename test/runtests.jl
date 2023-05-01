using DevOpsMWE
using Test

@testset "DevOpsMWE.jl" begin
    @test greet() == "Hello, World!"
    @test all([
        isapprox(sin_interpolant_0to1()(x), sin(x); atol=1e-4) for
        x ∈ (-8π / 9):(π / 10):(8π / 9)
    ])
end
