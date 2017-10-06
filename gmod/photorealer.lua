local pos, ang
local rendering = false
local rt = GetRenderTarget( "PhotoReal", ScrW(), ScrH(), false )
local mat = CreateMaterial( "UnlitGeneric", "GMODScreenspace", {
	[ "$basetexturetransform" ] = "center .5 .5 scale -1 -1 rotate 0 translate 0 0",
	[ "$texturealpha" ] = "0",
	[ "$vertexalpha" ] = "1"
} )

hook.Add( "RenderScene", "PhotoReal", function()

	if rendering or not pos or not ang then return end

	render.PushRenderTarget( rt )

		render.Clear( 0, 0, 0, 255, true, true )

		rendering = true
		render.RenderView( {
			x = 0, y = 0,
			w = ScrW(), h = ScrH(),
			origin = pos, angles = ang,
			dopostprocess = false,
			drawviewmodel = false,
			drawmonitors = false,
			bloomtone = true,
			drawhud = false
		} )
		rendering = false

	render.PopRenderTarget()

end )

hook.Add( "PostDrawOpaqueRenderables", "PhotoReal", function( _, skybox )

	if rendering or skybox or not pos or not ang then return end

	mat:SetTexture( "$basetexture", rt )
		
	cam.Start3D2D( pos + ang:Forward() * ( math.sqrt( ScrW() * ScrH() ) / 2 ) + ang:Right() * -( ScrW() / 2 ) + ang:Up() * ( ScrH() / 2 ), Angle( 0, ang.y - 90, -ang.p + 90 ), 1 )
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
	cam.End3D2D()


end )

concommand.Add( "PhotoReal", function()
	pos = EyePos()
	ang = EyeAngles()
end )
