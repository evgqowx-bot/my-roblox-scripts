local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)

btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.15, 0)
btn.Text = "ПЛАТФОРМА (OFF)"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
btn.Draggable = true

local active = false
local plat = Instance.new("Part")
plat.Size = Vector3.new(6, 1, 6)
plat.Transparency = 1
plat.Anchored = true
plat.Parent = nil

local function applyShield()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v ~= plat then
                if v.Name:match("Leg") or v.Name:match("Foot") then
                    v.CanTouch = true
                else
                    v.CanTouch = false
                end
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if active and hrp then
        plat.Parent = workspace
        plat.CFrame = hrp.CFrame + Vector3.new(0, -3.5, 0)
    else
        plat.Parent = nil
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "ПЛАТФОРМА (ON)" or "ПЛАТФОРМА (OFF)"
    btn.TextColor3 = active and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end)

task.spawn(function()
    while task.wait(1) do applyShield() end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(applyShield)
applyShield()
