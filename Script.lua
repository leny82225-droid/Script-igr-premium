-- Owner: Bruk Ontop
-- Executed via Delta / Mobile Executor

-- Auto Run Infinite Yield di Background
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Clean Up Old UI
if LocalPlayer.PlayerGui:FindFirstChild("BrukOntop_Hub") then
    LocalPlayer.PlayerGui["BrukOntop_Hub"]:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrukOntop_Hub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main Window (Tema H42 Hub)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 230)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner Radius Window
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Top Bar Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "BRUK ONTOP 1.0.0 (BETA) | By: Bruk Ontop"
Title.TextColor3 = Color3.fromRGB(220, 225, 240)
Title.Position = UDim2.new(0.34, 0, 0.04, 0)
Title.Size = UDim2.new(0.62, 0, 0.12, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Sidebar Panel (Kiri)
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Size = UDim2.new(0, 125, 1, 0)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Tab Category Button
local TabMaxgen = Instance.new("TextButton")
TabMaxgen.Parent = Sidebar
TabMaxgen.Text = "Auto Farm Maxgen"
TabMaxgen.BackgroundColor3 = Color3.fromRGB(45, 65, 160)
TabMaxgen.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMaxgen.Position = UDim2.new(0.06, 0, 0.08, 0)
TabMaxgen.Size = UDim2.new(0.88, 0, 0.18, 0)
TabMaxgen.Font = Enum.Font.SourceSansBold
TabMaxgen.TextSize = 11

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabMaxgen

-- Content Container (Kanan)
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0.34, 0, 0.2, 0)
Content.Size = UDim2.new(0.63, 0, 0.75, 0)

-- Content Header Text
local SectionText = Instance.new("TextLabel")
SectionText.Parent = Content
SectionText.Text = "— PREMIUM PLAYER —"
SectionText.TextColor3 = Color3.fromRGB(235, 180, 50)
SectionText.Size = UDim2.new(1, 0, 0, 20)
SectionText.Font = Enum.Font.SourceSansBold
SectionText.TextSize = 12

-- Toggle Button (Otomatis Farm)
local BtnAuto = Instance.new("TextButton")
BtnAuto.Parent = Content
BtnAuto.Text = "Otomatis Farm Maxgen : OFF"
BtnAuto.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
BtnAuto.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnAuto.Position = UDim2.new(0, 0, 0.25, 0)
BtnAuto.Size = UDim2.new(1, 0, 0, 32)
BtnAuto.Font = Enum.Font.SourceSansBold
BtnAuto.TextSize = 12

local BtnAutoCorner = Instance.new("UICorner")
BtnAutoCorner.CornerRadius = UDim.new(0, 6)
BtnAutoCorner.Parent = BtnAuto

-- Teleport Button (TP Manual)
local BtnTP = Instance.new("TextButton")
BtnTP.Parent = Content
BtnTP.Text = "TP ke Lokasi Maxgen"
BtnTP.BackgroundColor3 = Color3.fromRGB(35, 40, 58)
BtnTP.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnTP.Position = UDim2.new(0, 0, 0.55, 0)
BtnTP.Size = UDim2.new(1, 0, 0, 32)
BtnTP.Font = Enum.Font.SourceSansBold
BtnTP.TextSize = 12

local BtnTPCorner = Instance.new("UICorner")
BtnTPCorner.CornerRadius = UDim.new(0, 6)
BtnTPCorner.Parent = BtnTP

---------------------------------------------------------
-- LOGIC SYSTEM
---------------------------------------------------------

local isRunning = false

-- Safe Noclip khusus karakter
local function applyNoclip(char)
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Fungsi Jalan Halus (Tween)
local function tweenTo(targetCFrame, speed)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    
    applyNoclip(char)
    
    local distance = (root.Position - targetCFrame.Position).Magnitude
    local duration = distance / (speed or 40)
    
    local tween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait()
end

-- Cari Lokasi Tanda Kuning (DeliveryBeam / DummyTarget / BedilPusat)
local function findJobTarget()
    local beam = Workspace:FindFirstChild("DeliveryBeam", true)[span_0](start_span)[span_0](end_span)[span_1](start_span)[span_1](end_span)[span_2](start_span)[span_2](end_span)
    if beam and beam:IsA("Beam") and beam.Attachment1 then
        return beam.Attachment1.WorldPosition
    end

    for _, obj in pairs(Workspace:GetChildren()) do
        if string.find(obj.Name, "DummyTarget") and obj:IsA("BasePart") then[span_3](start_span)[span_3](end_span)[span_4](start_span)[span_4](end_span)[span_5](start_span)[span_5](end_span)[span_6](start_span)[span_6](end_span)
            return obj.Position
        end
    end

    local ekonomi = Workspace:FindFirstChild("Ekonomi")[span_7](start_span)[span_7](end_span)[span_8](start_span)[span_8](end_span)[span_9](start_span)[span_9](end_span)
    if ekonomi then
        local bedil = ekonomi:FindFirstChild("BedilPusat")[span_10](start_span)[span_10](end_span)[span_11](start_span)[span_11](end_span)
        if bedil and bedil:FindFirstChild("DeliveryTargets") then[span_12](start_span)[span_12](end_span)
            local targets = bedil.DeliveryTargets:GetChildren()[span_13](start_span)[span_13](end_span)
            if #targets > 0 then
                return targets[1].Position
            end
        end
    end

    return nil
end

-- Teleport Manual ke Target
BtnTP.MouseButton1Click:Connect(function()
    local targetPos = findJobTarget()
    if targetPos then
        tweenTo(CFrame.new(targetPos + Vector3.new(0, 3, 0)), 60)
    end
end)

-- Loop Farm Otomatis
local function startTikTokAutoJob()
    task.spawn(function()
        while isRunning do
            local targetPos = findJobTarget()
            
            if targetPos then
                tweenTo(CFrame.new(targetPos + Vector3.new(0, 3, 0)), 40)
                task.wait(math.random(15, 25) / 10)
            else
                local ekonomi = Workspace:FindFirstChild("Ekonomi")[span_14](start_span)[span_14](end_span)[span_15](start_span)[span_15](end_span)[span_16](start_span)[span_16](end_span)
                if ekonomi and ekonomi:FindFirstChild("BedilPusat") then[span_17](start_span)[span_17](end_span)[span_18](start_span)[span_18](end_span)
                    local startPoint = ekonomi.BedilPusat:FindFirstChild("Job") or ekonomi.BedilPusat:FindFirstChild("Finish")[span_19](start_span)[span_19](end_span)
                    if startPoint then
                        tweenTo(startPoint:GetPivot(), 35)
                    end
                end
                task.wait(2)
            end
        end
    end)
end

-- Toggle Switch Button
BtnAuto.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        BtnAuto.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        BtnAuto.Text = "Otomatis Farm Maxgen : ON"
        startTikTokAutoJob()
    else
        BtnAuto.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        BtnAuto.Text = "Otomatis Farm Maxgen : OFF"
    end
end)
