export Axis, GridType, Sign  # enumerated types
export XYZ, nX, nY, nZ, nXYZ
export NP, nN, nP, nNP
export PD, nPR, nDL, nPD
export numel, next1, next2, next3, prev1, prev2, prev3, alter, ft2gt  # functions

# 3D axes
const nX, nY, nZ = 1, 2, 3  # x, y, z coordinates
const nXYZ, nYZX, nZXY = SVector(nX,nY,nZ), SVector(nY,nZ,nX), SVector(nZ,nX,nY)
const CYC_nAXES = (nYZX, nZXY, nXYZ)  # not (nXYZ, nYZX, nZXY)
const nXZY, nYXZ, nZYX = SVector(nX,nZ,nY), SVector(nY,nX,nZ), SVector(nZ,nY,nX)
const ACYC_nAXES = (nZYX, nXZY, nYXZ)  # not (nXZY, nYXZ, nZYX)
@enum Axis X̂=nX Ŷ Ẑ
const XYZ, YZX, ZXY = SVector(X̂,Ŷ,Ẑ), SVector(Ŷ,Ẑ,X̂), SVector(Ẑ,X̂,Ŷ)
const CYC_AXES = (YZX, ZXY, XYZ)  # not (XYZ, YZX, ZXY)
const XZY, YXZ, ZYX = SVector(X̂,Ẑ,Ŷ), SVector(Ŷ,X̂,Ẑ), SVector(Ẑ,Ŷ,X̂)
const ACYC_AXES = (ZYX, XZY, YXZ)  # not (XZY, YXZ, ZYX)
for ins in instances(Axis); @eval export $(Symbol(ins)); end  # export all instances
Base.string(ins::Axis) = ins==X̂ ? "x" : (ins==Ŷ ? "y" : "z")

next3(ins::Axis) = CYC_AXES[Int(ins)]
next2(ins::Axis) = (n3 = next3(ins); SVector(n3[1], n3[2]))
next1(ins::Axis) = next3(ins)[1]
next3(nw::Int) = CYC_nAXES[nw]
next2(nw::Int) = (n3 = CYC_nAXES[nw]; SVector(n3[1], n3[2]))
next1(nw::Int) = next3(nw)[1]

prev3(ins::Axis) = ACYC_AXES[Int(ins)]
prev2(ins::Axis) = (p3 = prev3(ins); SVector(p3[1], p3[2]))
prev1(ins::Axis) = prev3(ins)[1]
prev3(nw::Int) = ACYC_nAXES[nw]
prev2(nw::Int) = (p3 = ACYC_nAXES[nw]; SVector(p3[1], p3[2]))
prev1(nw::Int) = prev3(nw)[1]


# Signs
const nN, nP = 1, 2  # negative, positive directions
const nNP = SVector(nN,nP)  # tuple allocation is more efficient than array allocation
@enum Sign NEG=nN POS
const NP = SVector(NEG, POS)
for ins in instances(Sign); @eval export $(Symbol(ins)); end  # export all instances
Base.string(ins::Sign) = ins==NEG ? "negative" : "positive"
alter(ins::Sign) = ins==NEG ? POS : NEG


# Grid types
const nPR, nDL = 1, 2  # primal, dual grids
const nPD = SVector(nPR,nDL)  # tuple allocation is more efficient than array allocation
@enum GridType PRIM=nPR DUAL
const PD = SVector(PRIM, DUAL)
for ins in instances(GridType); @eval export $(Symbol(ins)); end  # export all instances
Base.string(ins::GridType) = ins==PRIM ? "primal" : "dual"
alter(ins::GridType) = ins==PRIM ? DUAL : PRIM


# Functions for enumerated types
numel(::Type{T}) where {T<:Enum} = length(instances(T))
alter(n::Int) = 3-n
