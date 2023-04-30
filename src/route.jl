module Routes
export Router, GET, POST, PUT, DELETE

Router = Dict()

mutable struct Route
    method::String
    path::String
    call::Function

    function Route(method::String, path::String, call::Function)
        route = new(method, path, call)
        Router[route|>to_endpoint] = route
        return route
    end
end

function to_endpoint(route::Route)
    return *(route.method, " ", route.path)
end

GET(path, call) = Route("GET", path, call)
POST(path, call) = Route("POST", path, call)
PUT(path, call) = Route("PUT", path, call)
DELETE(path, call) = Route("DELETE", path, call)

end