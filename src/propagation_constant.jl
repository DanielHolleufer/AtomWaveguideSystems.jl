function fiber_equation(u, p)
    k, a, n = p
    κ = sqrt(k^2 * n^2 - u^2)
    q = sqrt(u^2 - k^2)
    κa = κ * a
    γa = q * a
    J0 = besselj0(κa)
    J1 = besselj1(κa)
    K1 = besselk1(γa)
    K1p = -1 / 2 * (besselk0(γa) + besselk(2, γa))
    A = J0 / (κa * J1)
    B = (n^2 + 1) / (2 * n^2) * K1p / (γa * K1)
    C = -1 / (κa^2)
    D = sqrt(((n^2 - 1) / (2 * n^2) * K1p / (γa * K1))^2 + u^2 / (n^2 * k^2) * (1 / (γa^2) + 1 / (κa^2))^2)
    return A + B + C + D
end

function fiber_equation2(u, p)
    k, atom_waveguide_system = p
    n = atom_waveguide_system.refractive_index
    κa = sqrt(k^2 * n^2 - u^2) * atom_waveguide_system.radius
    γa = sqrt(u^2 - k^2) * atom_waveguide_system.radius

    J1 = besselj1(κa)
    J1p = (besselj0(κa) - besselj(2, κa)) / 2
    K1 = besselk1(γa)
    K1p = -1 / 2 * (besselk0(γa) + besselk(2, γa))

    A = u^2 / (k^2) * (1 / (κa^2) + 1 / (γa^2))^2
    B = J1p / (κa * J1) + K1p / (γa * K1)
    C = n^2 * J1p / (κa * J1) + K1p / (γa * K1)

    return B * C - A
end

function propagation_constant(frequency::Real, radius::Real, refractive_index::Real)
    uspan = (frequency + eps(), frequency * refractive_index - eps())
    p = (frequency, radius, refractive_index)
    prob_int = IntervalNonlinearProblem(fiber_equation, uspan, p)
    sol = solve(prob_int)
    return sol.u
end

function propagation_constant(frequency::Real, atom_waveguide_system::AtomWaveguideSystem)
    propagation_constant(frequency::Real, atom_waveguide_system.radius::Real, atom_waveguide_system.refractive_index::Real)
    return sol.u
end

function propagation_constant_derivative(frequency::Real, atom_waveguide_system::AtomWaveguideSystem, stepsize::Real = 10e-9)
    β_plus = propagation_constant(frequency + stepsize / 2, atom_waveguide_system)
    β_minus = propagation_constant(frequency - stepsize / 2, atom_waveguide_system)
    dβ = (β_plus - β_minus) / stepsize
    return dβ
end

function normalized_frequency(frequency::Real, atom_waveguide_system::AtomWaveguideSystem)
    a = atom_waveguide_system.radius
    n = atom_waveguide_system.refractive_index
    V = frequency * a * sqrt(n^2 - 1)
    return V
end

function normalized_propagation_constant(frequency::Real, atom_waveguide_system::AtomWaveguideSystem)
    β = propagation_constant(frequency, atom_waveguide_system)
    return (β / frequency - 1) / (atom_waveguide_system.refractive_index - 1)
end

function effective_refractive_index(frequency::Real, atom_waveguide_system::AtomWaveguideSystem)
    β = propagation_constant(frequency, atom_waveguide_system)
    return β / frequency
end