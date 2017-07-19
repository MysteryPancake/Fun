-- This is a replica of the now deceased site LongEssays.com. It shall be missed.

surface.CreateFont( "EssayDefault", {
	font = "Times New Roman",
	size = 18,
	weight = 500,
	extended = true,
	antialias = false
} )

surface.CreateFont( "EssayLarge", {
	font = "Times New Roman",
	size = 20,
	weight = 800,
	extended = true,
	antialias = false
} )

local function capitalizeFirst( str )
	return str:gsub( "^%l", string.upper )
end

local function addText( parent, large, str )
	local label = vgui.Create( "DLabel", parent )
	label:SetFont( large and "EssayLarge" or "EssayDefault" )
	label:SetDark( true )
	label:SetText( str )
	label:Dock( TOP )
	label:SetWrap( true )
	label:SetAutoStretchVertical( true )
	label:DockMargin( 0, 5, 5, 5 )
end

local function makeEssay( str )

	local main = vgui.Create( "DFrame" )
	main:SetTitle( "An essay on " .. str )
	main:SetSize( ScrW() * 0.5, ScrH() * 0.9 )
	main:SetSizable( true )
	main:Center()
	main:MakePopup()
	
	local back = vgui.Create( "Panel", main )
	back:Dock( FILL )
	function back:Paint( w, h )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawRect( 0, 0, w, h )
	end
	
	local scroll = vgui.Create( "DScrollPanel", back )
	scroll:Dock( FILL )
	scroll:DockMargin( 10, 10, 10, 10 )
	if math.random() > 0.5 then
		addText( scroll, false, "Despite what many might think, " .. str .. " is well known across hundreds of nations all over the world. " .. capitalizeFirst( str ) .. " has been around for several centuries and has a very important meaning in the lives of many. It would be safe to assume that " .. str .. " is going to be around for a long time and have an enormous impact on the lives of many people." )
	else
		addText( scroll, false, "It has recently come to my attention that not enough people understand how great " .. str .. " has been to our lives. Each day we wake up and likely have one or more " .. str .. " lying at the foot of our beds. It is wonderful to be able to wake up and smile each morning because of this." )
	end
	addText( scroll, true, "Social and Cultural Factors" )
	addText( scroll, false, capitalizeFirst( str ) .. " has a large role in American Culture. Many people can often be seen taking part in activities associated with " .. str .. ". This is partly because people of most ages can be involved and families are brought together by this. Generally a person who displays their dislike for " .. str .. " may be considered an outcast." )
	addText( scroll, true, "Economic Factors" )
	addText( scroll, false, "It is not common practice to associate economics with " .. str .. ". Generally, " .. str .. " would be thought to have no effect on our economic situation, but there are in fact some effects. The sales industry associated with " .. str .. " is actually a 2.3 billion dollar a year industry and growing each year. The industry employs nearly 150,000 people in the United States alone. It would be safe to say that " .. str .. " play an important role in American economics and shouldn't be taken for granted." )
	addText( scroll, true, "Environmental Factors" )
	addText( scroll, false, "After a three month long research project, I've been able to conclude that " .. str .. " doesn't negatively effect the environment at all. A " .. str .. " did not seem to result in waste products and couldn't be found in forests, jungles, rivers, lakes, oceans, etc... In fact, " .. str .. " produced some positive effects on our sweet little nature." )
	addText( scroll, true, "Political Factors" )
	addText( scroll, false, "Oh does " .. str .. " ever influence politics. Last year 5 candidates running for some sort of position used " .. str .. " as the primary topic of their campaign. A person might think " .. str .. " would be a bad topic to lead a campaign with, but in fact with the social and environmental impact is has, this topic was able to gain a great number of followers. These 5 candidates went 4 for 5 on winning their positions." )
	addText( scroll, true, "Conclusion" )
	addText( scroll, false, capitalizeFirst( str ) .. " seem to be a much more important idea that most give credit for. Next time you see or think of " .. str .. ", think about what you just read and realize what is really going on. It is likely you under valued " .. str .. " before, but will now start to give the credited needed and deserved." )
	addText( scroll, true, "Footnotes" )
	addText( scroll, false, capitalizeFirst( str ) .. " researched in wikipedia. " .. capitalizeFirst( str ) .. " @ dictionary.com" )
	
end

concommand.Add( "MakeEssay", function()
	Derma_StringRequest( "Create An Essay Instantly", "Submit an essay topic below to automatically create your essay", "", makeEssay, function() end, "Submit", "Cancel" )
end )
