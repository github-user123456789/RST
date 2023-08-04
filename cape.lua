local Player = game.Players.LocalPlayer

if script.Parent:FindFirstChild("Cape") ~= nil then

	script.Parent.Cape:Destroy()

end

repeat

	wait()

until script.Parent:FindFirstChild("Torso")

local Torso = script.Parent:FindFirstChild("Torso")

local Cape = Instance.new("Part", Torso.Parent)
Cape.Name = "Cape"
Cape.Anchored = false
Cape.CanCollide = false
Cape.TopSurface = 0
Cape.BottomSurface = 0
Cape.BrickColor = BrickColor.new("Crimson")
Cape.Material = "Plastic"
Cape.formFactor = "Custom"
Cape.Size = Vector3.new(4, 0.25, 2)



local motor1 = Instance.new("Motor", Cape)
motor1.Part0 = Cape
motor1.Part1 = Torso

motor1.MaxVelocity = 1
motor1.C0 = CFrame.new(-2.14,-0.1,0)*CFrame.Angles(0,math.rad(0),-111)
motor1.C1 = CFrame.new(0,1,.45)*CFrame.Angles(0,math.rad(90),0)

local wave = false

repeat wait(1/44)

	local ang = 0.2
	local oldmag = Torso.Velocity.magnitude
	local mv = .1

	if wave then

		ang = ang + ((Torso.Velocity.magnitude/10) * .05) + 1
		wave = false

	else

		wave = false

	end

	ang = ang + math.min(Torso.Velocity.magnitude/30, 1)

	motor1.MaxVelocity = math.min((Torso.Velocity.magnitude/10), .04) + mv
	motor1.DesiredAngle = -ang

	if motor1.CurrentAngle < -.05 and motor1.DesiredAngle > -.05 then

		motor1.MaxVelocity = .04

	end

	repeat

		wait()

	until 
	motor1.CurrentAngle == motor1.DesiredAngle or math.abs(Torso.Velocity.magnitude - oldmag)  >= (Torso.Velocity.magnitude/10) + 1

	if Torso.Velocity.magnitude < .1 then

		wait(.1)

	end

until

not Cape or Cape.Parent ~= Torso.Parent

script:Destroy()
