include("request.jl")
include("response.jl")

using Sockets
using ..Requests: Request, handle, GET
using ..Responses: Response, TextSuccessResponse, TextServerErrorResponse

GET("/add", (a, b) -> +(a, b))
GET("/concat", (x, y) -> *(x, y))
GET("/", () -> "Hello!")

function main(req::Request)
    try
        return (TextSuccessResponse ∘ handle)(req)
    catch e
        return e.msg |> TextServerErrorResponse
    end
end

function startServer()
    server = listen(8000)
    while true
        connection = accept(server)
        @async while isopen(connection)
            line = readline(connection, keep=true)
            line = split(line, " ")
            if line[1] == "GET"
                request::Request = Request(line[1], line[2], nothing, "")
                response = main(request)
                write(connection, *(string(response), "\n"))
            end
            close(connection)
        end
    end
end

startServer()