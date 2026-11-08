CreateClientConVar( "360SWAGSHOT", "false", false, false )

local Turn = nil

local function ThreeSixtyShot()
    timer.Simple(.01,Turn)
    timer.Simple(.02,Turn)
    timer.Simple(.03,Turn)
    timer.Simple(.04,Turn)
    timer.Simple(.05,Turn)
    timer.Simple(.06,Turn)
    timer.Simple(.07,Turn)
    timer.Simple(.08,Turn)
    timer.Simple(.09,Turn)
    timer.Simple(.1,Turn)
    timer.Simple(.11,Turn)
    timer.Simple(.12,Turn)
    timer.Simple(.13,Turn)
    timer.Simple(.14,Turn)
    timer.Simple(.15,Turn)
    timer.Simple(.16,Turn)
    timer.Simple(.17,Turn)
    timer.Simple(.18,Turn)
    timer.Simple(.19,Turn)
    timer.Simple(.2,Turn)
	timer.Simple(.21,Turn)
    timer.Simple(.22,Turn)
    timer.Simple(.23,Turn)
    timer.Simple(.24,Turn)
    timer.Simple(.25,Turn)
    timer.Simple(.25,function() RunConsoleCommand("+attack") end)
    timer.Simple(.30,function() RunConsoleCommand("-attack") end)
end

function Turn()
    LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles()+Angle(0,14.4,0))
end

local Status = 0
local SpinYaw = 0
local EyeAng = 0
local StartEyeAngYaw = 0

local function SpinShot()

if GetConVarString( "360SWAGSHOT" ) == "true" then

		if (LocalPlayer():KeyDown(IN_JUMP) && (LocalPlayer():KeyDown(IN_SPEED))) then
			if(Status == 0) then
				Status = 1
				EyeAng = LocalPlayer():EyeAngles()
				StartEyeAngYaw = LocalPlayer():EyeAngles().yaw
			end
		end
			
		if(Status == 1) then
			EyeAng.yaw = StartEyeAngYaw
			SpinYaw = math.Approach(SpinYaw, 360, 1000*FrameTime())
			EyeAng.yaw = SpinYaw + StartEyeAngYaw
			LocalPlayer():SetEyeAngles(EyeAng)
		
		end
		
		if(SpinYaw >= 360) then
			SpinYaw = 0
			Status = 0
			LocalPlayer():ConCommand("+attack")

			timer.Simple( 0.05, function()
				LocalPlayer():ConCommand("-attack")
			end)
		end
	end
end

hook.Add("Think", "360EPICNOSCOPEZ", SpinShot)

concommand.Add("360NOSCOPE",ThreeSixtyShot)