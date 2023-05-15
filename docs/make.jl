using Documenter
using CommonLicenses

makedocs(
    sitename="CommonLicenses",
    format=Documenter.HTML(),
    modules=[CommonLicenses]
)

deploydocs(
    target="build",
    repo="github.com/cadojo/CommonLicenses.jl.git",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "manual", "v#.#", "v#.#.#"],
)
