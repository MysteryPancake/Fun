local frame = vgui.Create( "DFrame" )
frame:SetTitle( "Mission" )
frame:SetSize( 500, 400 )
frame:MakePopup()
frame:Center()

function frame:PerformLayout()

	self.btnClose:SetPos( self:GetWide() - 31 - 4, 0 )
	self.btnClose:SetSize( 31, 24 )

	self.btnMaxim:SetPos( self:GetWide() - 31 * 2 - 4, 0 )
	self.btnMaxim:SetSize( 31, 24 )

	self.btnMinim:SetPos( self:GetWide() - 31 * 3 - 4, 0 )
	self.btnMinim:SetSize( 31, 24 )

	self.lblTitle:SetPos( self:GetWide() * 0.5, 2 )
	self.lblTitle:SetSize( self:GetWide(), 20 )

end
