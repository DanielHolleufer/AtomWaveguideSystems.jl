using AtomWaveguideSystems
using Documenter

DocMeta.setdocmeta!(AtomWaveguideSystems, :DocTestSetup, :(using AtomWaveguideSystems); recursive=true)

makedocs(;
    modules=[AtomWaveguideSystems],
    authors="Daniel Holleufer <daniel.holleufer@gmail.com> and contributors",
    sitename="AtomWaveguideSystems.jl",
    format=Documenter.HTML(;
        canonical="https://DanielHolleufer.github.io/AtomWaveguideSystems.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/DanielHolleufer/AtomWaveguideSystems.jl",
    devbranch="master",
)
