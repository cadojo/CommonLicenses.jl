#
# A default implementation for the AbstractLicense interface
#

"""
Metadata for a legal license. When an instance of this type is `Base.show`n, the content is
displayed in a software-license-typical format: i.e. as you would see in a software
repository's `LICENSE` file.
"""
struct License{
    ID,
    C<:Union{Missing,<:AbstractSet{<:AbstractString}},
    P<:Union{Missing,<:AbstractSet{<:AbstractString}},
    L<:Union{Missing,<:AbstractSet{<:AbstractString}},
} <: AbstractLicense

    spdx::String
    name::String
    text::String
    conditions::C
    permissions::P
    limitations::L

    function License{ID}(spdx, name, text, html=missing; conditions=missing, permissions=missing, limitations=missing) where {ID}
        return new{
            Symbol(ID),typeof(conditions),typeof(permissions),typeof(limitations)
        }(
            spdx, name, text, conditions, permissions, limitations,
        )
    end
end

name(license::License) = license.name
spdx(license::License) = license.spdx
text(license::License) = license.text

conditions(license::License) = license.conditions
permissions(license::License) = license.permissions
limitations(license::License) = license.limitations

arguments(::Type{License{S}}) where {S} = ()
defaults(::Type{License{S}}) where {S} = ()


"""
Construct a license, using keyword arguments to replace the keywords specified by
`arguments(License{ID})`.
"""
function License{ID}(; kwargs...) where {ID}

    if any(pair -> ismissing(pair.second), pairs(kwargs))
        throw(ArgumentError("Some required arguments are missing! Call `Licenses.required(License{$ID})` to see what requirements are available."))
    end

    args = Dict(
        defaults(License{ID})...,
        kwargs...,
    )

    replacements = map(
        pair -> pair.first => get(args, pair.second, ""),
        arguments(License{ID})
    )

    return License(string(ID), replacements...)
end

"""
Construct a license using the SPDX identifier, and any modifications you wish to make to the
license text.
"""
function License(identifier::Union{<:Symbol,<:AbstractString}, modifications::Pair{<:AbstractString,<:Any}...)

    content = getlicense(string(identifier))

    spdx = content["licenseId"]
    name = content["name"]
    text = replace(content["licenseText"], modifications...)

    licensee = get(content, "licensee", missing)

    if ismissing(licensee)
        cs = missing
        ps = missing
        ls = missing
    else
        cs = Set{String}(get(licensee, "conditions", missing))
        ps = Set{String}(get(licensee, "permissions", missing))
        ls = Set{String}(get(licensee, "limitations", missing))
    end

    return License{Symbol("$identifier")}(
        spdx, name, text;
        conditions=cs,
        permissions=ps,
        limitations=ls
    )

end
