CreateClientConVar( "secondperson", "1", true, false )
CreateClientConVar( "secondperson_pos", "1", true, false )
CreateClientConVar( "secondperson_ang", "0", true, false )
local enabled = GetConVar( "secondperson" )
local usepos = GetConVar( "secondperson_pos" )
local useang = GetConVar( "secondperson_ang" )

hook.Add( "CalcView", "SecondPersonView", function( ply, pos, ang, fov )
  if ply:GetViewEntity() ~= ply or !enabled:GetBool() then return end
  local eyes = ply:GetAttachment( ply:LookupAttachment( "eyes" ) )
  return { origin = usepos:GetBool() and eyes.Pos or pos, angles = useang:GetBool() and eyes.Ang or ang, fov = fov, drawviewer = true }
end )

hook.Add( "PopulateToolMenu", "SecondPersonSettings", function()
  spawnmenu.AddToolMenuOption( "Options", "View", "Second_Person_Options", "Second Person", "", "", function( panel )
    panel:ClearControls()
    panel:CheckBox( "Enabled", "secondperson" )
    panel:CheckBox( "Use eye position", "secondperson_pos" )
    panel:CheckBox( "Use eye angles", "secondperson_ang" )
  end )
end )
