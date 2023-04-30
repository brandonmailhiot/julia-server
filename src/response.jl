module Responses
export Response, TextSuccessResponse, TextServerErrorResponse

struct Response
    status::Int
    headers::Dict{String,String}
    body::Union{String,Integer,Dict{String,Any}}
end

TextResponse(status, body::Union{String,Integer}) = Response(status, Dict("Content-Type" => "text/plain"), body)
TextSuccessResponse(body) = TextResponse(200, body)
TextServerErrorResponse(body) = TextResponse(500, body)

JsonResponse(status, body::Dict{String,Any}) = Response(status, Dict("Content-Type" => "application/json"), body)
JsonSuccessResponse(body) = JsonResponse(200, body)
JsonServerErrorResponse(body) = JsonResponse(500, body)
end