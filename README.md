[![Tests](https://github.com/cadojo/CommonLicenses.jl/workflows/UnitTests/badge.svg)](https://github.com/cadojo/CommonLicenses.jl/actions?query=workflow%3AUnitTests)
[![Docs](https://github.com/cadojo/CommonLicenses.jl/workflows/Documentation/badge.svg)](https://cadojo.github.io/CommonLicenses.jl/dev)

# `CommonLicenses.jl`

_Executable licenses for executable documents!_

## Installation

_Choose one of the lines below!_

```julia
import Pkg; Pkg.add("CommonLicenses")
```

```julia
# In a Julia REPL
]add CommonLicenses
```

## Motivation

_Why does this exist?_

Imagine you're writing a blog post. Or a [Pluto](https://plutojl.org) notebook.
Or a [Jupyter](https://jupyter.org) notebook. Or whatever! You're writing words
alongside content, and you'd like to license your work. The license needs to
stand _alone_ with your document; the "naive" solution is to find the contents
of your standard license file, and paste the license into a block of text
somewhere in your document. Cool. Two weeks later you're writing _another_ blog
post, or whatever. You need to re-find the contents of this license. Not a big
deal, but this gets a bit cumbersome, right?

Enter: `CommonLicenses.jl`. This package provides every standard license tracked
by the [SPDX License List](https://spdx.org/licenses/), so all you need to do is
install this package, and print your desired license wherever you want it!

## Usage

_Try it out for yourself!_

```julia
julia> using CommonLicenses

julia> using CommonLicenses: MIT, Unlicense

julia> MIT()

julia> Unlicense()

julia> CommonLicenses.text(MIT(copyright="Joe(y)"))

julia> CommonLicenses.name(License("CC-BY-4.0"))
```

## Credits

_Built on top of lots of helpful projects!_

This package was developed independently of
[`PkgLicenses.jl`](https://github.com/JuliaPackaging/PkgLicenses.jl/tree/master),
though it does look like `JuliaPackaging` got there first! This package adds
goodies on top of the functionality of `PkgLicenses.jl`, including `MIME` type
support, and licenses for non-software projects such as Creative Commons.

The [SPDX License List](https://spdx.org/licenses/) is used to fetch the
contents for each requested license. The GitHub
[License API](https://docs.github.com/en/rest/licenses) is used to find
additional metadata for each license, if available.
