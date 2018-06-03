local lookAtSelf = false

hook.Add( "Think", "LookAtSelfKeyPress", function() -- Every time 'think' is called (which is every frame for clients) this will be run.
	lookAtSelf = input.IsKeyDown( KEY_B ) --  Set the variable 'LookAtSelf' to be true if the key is down
end )

hook.Add( "CalcView", "LookAtSelf", function( ply, pos, angles, fov ) --This actually changes the view

	if lookAtSelf then -- If the value we created in the previous hook isn't nothing (nil) (which is unlikely but just in case), and it's also positive (meaning the player's B key is down) then continue with changing the view
	
		local view = {}

		view.origin = pos - ( angles:Forward() * -60 )
		view.angles = angles - Angle( 0, 180, 0 )
		view.fov = fov
		view.drawviewer = true

		return view -- This is slightly modified code from the wiki's example of a CalcView hook so it actually faces the player instead of being behind the player, you might want to check the wiki and fiddle around a bit if you don't want this.
		
	end

end )
