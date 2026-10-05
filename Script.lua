-- =================================================================
-- INFO PEMBUATAN: bruk ontop
-- VERSI: 1.0.0
-- TARGET MAP: Indo Glarity Reborn (Maxgen Delivery Job)
-- BASE SCRIPT: Delta Exploit Mobile (Floating GUI Menu)
-- BINDING STATUS: 100% Sinkron dengan Objek Dex Explorer
-- =================================================================

local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")
local AutoFarmBtn = Instance.new("TextButton")

ScreenGui.Name = "BrukOntopGlarityOfficial"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- [1] SETUP GUI MELAYANG (FLOATING MENU ACTION BUTTON)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Text = "Bruk"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 16

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

-- [2] PANEL MENU UTAMA
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "bruk ontop - V1.0.0"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

InfoLabel.Parent = MainFrame
InfoLabel.Position = UDim2.new(0, 0, 0.25, 0)
InfoLabel.Size = UDim2.new(1, 0, 0, 30)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Indo Glarity Reborn Job Autopilot"
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.TextSize = 13

AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
AutoFarmBtn.Size = UDim2.new(0.8, 0, 0, 50)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
AutoFarmBtn.Text = "Auto Farm Maxgen: OFF"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = AutoFarmBtn

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- [3] LOGIKA INTI AUTOPILOT PEKERJAAN (CORE ENGINE)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
_G.BrukOntopActive = false

-- Membuat Kendaraan Menembus Semua Rintangan/Tembok Map (No-Clip Hambatan)
local function SetNoClipMode(vehicleModel)
    for _, part in pairs(vehicleModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Fungsi Mengemudi Otomatis Tanpa Hambatan Menggunakan Metode Tween Gerak Halus
local function DriveAutopilotTo(targetPosition, travelSpeed)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local targetMovingPart = character:FindFirstChild("HumanoidRootPart")
    
    -- Deteksi Jika Berada di Dalam Kendaraan, Maka Gerakkan Badan Utama Mobilnya
    if character:FindFirstChild("Humanoid") and character.Humanoid.SeatPart then
        local currentCar = character.Humanoid.SeatPart.Parent
        targetMovingPart = currentCar.PrimaryPart or character.Humanoid.SeatPart
        SetNoClipMode(currentCar) -- Mobil dipastikan menembus pagar/tiang/bangunan
    end
    
    if targetMovingPart then
        local distance = (targetMovingPart.Position - targetPosition).Magnitude
        local duration = distance / travelSpeed
        local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(targetMovingPart, info, {CFrame = CFrame.new(targetPosition)})
        tween:Play()
        tween.Completed:Wait()
    end
end

-- Deteksi dan Ambil Mobil Kerja yang Muncul di SpeakerFolder
local function GetSpawnedJobCar()
    local speakerFolder = workspace:FindFirstChild("SpeakerFolder")
    if speakerFolder then
        for _, child in pairs(speakerFolder:GetChildren()) do
            if string.find(child.Name, "SpawnedOutside") then
                return child
            end
        end
    end
    return nil
end

-- LOOP UTAMA PROSES AUTO FARM (SENGGOL REMOTE -> NAIK MOBIL -> DRIVING TO POINT -> GAJI)
task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.BrukOntopActive then
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                
                -- LANGKAH 1: Triger Ambil Kerjaan Menggunakan Akses Jalur Remote Tanpa Jalan Kaki
                local jobRemote = game.ReplicatedStorage.Remotes.Job:FindFirstChild("DeliveryRemote")
                if jobRemote then
                    jobRemote:FireServer()
                    task.wait(2.5) -- Memberi jeda waktu server memunculkan mobil di map
                end
                
                -- LANGKAH 2: Cari Mobil Kerja dan Paksa Karakter Masuk ke Kursi Sopir Otomatis
                local myCar = GetSpawnedJobCar()
                if myCar then
                    local seat = myCar:FindFirstChildOfClass("VehicleSeat") or myCar:FindFirstChild("DriveSeat") or myCar:FindFirstChildOfClass("Seat")
                    if seat then
                        seat:Sit(character:FindFirstChild("Humanoid"))
                        task.wait(1.2)
                    end
                end
                
                -- LANGKAH 3: Melacak Titik Tujuan Tanda Kuning Berdasarkan Laser Penunjuk Jalan
                local finalTargetPos = nil
                
                -- Metode A: Deteksi berdasarkan DummyTarget dinamis yang terhubung ke laser DeliveryBeam
                for _, obj in pairs(workspace:GetChildren()) do
                    if string.find(obj.Name, "DummyTarget") and obj:IsA("BasePart") then
                        finalTargetPos = obj.Position
                        break
                    end
                end
                
                -- Metode B (Cadangan): Membaca Data dari Folder ActiveJobs -> DeliveryTargets
                if not finalTargetPos then
                    local activeJobs = workspace.Ekonomi:FindFirstChild("ActiveJobs") or workspace:FindFirstChild("ActiveJobs")
                    if activeJobs and activeJobs:FindFirstChild("DeliveryTargets") then
                        local targetObj = activeJobs.DeliveryTargets:FindFirstChild("Target") or activeJobs.DeliveryTargets:FindFirstChild("Finish")
                        if targetObj and targetObj:IsA("BasePart") then
                            finalTargetPos = targetObj.Position
                        end
                    end
                end
                
                -- Jika Posisi Titik Kuning Ditemukan, Mulai Mengemudi Otomatis Menembus Map
                if finalTargetPos then
                    DriveAutopilotTo(finalTargetPos, 90) -- Mengemudi konstan dengan kecepatan aman 90 studs/detik
                    task.wait(3) -- Menunggu sistem pembayaran memproses tulisan selesai di layar
                end
                
                -- LANGKAH 4: Deteksi Pembayaran Sukses Melalui Jalur GUI Notifikasi
                local notifGui = LocalPlayer.PlayerGui:FindFirstChild("Notification")
                if notifGui and notifGui:FindFirstChild("SUKSES") then
                    -- Cek Apakah Menu Notifikasi Sukses Sedang Muncul/Aktif
                    if notifGui.SUKSES.Visible == true or notifGui.SUKSES.BackgroundTransparency < 1 then
                        task.wait(1)
                        -- Hapus sisa mobil agar siklus loop berikutnya bersih tanpa bug menumpuk
                        local oldCar = GetSpawnedJobCar()
                        if oldCar then
                            oldCar:Destroy()
                        end
                    end
                end
                task.wait(1.5)
            end)
        end
    end
end)

-- TRIGER TOMBOL AKTIFASI DI LAYAR MENU HP
AutoFarmBtn.MouseButton1Click:Connect(function()
    _G.BrukOntopActive = not _G.BrukOntopActive
    if _G.BrukOntopActive then
        AutoFarmBtn.Text = "Auto Farm Maxgen: ON"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    else
        AutoFarmBtn.Text = "Auto Farm Maxgen: OFF"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
    end
end)
