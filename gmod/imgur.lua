local data = render.Capture( {
	format = "jpeg",
	quality = 100,
	x = 0,
	y = 0,
	w = ScrW(),
	h = ScrH()
} )

http.Post( "https://api.imgur.com/3/image", {
	image = util.Base64Encode( data )
}, function( response )
	print( response )
	gui.OpenURL( util.JSONToTable( response ).data.link )
end, function( failed )
	print( failed )
end, {
	Authorization = "Client-ID <CLIENT_ID>"
} )
