local bat = script.Parent -- Tool
local bmodel = bat.bmodel -- bat model
local remote = bat.Remote -- RemoteEvent
local swingcounter = bat.swingcounter -- Number Value to keep track of how long you've hold the "charge" button
local sounds = bat.Sounds -- A folder that contains all the sounds
local damage = 8 -- Normal Swing Damage
local damageq = 3 -- Fast Swings Damage
local mega = 70 -- Mega Attack Damage
local omae = true -- Change To False If You Want To Skip "Omae Wa Mou Shindeiru" (Would not recommend)
local fire = bmodel.pt5.Flame -- Fire (For 'F' move)
local EFX = bat.EFX -- Folder Named 'EFX'
local efx = EFX.NANI -- Red Light For Mega Attack
local debris = game:GetService("Debris") -- Debris (Used for deleting stuff without a lot of code)
local fatouched -- Touched Event for 'q'
tweenservice = game:GetService("TweenService")
local checkkey = true -- checkkey for 'q'
local keycheck = true -- checkkey for 'f'
local unequipped = false
local mstop = false

local PlayersHit = {} -- A Table for the players hit

-- Bat Parts (Specifically for Mega Bat)

local effects
local randomeffect
local hmes = bmodel.hnd.Mesh
local p1m = bmodel.pt1.Mesh
local p1w = p1m.Parent.Weld
local p3m = bmodel.pt3.Mesh
local p3w = p3m.Parent.Weld
local p4m = bmodel.pt4.Mesh
local p4w = p4m.Parent.Weld
local p5m = bmodel.pt5.Mesh
local p5w = p5m.Parent.Weld
local p6m = bmodel.pt6.Mesh
local p6w = p6m.Parent.Weld
local metouched
whoosh = sounds.Whoosh
cf = CFrame.new
ang = CFrame.Angles
rd = math.rad

--

function angularvelocity(x,y,z,torque,parent,attacktype,hitsound,linevel,hum) -- Function to deal spin and knockback
	
	coroutine.wrap(function() -- Don't delete this coroutine.wrap, it's so that other lines of code can run without being paused
		
		if attacktype == "sw" then

			for i, v in pairs(parent.Parent:GetDescendants()) do

				if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

					v.Massless = true

				end

			end

			local attach = Instance.new("Attachment") -- Attachment
			local angv = Instance.new("AngularVelocity") -- AngularVelocity, spins the target
			local linv = Instance.new("LinearVelocity") -- LinearVelocity, deals knockback

			attach.Parent = parent
			linv.Parent = parent

			linv.Attachment0 = attach
			linv.MaxForce = 1000
			linv.RelativeTo = Enum.ActuatorRelativeTo.World
			linv.VectorVelocity = linevel * 5

			angv.Parent = parent
			angv.Attachment0 = attach
			angv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			angv.MaxTorque = torque
			angv.AngularVelocity = Vector3.new(x,y,z)

			hitsound.Pitch = math.random(9,11) / 10
			hitsound:Play()

			wait(1)

			attach:Destroy()
			angv:Destroy()
			linv:Destroy()

			if parent and parent.Parent then

				for i, v in pairs(parent.Parent:GetDescendants()) do

					if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

						v.Massless = false

					end

				end

			end

		end

		if attacktype == "mg" then

			for i, v in pairs(parent.Parent:GetDescendants()) do

				if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

					v.Massless = true

				end

			end

			local attach = Instance.new("Attachment")
			local angv = Instance.new("AngularVelocity")
			local linv = Instance.new("LinearVelocity")

			attach.Parent = parent
			linv.Parent = parent

			linv.Attachment0 = attach
			linv.MaxForce = 100000
			linv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			linv.VectorVelocity = linevel * -250

			angv.Parent = parent
			angv.Attachment0 = attach
			angv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			angv.MaxTorque = torque
			angv.AngularVelocity = Vector3.new(x,y,z)

			hitsound:Play()

			wait(4)

			attach:Destroy()
			angv:Destroy()
			linv:Destroy()

			if parent and parent.Parent then
				
				for i, v in pairs(parent.Parent:GetDescendants()) do

					if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

						v.Massless = false

					end

				end
				
			end

		end

		if attacktype == "fastswings" then

			for i, v in pairs(parent.Parent:GetDescendants()) do

				if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

					v.Massless = true

				end

			end

			local attach = Instance.new("Attachment")
			local angv = Instance.new("AngularVelocity")
			local linv = Instance.new("LinearVelocity")

			attach.Parent = parent
			linv.Parent = parent

			linv.Attachment0 = attach
			linv.MaxForce = 100000
			linv.RelativeTo = Enum.ActuatorRelativeTo.World
			linv.VectorVelocity = linevel * 5

			angv.Parent = parent
			angv.Attachment0 = attach
			angv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			angv.MaxTorque = torque
			angv.AngularVelocity = Vector3.new(x,y,z)

			hitsound.Pitch = math.random(9,11)/10
			hitsound:Play()
			
			debris:AddItem(attach,.06)
			debris:AddItem(angv,.06)
			debris:AddItem(linv,.06)

			if parent and parent.Parent then

				for i, v in pairs(parent.Parent:GetDescendants()) do

					if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

						v.Massless = false

					end

				end

			end

		end
		
		if attacktype == "f" then
			
			for i, v in pairs(parent.Parent:GetDescendants()) do

				if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

					v.Massless = true

				end

			end

			local attach = Instance.new("Attachment")
			local angv = Instance.new("AngularVelocity")
			local linv = Instance.new("LinearVelocity")

			attach.Parent = parent
			linv.Parent = parent

			linv.Attachment0 = attach
			linv.MaxForce = 100000
			linv.RelativeTo = Enum.ActuatorRelativeTo.World
			linv.VectorVelocity = linevel

			angv.Parent = parent
			angv.Attachment0 = attach
			angv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			angv.MaxTorque = torque
			angv.AngularVelocity = Vector3.new(x,y,z)

			hitsound:Play()

			wait(1)
			
			hum.PlatformStand = false
			attach:Destroy()
			angv:Destroy()
			linv:Destroy()

			if parent and parent.Parent then

				for i, v in pairs(parent.Parent:GetDescendants()) do

					if v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "UnionOperation" then

						v.Massless = false

					end

				end

			end
			
		end
		
	end)()
	
