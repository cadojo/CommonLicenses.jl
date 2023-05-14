using Documenter
using Licenses

makedocs(
    sitename="Licenses",
    format=Documenter.HTML(),
    modules=[Licenses]
)

deploydocs(
    target="build",
    repo="github.com/cadojo/Licenses.jl.git",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "manual", "v#.#", "v#.#.#"],
)
