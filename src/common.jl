#
# Some
#

const MIT = License{:MIT}
const Unlicense = License{:Unlicense}

const AGPL3 = License{Symbol("AGPL-3.0")}
const Apache2 = License{Symbol("Apache-2.0")}
const BSD2 = License{Symbol("BSD-2-Clause")}
const BSD3 = License{Symbol("BSD-3-Clause")}
const BSL1 = License{Symbol("BSL-1.0")}
const GPL2 = License{Symbol("GPL-2.0")}
const GPL3 = License{Symbol("GPL-3.0")}
const LGPL2 = License{Symbol("LGPL-2.1")}
const MPL2 = License{Symbol("MPL-2.0")}
const CC01 = License{Symbol("CC0-1.0")}

# Implement the MIT license

arguments(::Type{License{:MIT}}) = ("<year>" => :year, "<copyright holders>" => :copyright)
defaults(::Type{License{:MIT}}) = (:year => year(today()), :copyright => "")

function License{:MIT}(; year=year(today()), copyright="")
    args = Dict(
        map(reverse, arguments(License{:MIT}))
    )

    return License("MIT", getindex(args, :year) => year, getindex(args, :copyright) => copyright)
end

# Implement the BSD-2-Clause license

arguments(::Type{License{Symbol("BSD-2-Clause")}}) = ("<year>" => :year, "<owner>" => :copyright)
defaults(::Type{License{Symbol("BSD-2-Clause")}}) = (:year => year(today()),)

function License{Symbol("BSD-2-Clause")}(; year=year(today()), copyright)
    args = Dict(
        map(reverse, arguments(License{Symbol("BSD-2-Clause")}))
    )

    return License("BSD-2-Clause", getindex(args, :year) => year, getindex(args, :copyright) => copyright)
end

# Implement the BSD-3-Clause license
arguments(::Type{License{Symbol("BSD-3-Clause")}}) = ("<year>" => :year, "<owner>" => :copyright)
defaults(::Type{License{Symbol("BSD-3-Clause")}}) = (:year => year(today()),)

function License{Symbol("BSD-3-Clause")}(; year=year(today()), copyright)
    args = Dict(
        map(reverse, arguments(License{Symbol("BSD-3-Clause")}))
    )

    return License("BSD-3-Clause", getindex(args, :year) => year, getindex(args, :copyright) => copyright)
end
