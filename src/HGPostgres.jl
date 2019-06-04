module HGPostgres

using LibPQ
export HGConnection, close!

greet() = print("Hello World 3!")

"""
    db_connect(uri)

Provides the creation of a DB Connection object.

# Examples

HGConnection("dbname=postgres user=postgres password=postgres port=5432 host=localhost")
"""
dbconnect(uri::String) = LibPQ.Connection(uri)

dbclose(conn) = close(conn)

# dbquery(conn, string, parameters)
# 3
# end


mutable struct HGConnection{T}
    conn::T
    isopen::Bool
end

function HGConnection(uri::String)
    conn = dbconnect(uri)
    HGConnection(conn, true)
end

function close!(conn::HGConnection)
    if conn.isopen
        dbclose(conn.conn)
    end
    conn.isopen = false
end

end # module


