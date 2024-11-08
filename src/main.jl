function extend!(_PT::AbstractDict)

    if !haskey(_PT["tree"]["extra"].action,"i")
        message = "i. Internal isochron\n" * _PT["tree"]["extra"].message
        action = _PT["tree"]["extra"].action
        action["i"] = TUIinternochron
        updateTree!(_PT["tree"],"extra",
                    message = message,
                    action = action)
    end

end
export extend!

function updateTree!(tree::AbstractDict,
                     key::AbstractString;
                     message=tree[key].message,
                     help=tree[key].help,
                     action=tree[key].action)
    tree[key] = (message=message,help=help,action=action)
end

function TUIinternochron(ctrl::AbstractDict)
    P, D, d = Plasmatrace.atomic(ctrl["run"][ctrl["i"]],
                                 ctrl["channels"],
                                 ctrl["blank"],
                                 ctrl["par"])
    x0, y0 = internochron(P,D,d)
    Plots.plot([0,x0],[y0,0])
    Plots.plot!(P/D,d/D, seriestype=:scatter)
end
export TUIinternochron
