local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "ВЗЛЕТ (SAFE)"
btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 20
btn.Draggable = true

local isFlying = false
local speed = 0.8

local function getHRP()
    local char = game.Players.LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

game:GetService("RunService").RenderStepped:Connect(function()
    if isFlying then
        local hrp = getHRP()
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, speed, 0)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    btn.Text = isFlying and "СТОП" or "ВЗЛЕТ (SAFE)"
    btn.TextColor3 = isFlying and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
end)
