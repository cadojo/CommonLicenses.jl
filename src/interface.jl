#
# The abstract interface for all license types
#

"""
A supertype for all licenses.

# Extended Help

All `License` subtypes should have the following methods defined:

- `Licenses.name(license)::AbstractString`
- `Licenses.spdx(license)::AbstractString`
- `Licenses.text(license)::AbstractString`

The following methods may be optionally defined.

- `Licenses.conditions(license)::AbstractSet{<:AbstractString}`
- `Licenses.permissions(license)::AbstractSet{<:AbstractString}`
- `Licenses.limitations(license)::AbstractSet{<:AbstractString}`
- `Licenses.arguments(license)::NTuple{N,Pair{<:AbstractString,Symbol}} where {N}`
- `Licenses.defaults(license)::NTuple{N,Pair{Symbol,<:Any}} where {N}`
"""
abstract type AbstractLicense end

Base.show(io::IO, ::MIME"text/plain", license::AbstractLicense) = println(io, text(license))

function Base.show(io::IO, ::MIME"text/html", license::AbstractLicense)
    contract = replace(text(license), "\n" => "<br>")
    content = """
    <details>
    <summary>$(name(license))</summary>
    <code>
    $(contract)
    </code>
    </details>
    """

    println(io, content)
end

"""
Return the official name for the license.
"""
function name end

"""
Return the SPDX identifier for the license.
"""
function spdx end

"""
Return the text of the license, with replacement arguments specified if necessary.
"""
function text end


const GITHUB_LICENSEE_REFERENCES = """
- GitHub License Endpoint: $GITHUB_LICENSE_ENDPOINT
- GitHub License API Docs: https://docs.github.com/en/rest/licenses#get-a-license
- GitHub Page for `licensee`: https://github.com/licensee/licensee
"""

"""
Return a hint at the conditions of the license. This is provided through GitHub's License
API, which itself depends on the `licensee` Ruby project.

# Extended Help

## References

$GITHUB_LICENSEE_REFERENCES
"""
function conditions end

"""
Return a hint at the permissions of the license. This is provided through GitHub's License
API, which itself depends on the `licensee` Ruby project.

# Extended Help

## References

$GITHUB_LICENSEE_REFERENCES
"""
function permissions end

"""
Return a hint at the limitations of the license. This is provided through GitHub's License
API, which itself depends on the `licensee` Ruby project.

# Extended Help

## References

$GITHUB_LICENSEE_REFERENCES
"""
function limitations end

"""
Specify keywords to replace within the license's text.

# Extended Help

Some licenses include small bits of custom information, i.e. the date and name at the top of
many MIT licenses. Defining this method for a license type allows a user to specify this
information in the argument of the license constructor. If no specific keywords are
provided, a fallback method returns an empty `NamedTuple`.
"""
function arguments end

"""
Specify default values for each license argument.

# Extended Help

See also, `Licenses.arguments`.
"""
function defaults end

"""
Return all required arguments.

# Extended Help

See also, `Licenses.arguments`.
"""
function required(license::AbstractLicense)
    return map(
        pair -> pair.second,
        filter(pair -> ismissing(pair.second), pairs(defaults(license)))
    )
end
