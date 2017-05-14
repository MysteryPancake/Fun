CreateClientConVar( "secondperson", "0", true, false )
local enabled = GetConVar( "secondperson" )

hook.Add( "CalcView", "SecondPersonView", function( ply, pos, ang, fov )
  if ply:GetViewEntity() ~= ply or !enabled:GetBool() then return end
  local eyes = ply:GetAttachment( ply:LookupAttachment( "eyes" ) )
  return { origin = eyes.Pos, angles = ang, fov = fov, drawviewer = true }
end )
