local sparks = {}
local speed = 0.1
local removeSize = 1
local posShakiness, colorShakiness = 0.02, 150
local minParticles, maxParticles = 50, 200
local sizeDecay, colorDecay = 1.01, 4
local minSize, maxSize = 5, 10
local mat = Material( "sprites/light_glow02_add_noz" )

local function CreateSparks( pos )
	for i = 1, math.random( minParticles, maxParticles ) do
		table.insert( sparks, {
			pos = pos,
			vel = Vector( math.Rand( -speed, speed ), math.Rand( -speed, speed ), math.Rand( -speed, speed ) ),
			size = math.Rand( minSize, maxSize ),
			col = Color( 255, 255, 0 )
		} )
	end
end

hook.Add( "HUDPaint", "SparkTest", function()

	cam.Start3D()
	
		for k, sp in ipairs( sparks ) do

			sp.vel = sp.vel + Vector( math.Rand( -posShakiness, posShakiness ), math.Rand( -posShakiness, posShakiness ), math.Rand( -posShakiness, posShakiness ) )
			sp.col.g = sp.col.g - math.random() * colorDecay
			sp.pos = sp.pos + sp.vel

			sp.size = sp.size / sizeDecay
			if sp.size < removeSize then
				table.remove( sparks, k )
			end

			local rand = math.random() * colorShakiness
			render.SetMaterial( mat )
			render.DrawSprite( sp.pos, sp.size, sp.size, Color( sp.col.r + rand, sp.col.g + rand, sp.col.b + rand ) )

		end
	
	cam.End3D()
	
end )

concommand.Add( "SparkTest", function()
	CreateSparks( LocalPlayer():GetEyeTrace().HitPos )
end )
