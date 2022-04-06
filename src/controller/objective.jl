abstract type Objective end

mutable struct TrackingObjective{Q,U,C,B} <: Objective
    q::Vector{Q}
    u::Vector{U}
    γ::Vector{C}
    b::Vector{B}
end

function TrackingObjective(model, env, H::Int;
    q = [Diagonal(zeros(SizedVector{model.nq})) for t = 1:H],
    u = [Diagonal(zeros(SizedVector{model.nu})) for t = 1:H],
    γ = [Diagonal(zeros(SizedVector{model.nc})) for t = 1:H],
    b = [Diagonal(zeros(SizedVector{model.nc * friction_dim(env)})) for t = 1:H])
    return TrackingObjective(q, u, γ, b)
end

mutable struct TrackingVelocityObjective{Q,V,U,C,B,VT} <: Objective
    q::Vector{Q}
    v::Vector{V}
    u::Vector{U}
    γ::Vector{C}
    b::Vector{B}
    v_target::Vector{VT}
end

function TrackingVelocityObjective(model, env, H::Int;
    q = [Diagonal(zeros(SizedVector{model.nq})) for t = 1:H],
    v = [Diagonal(zeros(SizedVector{model.nq})) for t = 1:H],
    u = [Diagonal(zeros(SizedVector{model.nu})) for t = 1:H],
    γ = [Diagonal(zeros(SizedVector{model.nc})) for t = 1:H],
    b = [Diagonal(zeros(SizedVector{model.nc * friction_dim(env)})) for t = 1:H],
    v_target = [zeros(SizedVector{model.nq}) for t = 1:H])
    return TrackingVelocityObjective(q, v, u, γ, b, v_target)
end
