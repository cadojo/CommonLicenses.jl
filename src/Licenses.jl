"""
Display open-source software (and other) licenses inline in your executable documents!

# Extended help

## README

$(README)

## License
$(LICENSE)

## Exports
$(EXPORTS)

## Imports
$(IMPORTS)
"""
module Licenses

export License

using HTTP
using JSON
using Dates
using Scratch
using DocStringExtensions

SPDX_SCRATCH = ""
const GITHUB_LICENSE_ENDPOINT = "https://api.github.com/licenses"
const SPDX_LICENSE_ENDPOINT = "https://spdx.org/licenses"

include("docstrings.jl")

function __init__()
    global SPDX_SCRATCH = @get_scratch!("spdx")
end

function getlicense(identifier::AbstractString; cache=true)

    global SPDX_SCRATCH

    filename = joinpath(SPDX_SCRATCH, identifier * ".json")

    if !cache || !isfile(filename)
        response = HTTP.get(HTTP.safer_joinpath(SPDX_LICENSE_ENDPOINT, identifier * ".json"), format="json")
        content = JSON.parse(String(response.body))

        try
            response = HTTP.get(HTTP.safer_joinpath(GITHUB_LICENSE_ENDPOINT, identifier), format="application/vnd.github+json")
            content["licensee"] = JSON.parse(String(response.body))
        catch exception
            if !(exception isa HTTP.Exceptions.StatusError)
                rethrow(exception)
            end
        end

        if cache
            open(filename, "w") do file
                JSON.print(file, content)
            end
        end

        return content
    else
        content = JSON.parsefile(filename)
        return content
    end

end

include("interface.jl")
include("implementation.jl")
include("common.jl")

end # module Licenses
