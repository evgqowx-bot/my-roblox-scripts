local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "ПРЫЖКИ (SAFE)"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
btn.Draggable = true

local active = false
local UIS = game:GetService("UserInputService")

local function applyShield()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                if v.Name:match("Leg") or v.Name:match("Foot") then
                    v.CanTouch = true
                else
                    v.CanTouch = false
                end
            end
        end
    end
end

UIS.JumpRequest:Connect(function()
    if active then
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        applyShield()
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "ВКЛЮЧЕНО" or "ПРЫЖКИ (SAFE)"
    btn.TextColor3 = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(applyShield)
applyShield()
