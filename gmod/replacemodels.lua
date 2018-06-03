hook.Add( "PlayerSpawn", "ReplaceModels", function( ply )
	if not util.IsValidModel( ply:GetModel() ) then
		ply:SetModel( "models/player/kleiner.mdl" )
		ply:ConCommand( "cl_playermodel Kleiner" )
	end
end )
