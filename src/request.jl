include("route.jl")

module Requests
using ..Routes

export Request

http_methods = [
    "CONNECT",
    "DELETE",
    "GET",
    "HEAD",
    "OPTIONS",
    "PATCH",
    "POST",
    "PUT",
    "TRACE"
]

struct Request
    method::String
    path::String
    headers::Union{Nothing,Dict{String,String}}
    body::String

    function Request(method, path, headers, body)
        if !(method in http_methods)
            throw(error("Invalid request method."))
        end

        return new(method, path, headers, body)
    end
end

function handle(req::Request)
    route = Router[req|>to_endpoint]
    result = route.call()
    return result
end

function to_endpoint(req::Request)
    return *(req.method, " ", req.path)
end

end