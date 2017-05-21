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
	return str:gsub( "^%l", string.upper )
end

local function AddText( parent, bLarge, text )
	local t = vgui.Create( "DLabel", parent )
	t:SetFont( bLarge and "EssayLarge" or "EssayDefault" )
	t:SetDark( true )
	t:SetText( text )
	t:Dock( TOP )
	t:SetWrap( true )
	t:SetAutoStretchVertical( true )
	t:DockMargin( 0, 5, 5, 5 )
end

local function DoEssay( txt )

	local main = vgui.Create( "DFrame" )
	main:SetTitle( "An essay on " .. txt )
	main:SetSize( ScrW() / 2, ScrH() - 50 )
	main:SetSizable( true )
	main:Center()
	main:MakePopup()
	function main:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 0, 255 ) )
	end
	
	local bg = vgui.Create( "DPanel", main )
	bg:Dock( FILL )
	function bg:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
	end
	
	local scroll = vgui.Create( "DScrollPanel", bg )
	scroll:Dock( FILL )
	scroll:DockMargin( 20, 20, 20, 20 )
	
	if math.random( 2 ) == 1 then
		AddText( scroll, false, "Despite what many might think, " .. txt .. " is well known across hundreds of nations all over the world. " .. CapitalizeFirst( txt ) .. " has been around for several centuries and has a very important meaning in the lives of many. It would be safe to assume that " .. txt .. " is going to be around for a long time and have an enormous impact on the lives of many people." )
	else
		AddText( scroll, false, "It has recently come to my attention that not enough people understand how great " .. txt .. " has been to our lives. Each day we wake up and likely have one or more " .. txt .. " lying at the foot of our beds. It is wonderful to be able to wake up and smile each morning because of this." )
	end
	AddText( scroll, true, "Social and Cultural Factors" )
	AddText( scroll, false, CapitalizeFirst( txt ) .. " has a large role in American Culture. Many people can often be seen taking part in activities associated with " .. txt .. ". This is partly because people of most ages can be involved and families are brought together by this. Generally a person who displays their dislike for " .. txt .. " may be considered an outcast." )
	AddText( scroll, true, "Economic Factors" )
	AddText( scroll, false, "It is not common practice to associate economics with " .. txt .. ". Generally, " .. txt .. " would be thought to have no effect on our economic situation, but there are in fact some effects. The sales industry associated with " .. txt .. " is actually a 2.3 billion dollar a year industry and growing each year. The industry employs nearly 150,000 people in the United States alone. It would be safe to say that " .. txt .. " play an important role in American economics and shouldn't be taken for granted." )
	AddText( scroll, true, "Environmental Factors" )
	AddText( scroll, false, "After a three month long research project, I've been able to conclude that " .. txt .. " doesn't negatively effect the environment at all. A " .. txt .. " did not seem to result in waste products and couldn't be found in forests, jungles, rivers, lakes, oceans, etc... In fact, " .. txt .. " produced some positive effects on our sweet little nature." )
	AddText( scroll, true, "Political Factors" )
	AddText( scroll, false, "Oh does " .. txt .. " ever influence politics. Last year 5 candidates running for some sort of position used " .. txt .. " as the primary topic of their campaign. A person might think " .. txt .. " would be a bad topic to lead a campaign with, but in fact with the social and environmental impact is has, this topic was able to gain a great number of followers. These 5 candidates went 4 for 5 on winning their positions." )
	AddText( scroll, true, "Conclusion" )
	AddText( scroll, false, CapitalizeFirst( txt ) .. " seem to be a much more important idea that most give credit for. Next time you see or think of " .. txt .. ", think about what you just read and realize what is really going on. It is likely you under valued " .. txt .. " before, but will now start to give the credited needed and deserved." )
	AddText( scroll, true, "Footnotes" )
	AddText( scroll, false, CapitalizeFirst( txt ) .. " researched in wikipedia. " .. CapitalizeFirst( txt ) .. " @ dictionary.com" )
	
end

concommand.Add( "MakeEssay", function()
	Derma_StringRequest( "Create An Essay Instantly", "Submit an essay topic below to automatically create your essay", "", DoEssay, function() end, "Submit", "Cancel" )
end )
