local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Создаем GUI
local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 120, 0, 40)
btn.Position = UDim2.new(0.5, -60, 0.2, 0)
btn.Text = "ВЗЛЕТ (SAFE)"
btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btn.TextColor3 = Color3.new(1,1,1)
btn.Draggable = true

local isFlying = false
local speed = 1.5 -- Маленькая скорость, чтобы античит не спалил

game:GetService("RunService").RenderStepped:Connect(function()
    if isFlying then
        -- Вместо силы (velocity) мы плавно меняем позицию
        hrp.CFrame = hrp.CFrame + Vector3.new(0, speed, 0)
        -- Обнуляем скорость падения, чтобы античит не думал, что мы падаем
        hrp.Velocity = Vector3.new(0, 0.1, 0) 
    end
end)

btn.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    btn.Text = isFlying and "СТОП" or "ВЗЛЕТ (SAFE)"
    btn.BackgroundColor3 = isFlying and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(50, 50, 50)
end)
