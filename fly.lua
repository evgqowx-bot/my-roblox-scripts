local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
local btn = Instance.new("TextButton", main)
local speedInput = Instance.new("TextBox", main)

main.Size = UDim2.new(0, 160, 0, 110)
main.Position = UDim2.new(0.5, -80, 0.15, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Active = true
main.Draggable = true

btn.Size = UDim2.new(1, -10, 0, 40)
btn.Position = UDim2.new(0, 5, 0, 10)
btn.Text = "ВЗЛЕТ (ANTICHIT)"
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 16

speedInput.Size = UDim2.new(1, -10, 0, 40)
speedInput.Position = UDim2.new(0, 5, 0, 60)
speedInput.Text = "0.5"
speedInput.PlaceholderText = "СКОРОСТЬ (0.1 - 1)"
speedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedInput.TextColor3 = Color3.fromRGB(0, 255, 150)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 16

local active = false
local upSpeed = 0.5

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

game:GetService("RunService").Heartbeat:Connect(function()
    if active then
        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hrp and hum then
            -- Метод микро-импульсов (имитация прыжка)
            hrp.CFrame = hrp.CFrame + Vector3.new(0, upSpeed, 0)
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 2, hrp.Velocity.Z)
            
            if tick() % 2 < 0.1 then
                hum:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end
    end
end)

speedInput.FocusLost:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        upSpeed = val
    else
        speedInput.Text = tostring(upSpeed)
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "РАБОТАЕТ" or "ВЗЛЕТ (ANTICHIT)"
    btn.TextColor3 = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end)

task.spawn(function()
    while task.wait(1) do applyShield() end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(applyShield)
applyShield()
