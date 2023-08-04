local bat = script.Parent
local bmodel = bat:WaitForChild("bmodel")
local remote = bat:WaitForChild("Remote")
local uis = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Char = Player.Character
local Hum
local Animations = bat.Animations
local FaSw
local MeAt
local SwIn
local SwCh
local canfire = true
local equipped = false
local fcounter = false
local qpress = false
local canrelease = true
local mpress = false
local ctrlsclone
local sreached
local mreached
local mobileguii
deb = false

bat.Equipped:Connect(function(mouse)
	
	equipped = true
	
	Hum = bat.Parent:FindFirstChildWhichIsA("Humanoid")
	
	local keyup
	local ctrls = bat:WaitForChild("BatControls")
	local mobilegui = bat:WaitForChild("BatMobileGui")
	
	if uis.KeyboardEnabled == true then
		
		ctrlsclone = ctrls:Clone()
		ctrlsclone.Parent = Player.PlayerGui
		ctrlsclone.Enabled = true
		
	else
		
		mobileguii = mobilegui:Clone()
		mobileguii.Parent = Player.PlayerGui
		mobileguii.Enabled = true
		
		mobileguii.CAButton.MouseButton1Down:Connect(function()
			
			if bat.Enabled ~= false and equipped == true then
				
				qpress = true

				Hum.WalkSpeed = 0
				Hum.JumpPower = 0
				Hum.AutoRotate = false

				workspace.CurrentCamera.CameraSubject = Hum.Parent:WaitForChild("Head")
				FaSw = Hum:LoadAnimation(Animations.FastSwings)
				FaSw:Play(0,500,1)

				remote:FireServer("q")
				
			end
			
		end)
		
		mobileguii.CAButton.MouseButton1Up:Connect(function()
			
			workspace.CurrentCamera.CameraSubject = Hum

			if FaSw then

				FaSw:Stop()
				FaSw:Destroy()

			end

			remote:FireServer("qs")

			Hum.WalkSpeed = 16
			Hum.JumpPower = 50
			Hum.AutoRotate = true

			qpress = false
			
		end)
		
		mobileguii.MegaButton.MouseButton1Click:Connect(function()
			
			if bat.Enabled ~= false and equipped == true then
				
				mpress = true

				Hum.WalkSpeed = 0
				Hum.JumpPower = 0
				MeAt = Hum:LoadAnimation(Animations.MegaAttack)
				MeAt:Play()

				mreached = MeAt.KeyframeReached:Connect(function(keyfra)

					if keyfra == "Sound" then

						MeAt:AdjustSpeed(0)

						wait(3)

						mpress = false
						MeAt:AdjustSpeed(1)

					end

				end)
				
				delay(4,function()
					
					mreached:Disconnect()
					
				end)

				remote:FireServer("e")

				wait(7.75)

				Hum.WalkSpeed = 16
				Hum.JumpPower = 50
				
			end
			
		end)
		
		mobileguii.SwingButton.MouseButton1Down:Connect(function()
			
			if bat.Enabled ~= false and equipped == true  then

				canrelease = true
				SwCh = Hum:LoadAnimation(Animations.SwingCharge)
				SwCh:Play()
				SwCh:AdjustSpeed(.75)

				remote:FireServer("f")

				sreached = SwCh.KeyframeReached:Connect(function(keyfr)

					if keyfr == "Charge" then

						if fcounter == false then

							SwCh:AdjustSpeed(0)

						end

					end

				end)

			elseif bat.Enabled == false and equipped == true then

				canrelease = false

			end
			
		end)
		
		mobileguii.SwingButton.MouseButton1Up:Connect(function()
			
			if canrelease == true then

				if canfire == true then

					remote:FireServer("fs")

					if SwCh then

						fcounter = true
						SwCh:AdjustSpeed(1)
						SwCh.Ended:Wait()
						fcounter = false
						SwCh:Destroy()

					end
					
					if sreached then
						
						sreached:Disconnect()
						
					end

				else

					canfire = true

				end

			end
			
		end)
		
	end
	
	keyup = mouse.KeyUp:Connect(function(keyaaa)

		if keyaaa == "q" then

			workspace.CurrentCamera.CameraSubject = Hum
			
			if FaSw then
				
				FaSw:Stop()
				FaSw:Destroy()
				
			end

			remote:FireServer("qs")

			Hum.WalkSpeed = 16
			Hum.JumpPower = 50
			Hum.AutoRotate = true
			
			qpress = false

		end

		if keyaaa == "f" and canrelease == true then

			if canfire == true then
				
				remote:FireServer("fs")

				if SwCh then

					fcounter = true
					SwCh:AdjustSpeed(1)
					SwCh.Ended:Wait()
					fcounter = false
					SwCh:Destroy()

				end
				
				if sreached then
					
					sreached:Disconnect()
					
				end
				
			else
				
				canfire = true
				
			end

		end

	end)
	
	mouse.KeyDown:Connect(function(keyaa)
		
		if keyaa == "q" and bat.Enabled ~= false and equipped == true then
			
			qpress = true
			
			Hum.WalkSpeed = 0
			Hum.JumpPower = 0
			Hum.AutoRotate = false
			
			workspace.CurrentCamera.CameraSubject = Hum.Parent:WaitForChild("Head")
			FaSw = Hum:LoadAnimation(Animations.FastSwings)
			FaSw:Play(0,500,1)
			
			remote:FireServer("q")
			
		end
		
		if keyaa == "e" and bat.Enabled ~= false and equipped == true then
			
			mpress = true
			
			Hum.WalkSpeed = 0
			Hum.JumpPower = 0
			MeAt = Hum:LoadAnimation(Animations.MegaAttack)
			MeAt:Play()
			
			mreached = MeAt.KeyframeReached:Connect(function(keyfra)

				if keyfra == "Sound" then

					MeAt:AdjustSpeed(0)
					
					wait(3)
					
					mpress = false
					MeAt:AdjustSpeed(1)
					
				end

			end)
			
			delay(4,function()

				mreached:Disconnect()

			end)
			
			remote:FireServer("e")
			
			wait(7.75)
			
			Hum.WalkSpeed = 16
			Hum.JumpPower = 50
			
		end
		
		if keyaa == "f" and bat.Enabled ~= false and equipped == true  then
			
			canrelease = true
			SwCh = Hum:LoadAnimation(Animations.SwingCharge)
			SwCh:Play()
			SwCh:AdjustSpeed(.75)
			
			remote:FireServer("f")
			
			sreached = SwCh.KeyframeReached:Connect(function(keyfr)
				
				if keyfr == "Charge" then
					
					if fcounter == false then
						
						SwCh:AdjustSpeed(0)
						
					end
					
				end
				
			end)
			
		elseif keyaa == "f" and bat.Enabled == false and equipped == true then
			
			canrelease = false
			
		end
		
	end)
	
	remote.OnClientEvent:Connect(function()
		
		remote:FireServer("fs")
		canfire = false
		
		if SwCh then
			
			SwCh:AdjustSpeed(1)
			SwCh.Ended:Wait()
			SwCh:Destroy()
			
		end
		
	end)
	
	bat.Activated:Connect(function()
		
		if deb == false and bat.Enabled == true and equipped == true then
			
			deb = true
			
			workspace.CurrentCamera.CameraSubject = Hum.Parent:WaitForChild("Head")
			bat.Enabled = false
			Hum.AutoRotate = false
			Hum.WalkSpeed = 0
			Hum.JumpPower = 0
			SwIn = Hum:LoadAnimation(Animations.Swing)
			SwIn:Play(0,2,1)

			remote:FireServer("sw")

			wait(.7)
			workspace.CurrentCamera.CameraSubject = Hum
			Hum.WalkSpeed = 16
			Hum.JumpPower = 50
			Hum.AutoRotate = true
			deb = false
			
		end
		
	end)
	
end)

bat.Unequipped:Connect(function()
	
	equipped = false
	
	if ctrlsclone then
		
		ctrlsclone:Destroy()
		
	end
	
	if mobileguii then
		
		mobileguii:Destroy()
		
	end
	
	if SwIn then
		
		SwIn:Stop()
		SwIn:Destroy()
		
	end
	
	if SwCh then
		
		SwCh:Stop()
		SwCh:Destroy()
		
	end
	
	if FaSw then
		
		FaSw:Stop()
		FaSw:Destroy()
		
		if qpress == true then
			
			qpress = false
			remote:FireServer("qs")
			Hum.WalkSpeed = 16
			Hum.JumpPower = 50
			Hum.AutoRotate = true
			workspace.CurrentCamera.CameraSubject = Hum
			
		end
		
	end
	
	if MeAt then
		
		MeAt:Stop()
		MeAt:Destroy()
		
		if mpress == true then
			
			mpress = false
			
			Hum.WalkSpeed = 16
			Hum.JumpPower = 50
			Hum.AutoRotate = true
			workspace.CurrentCamera.CameraSubject = Hum
			
			remote:FireServer("ms")
			
		end
		
		if mreached then
			
			mreached:Disconnect()
			
		end
		
	end
	
end)
