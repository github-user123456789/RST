local punch = script.Parent
local hitpart = punch.HitPart
local anim = punch:WaitForChild("Animations")
local remote = punch:WaitForChild("Remote")
local char = game.Players.LocalPlayer.Character
local lhum = char:FindFirstChildOfClass("Humanoid")
local loadswing = lhum:LoadAnimation(anim:WaitForChild("Swing1"))
local loadidle = lhum:LoadAnimation(anim:WaitForChild("Idle"))
local sound = punch:WaitForChild("SwingSound")
local equipped = false

punch.Equipped:Connect(function(mouse)

	equipped = true
	loadidle:Play()

	punch.Unequipped:Connect(function()

		equipped = false

		if loadswing then

			loadswing:Stop()

		end

		loadidle:Stop()

	end)

end)

punch.Activated:Connect(function()

	if punch.Enabled == true and equipped == true then

		loadswing:Play()
		local invoke = remote:InvokeServer("Swing")

		if invoke == true then

			loadswing.KeyframeReached:Connect(function(name)

				if name == "Sound" then

					sound:FireServer()

				end

			end)

		end

	end

end)
