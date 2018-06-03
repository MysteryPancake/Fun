local stopInput = false

hook.Add( "Think", "StupidHack", function()
    if stopInput then
        input.StartKeyTrapping()
    end
end )
