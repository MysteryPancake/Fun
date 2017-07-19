local sparks = {}
local speed = 1
local removeSize = 1
local posShakiness, colorShakiness = 0.1, 150
local minParticles, maxParticles = 2, 5
local sizeDecay, colorDecay = 1.01, 4
local minSize, maxSize = 5, 50
local bounceOffEdges = true

local function createSparks( pos )
	for i = 1, math.random( minParticles, maxParticles ) do
		table.insert( sparks, {
			pos = pos,
			vel = Vector( math.Rand( -speed, speed ), math.Rand( -speed, speed ) ),
			size = math.Rand( minSize, maxSize ),
			col = Color( 255, 255, 0 )
		} )
	end
end

local function drawSparks( w, h )

	for k, sp in ipairs( sparks ) do

		sp.vel = sp.vel + Vector( math.Rand( -posShakiness, posShakiness ), math.Rand( -posShakiness, posShakiness ) )
		sp.col.g = sp.col.g - math.random() * colorDecay
		sp.pos = sp.pos + sp.vel

		sp.size = sp.size / sizeDecay
		if sp.size < removeSize then
			table.remove( sparks, k )
		end

		if bounceOffEdges then
			if sp.pos.x <= 0 or sp.pos.x >= w then sp.vel.x = -sp.vel.x end
			if sp.pos.y <= 0 or sp.pos.y >= h then sp.vel.x = -sp.vel.y end
		end

		local rand = math.random() * colorShakiness
		surface.SetDrawColor( sp.col.r + rand, sp.col.g + rand, sp.col.b + rand )
		surface.DrawRect( sp.pos.x - sp.size / 2, sp.pos.y - sp.size / 2, sp.size, sp.size )

	end

end

concommand.Add( "SparkTest", function()

	local frame = vgui.Create( "DFrame" )
	frame:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
	frame:SetTitle( "Sparks" )
	frame:Center()
	frame:MakePopup()

	local panel = vgui.Create( "Panel", frame )
	panel:Dock( FILL )
	function panel:OnMousePressed() self.Depressed = true end
	function panel:OnMouseReleased() self.Depressed = false end
	function panel:Paint( w, h )
		if self.Depressed then createSparks( Vector( self:CursorPos() ) ) end
		surface.SetDrawColor( 0, 0, 0 )
		surface.DrawRect( 0, 0, w, h )
		drawSparks( w, h )
	end

end )
