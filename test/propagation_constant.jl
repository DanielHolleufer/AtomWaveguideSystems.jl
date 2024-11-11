@testset "Propagation Constant" begin
    # Determination of the propagation constant, β, is tested in the single-mode regime. 
    # β values to test against are obtained from:
    # https://www.computational-photonics.eu/fims.html

    λ = 200
    a = 100
    n = 1.2
    k = 2π / λ
    β = AtomWaveguideSystems.propagation_constant(k, a, n)
    @test β ≈ 0.03400910381 atol = 1e-9

    λ = 987
    a = 123
    n = 1.5
    k = 2π / λ
    β = AtomWaveguideSystems.propagation_constant(k, a, n)
    @test β ≈ 0.006369099651 atol = 1e-9

    # This test uses the parameters found in https://arxiv.org/abs/2407.02278
    λ = 852
    a = 200
    n = 1.14
    k = 2π / λ
    β = AtomWaveguideSystems.propagation_constant(k, a, n)
    @test β ≈ 0.007377978051 atol = 1e-9
end