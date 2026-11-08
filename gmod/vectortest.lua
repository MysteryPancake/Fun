concommand.Add( 'ShowMeAVector', function(ply,_,_,args)
ply.watchingvec = true
	hook.Add( 'HUDPaint', 'ShowMeAVector', function()
		if ply.watchingvec == true then
		local vec = util.StringToType(args,'Vector')
		ply:SetEyeAngles(( vec-ply:GetShootPos() ):Angle())
		local vecscreenpos = vec:ToScreen()
		draw.NoTexture()
		local txt = 'Vector ('..vec.x..', '..vec.y..', '..vec.z..')'
		surface.SetFont( 'Trebuchet24' )
		local w = surface.GetTextSize(txt)/2
		draw.SimpleTextOutlined( txt, 'Trebuchet24', tonumber(vecscreenpos.x)-w, tonumber(vecscreenpos.y)-45, color_white, 0, 0, 2, color_black )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( tonumber(vecscreenpos.x)-20, tonumber(vecscreenpos.y)-20, 40, 40 )
		surface.SetDrawColor( 255, 0, 0, 255 )
		surface.DrawRect( tonumber(vecscreenpos.x)-17, tonumber(vecscreenpos.y)-17, 34, 34 )
		end
	end )
end )

concommand.Add( 'StopShowingMeAVector', function(ply)
	ply.watchingvec = false
	ply.watching2vecs = false
end )

concommand.Add( 'ShowMeTwoVectors', function(ply,_,_,args)
ply.watching2vecs = true
	hook.Add( 'HUDPaint', 'ShowMeTwoVectors', function()
		if ply.watching2vecs == true then
		local words = {}
		for word in string.gmatch(args,'%S+') do words[#words+1] = word end
		local vec1 = Vector(words[1],words[2],words[3])
		local vec2 = Vector(words[4],words[5],words[6])
		draw.NoTexture()
		surface.SetDrawColor( 255, 0, 0, 255 )
		surface.DrawLine(vec1:ToScreen().x,vec1:ToScreen().y,vec2:ToScreen().x,vec2:ToScreen().y)
		end
	end )
end )