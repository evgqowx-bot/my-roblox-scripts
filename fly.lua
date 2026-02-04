local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
local btn = Instance.new("TextButton", main)
local speedInput = Instance.new("TextBox", main)

main.Size = UDim2.new(0, 160, 0, 110)
main.Position = UDim2.new(0.5, -80, 0.15, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Active = true
main.Draggable = true

btn.Size = UDim2.new(1, -10, 0, 40)
btn.Position = UDim2.new(0, 5, 0, 10)
btn.Text = "ВЗЛЕТ"
btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18

speedInput.Size = UDim2.new(1, -10, 0, 40)
speedInput.Position = UDim2.new(0, 5, 0, 60)
speedInput.Text = "25" -- Стандартная скорость
speedInput.PlaceholderText = "СКОРОСТЬ..."
speedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedInput.TextColor3 = Color3.fromRGB(0, 255, 150)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 16

local active = false
local currentSpeed = 25
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0, 1e6, 0)

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

local function toggleFly()
    local char = game.Players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if active then
            bv.Parent = hrp
            bv.Velocity = Vector3.new(0, currentSpeed, 0)
        else
            bv.Parent = nil
        end
    end
end

speedInput.FocusLost:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        currentSpeed = val
        if active then bv.Velocity = Vector3.new(0, currentSpeed, 0) end
    else
        speedInput.Text = tostring(currentSpeed)
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "СТОП" or "ВЗЛЕТ"
    btn.TextColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
    toggleFly()
end)

task.spawn(function()
    while task.wait(0.5) do
        applyShield()
        if active then toggleFly() end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    applyShield()
end)

applyShield()