end

function CheckHum(g)
	
	for i, v in pairs(PlayersHit) do
		
		if v == g then
			
			return true
			
		end
		
	end
	
	return false
	
end

function expand() -- Lots of lines of code here. Used to expand the bat for mega attack
	
	coroutine.wrap(function()
		
		efx.Parent = EFX
		efx.Enabled = false
		randomeffect.Parent = efx.SoundEffects

		local Tweeninfo = TweenInfo.new(.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0)
		local tweeninfo = TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

		-- Expand 2x

		local p1g1 = {

			Scale = Vector3.new(5,5,5)

		}
		local p3g1 = {

			Scale = Vector3.new(5,5,5)

		}
		local hndg1 = {

			Scale = Vector3.new(4,18,4)

		}
		local p4g1 = {

			Scale = Vector3.new(.05,.05,.05)

		}
		local p5g1 = {

			Scale = Vector3.new(43, 12.5, 12.5)

		}
		local p6g1 = {

			Scale = Vector3.new(13,13,13)

		}

		local p1ts1 = tweenservice:Create(p1m, Tweeninfo, p1g1):Play()
		local p3ts1 = tweenservice:Create(p3m, Tweeninfo, p3g1):Play()
		local hndts1 = tweenservice:Create(hmes, Tweeninfo, hndg1):Play()
		local p4ts1 = tweenservice:Create(p4m, Tweeninfo, p4g1):Play()
		local p5ts1 = tweenservice:Create(p5m, Tweeninfo, p5g1):Play()
		local p6ts1 = tweenservice:Create(p6m, Tweeninfo, p6g1):Play()

		p1w.C0 = cf(0,2,0)
		p3w.C0 = cf(0,-2,0, 1,0,0, 0,1,0 ,0,0,1)
		p4w.C0 = cf(0, 2.75, 1.09278474e-07, 1, 0, 0, 0, -1, 8.74227766e-08, 0, -8.74227766e-08, -1)
		p5w.C0 = cf(8.3, 1.75938339e-07, 0, -4.37113883e-08, -1, 0, 1, -4.37113883e-08, 0, 0, 0, 1)
		p6w.C0 = cf(0, -12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

		wait(.3)

		-- Expand 3x

		local p1g2 = {

			Scale = Vector3.new(10,10,10)

		}
		local p3g2 = {

			Scale = Vector3.new(10,10,10)

		}
		local hndg2 = {

			Scale = Vector3.new(8,36,8)

		}
		local p4g2 = {

			Scale = Vector3.new(.1,.1,.1)

		}
		local p5g2 = {

			Scale = Vector3.new(86, 25, 25)

		}
		local p6g2 = {

			Scale = Vector3.new(26,26,26)

		}

		local p1ts2 = tweenservice:Create(p1m, Tweeninfo, p1g2):Play()
		local p3ts2 = tweenservice:Create(p3m, Tweeninfo, p3g2):Play()
		local hndts2 = tweenservice:Create(hmes, Tweeninfo, hndg2):Play()
		local p4ts2 = tweenservice:Create(p4m, Tweeninfo, p4g2):Play()
		local p5ts2 = tweenservice:Create(p5m, Tweeninfo, p5g2):Play()
		local p6ts2 = tweenservice:Create(p6m, Tweeninfo, p6g2):Play()

		p1w.C0 = cf(0,4,0)
		p3w.C0 = cf(0,-4,0, 1,0,0, 0,1,0 ,0,0,1)
		p4w.C0 = cf(0, 5.5, 1.09278474e-07, 1, 0, 0, 0, -1, 8.74227766e-08, 0, -8.74227766e-08, -1)
		p5w.C0 = cf(16.6, 1.75938339e-07, 0, -4.37113883e-08, -1, 0, 1, -4.37113883e-08, 0, 0, 0, 1)
		p6w.C0 = cf(0, -24, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

		-- Expand 4x

		wait(.3)

		local p1g3 = {

			Scale = Vector3.new(20,20,20)

		}
		local p3g3 = {

			Scale = Vector3.new(20,20,20)

		}
		local hndg3 = {

			Scale = Vector3.new(16,72,16)

		}
		local p4g3 = {

			Scale = Vector3.new(.2,.2,.2)

		}
		local p5g3 = {

			Scale = Vector3.new(172, 50, 50)

		}
		local p6g3 = {

			Scale = Vector3.new(52,52,52)

		}

		local p1ts3 = tweenservice:Create(p1m, Tweeninfo, p1g3):Play()
		local p3ts3 = tweenservice:Create(p3m, Tweeninfo, p3g3):Play()
		local hndts3 = tweenservice:Create(hmes, Tweeninfo, hndg3):Play()
		local p4ts3 = tweenservice:Create(p4m, Tweeninfo, p4g3):Play()
		local p5ts3 = tweenservice:Create(p5m, Tweeninfo, p5g3):Play()
		local p6ts3 = tweenservice:Create(p6m, Tweeninfo, p6g3):Play() 

		p1w.C0 = cf(0,8,0)
		p3w.C0 = cf(0,-8,0, 1,0,0, 0,1,0 ,0,0,1)
		p4w.C0 = cf(0, 11, 1.09278474e-07, 1, 0, 0, 0, -1, 8.74227766e-08, 0, -8.74227766e-08, -1)
		p5w.C0 = cf(33.2, 1.75938339e-07, 0, -4.37113883e-08, -1, 0, 1, -4.37113883e-08, 0, 0, 0, 1)
		p6w.C0 = cf(0, -48, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		
		bmodel.Hitpart.Size = Vector3.new(10,60,10)
		bmodel.Hitpart.Weld.C0 = bmodel.Hitpart.Weld.C0 * cf(0,-30,0)

		delay(.2, function()

			whoosh:Play()

		end)

		-- Shrink

		wait(1)

		local p1g = {

			Scale = Vector3.new(2.5,2.5,2.5)

		}
		local p3g = {

			Scale = Vector3.new(2.5,2.5,2.5)

		}
		local hndg = {

			Scale = Vector3.new(2,9,2)

		}
		local p4g = {

			Scale = Vector3.new(.025,.025,.025)

		}
		local p5g = {

			Scale = Vector3.new(21.5,6.25,6.25)

		}
		local p6g = {

			Scale = Vector3.new(6.5,6.5,6.5)

		}

		local p1ts = tweenservice:Create(p1m, tweeninfo, p1g):Play()
		local p3ts = tweenservice:Create(p3m, tweeninfo, p3g):Play()
		local hndts = tweenservice:Create(hmes, tweeninfo, hndg):Play()
		local p4ts = tweenservice:Create(p4m, tweeninfo, p4g):Play()
		local p5ts = tweenservice:Create(p5m, tweeninfo, p5g):Play()
		local p6ts = tweenservice:Create(p6m, tweeninfo, p6g):Play()

		p1w.C0 = cf(0,1,0)
		p3w.C0 = cf(0,-1,0, 1,0,0, 0,1,0 ,0,0,1)
		p4w.C0 = cf(0, 1.25, 1.09278474e-07, 1, 0, 0, 0, -1, 8.74227766e-08, 0, -8.74227766e-08, -1)
		p5w.C0 = cf(4.0250001, 1.75938339e-07, 0, -4.37113883e-08, -1, 0, 1, -4.37113883e-08, 0, 0, 0, 1)
		p6w.C0 = cf(0, -6.05000019, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		
		bmodel.Hitpart.Size = Vector3.new(1.5,7.75,1.5)
		bmodel.Hitpart.Weld.C0 = bmodel.Hitpart.Weld.C0 * cf(0,30,0)
		
	end)()
	
end

bat.Equipped:Connect(function(mouse) -- Equipped Event
	
	unequipped = false
	
	bmodel.hnd.Weld.Part0 = bat.Parent:FindFirstChild("Right Arm") -- Welds Bat To Arm
		
	remote.OnServerEvent:Connect(function(plr, keypressed) -- Used to when the client fires a RemoteEvent to the Server

		if keypressed == "q" and bat.Enabled == true then -- Detects what key was pressed
				
			checkkey = true
			
			bat.Enabled = false -- Disables the bat so other attacks don't override

			while keypressed == "q" do
					
				sounds.Swing.Pitch = math.random(10,11) / 10
				sounds.Swing:Play()
				
				fatouched = bmodel.Hitpart.Touched:Connect(function(hit)
					
					local hum
						
					if hit.Parent:FindFirstChildOfClass("Humanoid") and checkkey ~= false and hit.Parent.ClassName == "Model" then

						hum = hit.Parent:FindFirstChildWhichIsA("Humanoid")
						
						local check = CheckHum(hum) -- Checks if the player has already been tagged
						
						if check == false then
							
							hum.PlatformStand = true
							hum:TakeDamage(damageq)
							sounds.Hit.Pitch = math.random(9,11)/10
							sounds.Hit:Play()
							angularvelocity(-100,0,0,100,hit.Parent.HumanoidRootPart,"fastswings",sounds.Hit,bat.Parent.HumanoidRootPart.CFrame.LookVector)

							table.insert(PlayersHit,hum) -- Adds the player to the table

							wait(.08)

							PlayersHit = {} -- Resets the table
							
							delay(3,function()
								
								if hum then
									
									hum.PlatformStand = false
									
								end
								
							end)
							
						end
							
					elseif hum == nil then
							
						return
						
					end

				end)
					
				if not checkkey then
						
					sounds.Swing:Stop()
					
					break
						
				end
					
				wait(.13)
					
			end
				
			wait(5)
				
			bat.Enabled = true

		end
			
		wait()
			
		if keypressed == "qs" then
				
			if fatouched then
				
				fatouched:Disconnect()
				
			end
			
			checkkey = false
				
		end
			
		wait()

		if keypressed == "e" and bat.Enabled == true and omae == true then

			bat.Enabled = false
				
			effects = efx.SoundEffects:GetChildren()
			randomeffect = effects[math.random(1, #effects)]
				
			sounds.Warn:Play()

			wait(1.5)
				
			randomeffect.Parent = sounds.NANI
			
			if unequipped == false and mstop == false then
				
				sounds.NANI:Play()
				
			end
			
			efx.Parent = bat.Parent:FindFirstChild("Right Arm")
			efx.Enabled = true

			wait(2.6)
				
			expand()	
			
			task.wait(1)
				
			metouched = bmodel.Hitpart.Touched:Connect(function(hit)

				if hit.Parent:FindFirstChildOfClass("Humanoid") and hit.Parent.ClassName == "Model" and unequipped == false and mstop == false then

					local hum = hit.Parent:FindFirstChildWhichIsA("Humanoid")
					
					local check = CheckHum(hum)
					
					if check == false then
						
						table.insert(PlayersHit,hum)
						hum.PlatformStand = true
						hum:TakeDamage(70)
						angularvelocity(0,0,100,100,hit.Parent.HumanoidRootPart,"mg",sounds.Hit,bat.Parent.Torso.CFrame.LookVector)
						
						wait(1)
						
						PlayersHit = {}
						
					end

				end

			end)
				
			delay(1, function()
					
				if metouched.Connected == true then
					
					metouched:Disconnect()
					
				end
					
			end)
				
			wait(8)

			bat.Enabled = true
			sounds.Hit.Pitch = 1
			
		elseif keypressed == "ms" then
			
			sounds.Noni:Play()
			sounds.NANI:Stop()
			efx.Parent = EFX
			efx.Enabled = false
			mstop = true
			delay(5,function()
				
				mstop = false
				
			end)

		elseif keypressed == "e" and bat.Enabled == true and omae == false then

			bat.Enabled = false

			sounds.Warn:Play()

			wait(2)

			sounds.Whoosh:Play()

			wait(6)

			bat.Enabled = true

		end
			
		wait()

		if keypressed == "f" and bat.Enabled == true then

			bat.Enabled = false
			keycheck = true

			while keycheck == true do

				swingcounter.Value = swingcounter.Value + 2

				if swingcounter.Value >= 200 then
					
					remote:FireClient(plr)

					break

				end

				if swingcounter.Value >= 45 then

					fire.Enabled = true

				elseif swingcounter.Value >= 75 then

					fire.Size = 8

				end

				wait(.1)

			end

		end
			
		if keypressed == "fs" then
			
			local val = swingcounter.Value
			local fireq = fire.Enabled
			
			swingcounter.Value = 0
			keycheck = false
			fire.Enabled = false
			fire.Size = 5
			
			local ran = math.random(1,5) -- Increase/Decrease the probability of landing a critical hit
				
			local hite = bmodel.Hitpart.Touched:Connect(function(hit)

				if hit and hit.Parent then

					if hit.Parent:FindFirstChildOfClass("Humanoid") then

						local hum = hit.Parent:FindFirstChildOfClass("Humanoid")

						local check = CheckHum(hum)

						if check == false then
							
							if fireq == true then
								
								coroutine.wrap(function()

									if ran == 1 then

										sounds.CriticalHit:Play()

										local sound = sounds.Whistle:Clone()
										sound.Parent = hit
										sound:Play()
										
										task.wait(4)

										local sound2 = sounds.Explosion:Clone()
										sound2.Parent = hit
										sound2:Play()

										local explosion = Instance.new("Explosion",hit)
										explosion.BlastRadius = 0
										explosion.Position = hit.Position

										hum.Health = 0

									end
									
								end)()
								
							end
							
							hum.PlatformStand = true
							angularvelocity(2,2,2,5,hit,"f",sounds.Hit,bat.Parent.Torso.CFrame.LookVector * 5 * (val/4),hum)
							table.insert(PlayersHit,hum)
							sounds.Hit.Pitch = math.random(9,11)/10
							sounds.Hit:Play()
							hum:TakeDamage(14 + val / 8)

						end

					end

				end

			end)

			delay(.8,function()

				hite:Disconnect()
				PlayersHit = {}

			end)
			
			wait(5)
			
			bat.Enabled = true
				
		end
			
		if keypressed == "sw" and bat.Enabled == true then
				
			local hum
			local angvel
			local attach
				
			bat.Enabled = false
				
			local swtouched = bmodel.Hitpart.Touched:Connect(function(hit)

				if hit.Parent:FindFirstChildOfClass("Humanoid") and hit.Parent.ClassName == "Model" then
						
					hum = hit.Parent:FindFirstChildWhichIsA("Humanoid")
					
					local check = CheckHum(hum)
					
					if check == false then
						
						table.insert(PlayersHit,hum)
						
						hum.PlatformStand = true
						hum:TakeDamage(8)
						angularvelocity(5,0,25,250,hit.Parent.PrimaryPart,"sw",sounds.Hit,bat.Parent.HumanoidRootPart.CFrame.LookVector)
						
						wait(.6)
						
						PlayersHit = {}
						
					end

				end

			end)
				
			delay(.5, function()
				
				if hum then
					
					hum.PlatformStand = false
					
				end
				
				swtouched:Disconnect()
				
			end)
				
				
			wait(1)
				
			bat.Enabled = true
				
		end
		
		wait()

	end)

end)

bat.Unequipped:Connect(function()
	
	unequipped = true
	
end)
