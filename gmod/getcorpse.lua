local name = rag:GetNWString( "nick" )

for _, ply in ipairs( player.GetHumans() ) do
    if ply:Nick() == name then
        -- Run the console command on ply
    end
end
