local rendering = false
local rt = GetRenderTarget( "RenderView", ScrW(), ScrH(), true )
local mat = CreateMaterial( "UnlitGeneric", "GMODScreenspace", {
	[ "$basetexturetransform" ] = "center .5 .5 scale -1 -1 rotate 0 translate 0 0",
	[ "$texturealpha" ] = "0",
	[ "$vertexalpha" ] = "1"
} )

hook.Add( "PostDrawOpaqueRenderables", "RenderView", function( depth, skybox )

	if rendering or skybox then return end

	local tr = LocalPlayer():GetEyeTrace()
	local pos = tr.HitPos
	local ang = tr.HitNormal:Angle()
	ang:RotateAroundAxis( ang:Up(), -90 )

	render.PushRenderTarget( rt )

		render.Clear( 0, 0, 0, 255, true, true )

		rendering = true
		render.RenderView( { x = 0, y = 0, w = ScrW(), h = ScrH(), origin = pos, angles = EyeAngles() } )
		rendering = false

	render.PopRenderTarget()

	cam.Start3D2D( pos, ang, 1 )
		mat:SetTexture( "$basetexture", rt )
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( -ScrW() / 2, -ScrH() / 2, ScrW(), ScrH() )
	cam.End3D2D()

end )
