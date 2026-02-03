local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 120, 0, 40)
btn.Position = UDim2.new(0.5, -60, 0.2, 0)
btn.Text = "ПОДНЯТЬ"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.TextColor3 = Color3.new(1,1,1)
btn.Draggable = true

btn.MouseButton1Click:Connect(function()
    hrp.CFrame = hrp.CFrame * CFrame.new(0, 15, 0) 
end)

game.StarterGui:SetCore("SendNotification", {
	Title = "Режим прыжков";
	Text = "Нажимай кнопку, чтобы подлетать";
	Duration = 5;
})
