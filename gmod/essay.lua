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

local function CapitalizeFirst( str )
	return string.gsub( str, "^%l", string.upper )
end

local function AddText( parent, large, str )
	local label = vgui.Create( "DLabel", parent )
	label:SetFont( large and "EssayLarge" or "EssayDefault" )
	label:SetDark( true )
	label:SetText( str )
	label:Dock( TOP )
	label:SetWrap( true )
	label:SetAutoStretchVertical( true )
	label:DockMargin( 0, 5, 5, 5 )
end

local function MakeEssay( str )

	local main = vgui.Create( "DFrame" )
	main:SetTitle( "An essay on " .. str )
	main:SetSize( ScrW() * 0.5, ScrH() * 0.9 )
	main:SetSizable( true )
	main:Center()
	main:MakePopup()
	
	local back = vgui.Create( "Panel", main )
	back:Dock( FILL )
	function back:Paint( w, h )
		surface.SetDrawColor( 255, 255, 255 )
		surface.DrawRect( 0, 0, w, h )
	end
	
	local scroll = vgui.Create( "DScrollPanel", back )
	scroll:Dock( FILL )
	scroll:DockMargin( 10, 10, 10, 10 )
	if math.random() >= 0.5 then
		AddText( scroll, false, "Despite what many might think, " .. str .. " is well known across hundreds of nations all over the world. " .. CapitalizeFirst( str ) .. " has been around for several centuries and has a very important meaning in the lives of many. It would be safe to assume that " .. str .. " is going to be around for a long time and have an enormous impact on the lives of many people." )
	else
		AddText( scroll, false, "It has recently come to my attention that not enough people understand how great " .. str .. " has been to our lives. Each day we wake up and likely have one or more " .. str .. " lying at the foot of our beds. It is wonderful to be able to wake up and smile each morning because of this." )
	end
	AddText( scroll, true, "Social and Cultural Factors" )
	AddText( scroll, false, CapitalizeFirst( str ) .. " has a large role in American Culture. Many people can often be seen taking part in activities associated with " .. str .. ". This is partly because people of most ages can be involved and families are brought together by this. Generally a person who displays their dislike for " .. str .. " may be considered an outcast." )
	AddText( scroll, true, "Economic Factors" )
	AddText( scroll, false, "It is not common practice to associate economics with " .. str .. ". Generally, " .. str .. " would be thought to have no effect on our economic situation, but there are in fact some effects. The sales industry associated with " .. str .. " is actually a 2.3 billion dollar a year industry and growing each year. The industry employs nearly 150,000 people in the United States alone. It would be safe to say that " .. str .. " play an important role in American economics and shouldn't be taken for granted." )
	AddText( scroll, true, "Environmental Factors" )
	AddText( scroll, false, "After a three month long research project, I've been able to conclude that " .. str .. " doesn't negatively effect the environment at all. A " .. str .. " did not seem to result in waste products and couldn't be found in forests, jungles, rivers, lakes, oceans, etc... In fact, " .. str .. " produced some positive effects on our sweet little nature." )
	AddText( scroll, true, "Political Factors" )
	AddText( scroll, false, "Oh does " .. str .. " ever influence politics. Last year 5 candidates running for some sort of position used " .. str .. " as the primary topic of their campaign. A person might think " .. str .. " would be a bad topic to lead a campaign with, but in fact with the social and environmental impact is has, this topic was able to gain a great number of followers. These 5 candidates went 4 for 5 on winning their positions." )
	AddText( scroll, true, "Conclusion" )
	AddText( scroll, false, CapitalizeFirst( str ) .. " seem to be a much more important idea that most give credit for. Next time you see or think of " .. str .. ", think about what you just read and realize what is really going on. It is likely you under valued " .. str .. " before, but will now start to give the credited needed and deserved." )
	AddText( scroll, true, "Footnotes" )
	AddText( scroll, false, CapitalizeFirst( str ) .. " researched in wikipedia. " .. CapitalizeFirst( str ) .. " @ dictionary.com" )
	
end

concommand.Add( "MakeEssay", function()
	Derma_StringRequest( "Create An Essay Instantly", "Submit an essay topic below to automatically create your essay", "", MakeEssay, function() end, "Submit", "Cancel" )
end )
