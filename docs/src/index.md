# `Licenses.jl`

_Licenses for open source software, writing, media, and more!_

## Installation

_Choose one of the two lines below!_

```julia
julia> import Pkg; Pkg.add("Licenses")

julia> ]add Licenses
```

## Usage

_Conveniently add an open source license to your executable document!_

```@repl main
using Licenses: MIT

MIT(copyright="Joey")
```
