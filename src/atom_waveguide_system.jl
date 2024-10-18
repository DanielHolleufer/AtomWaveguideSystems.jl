struct AtomWaveguideSystem{S<:Integer,T<:AbstractFloat}
    radius::T
    refractive_index::T
    resonance_frequency::T
    dipole_moment::Vector{Complex{T}}
    positions::AbstractVector{Vector{T}}
    number_of_atoms::S
    function AtomWaveguideSystem(radius::T, refractive_index::T, resonance_frequency::T, dipole_moment::Vector{Complex{T}}, positions::AbstractVector{Vector{T}}) where {T<:AbstractFloat}
        radius ≤ 0.0 && throw(DomainError(radius, "Radius of waveguide must be positive."))
        refractive_index < 1.0 && throw(DomainError(refractive_index, "Refractive index of the waveguide must be larger than or equal to 1.0."))
        resonance_frequency ≤ 0.0 && throw(DomainError(resonance_frequency, "Resonance frequency of the atom must be positive."))
        length(dipole_moment) != 3 && throw(DomainError(dipole_moment, "Atomic dipole moment must be a vector of length 3."))
        return new{Int,T}(radius, refractive_index, resonance_frequency, dipole_moment, positions, length(positions))
    end
end

function AtomWaveguideSystem(radius::Real, refractive_index::Real, resonance_frequency::Real, dipole_moment::Vector{<:Real}, positions::Vector{<:Vector{<:Real}})
    return AtomWaveguideSystem(float(radius), float(refractive_index), float(resonance_frequency), complex(float(dipole_moment)), float.(positions))
end

function Base.show(io::IO, atom_waveguide_system::AtomWaveguideSystem)
    println(io, "Atom-waveguide system with parameters:")
    println(io, "Fibre radius: $(atom_waveguide_system.radius)")
    println(io, "Refractive index: $(atom_waveguide_system.refractive_index)")
    println(io, "Atomic resonance frequency: $(atom_waveguide_system.resonance_frequency)")
    println(io, "Number of atoms: $(atom_waveguide_system.number_of_atoms)")
    print(io, "Atomic dipole moment: ")
    show(io, "text/plain", atom_waveguide_system.dipole_moment)
    print("\n")
    print(io, "Atomic positions: ")
    show(io, "text/plain", atom_waveguide_system.positions)
    print("\n")
end