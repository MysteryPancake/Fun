BMASKS.CreateMask( "GunMask", "icon16/gun.png", "noclamp smooth" )

hook.Add( "HUDPaint", "MaskTest", function() 
	BMASKS.BeginMask( "GunMask" )
	surface.SetDrawColor( 255, 150, 0 )
	surface.DrawRect( 0, 0, 128, 128 )
	BMASKS.EndMask( "GunMask", 0, 0, 128, 128 )
end )
