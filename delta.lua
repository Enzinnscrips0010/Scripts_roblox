-- DELTA HUB FPS COMPLETO
-- Tudo para jogos de tiro no Roblox

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Configuração inicial
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Variáveis globais
local modules = {
    ESP = {enabled = false, objects = {}},
    Aimbot = {enabled = false, fov = 100, smoothness = 0.2},
    SilentAim = {enabled = false, hitChance = 100},
    TriggerBot = {enabled = false, delay = 0.1},
    NoRecoil = {enabled = false},
    NoSpread = {enabled = false},
    InstantHit = {enabled = false},
    WallBang = {enabled = false},
    RapidFire = {enabled = false},
    SpeedHack = {enabled = false, speed = 50},
    HighJump = {enabled = false, jump = 50},
    NoClip = {enabled = false},
    Fly = {enabled = false, speed = 50},
    InfiniteAmmo = {enabled = false},
    OneHitKill = {enabled = false},
    FullBright = {enabled = false},
    FOVChanger = {enabled = false, fov = 120}
}

-- Criar janela principal
local Window = Rayfield:CreateWindow({
    Name = "🔥 DELTA FPS HUB",
    LoadingTitle = "Carregando arsenal completo...",
    LoadingSubtitle = "Otimizado para jogos de tiro",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeltaFPSHub",
        FileName = "Config"
    }
})

-- ============ TAB VISUAL ============
local VisualTab = Window:CreateTab("👁️ Visual", 4483362458)

-- ESP COMPLETO
VisualTab:CreateSection("ESP")

VisualTab:CreateToggle({
    Name = "ESP Box",
    CurrentValue = false,
    Flag = "ESPBox",
    Callback = function(value)
        modules.ESP.enabled = value
        if value then
            loadstring([[
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local me = Players.LocalPlayer
                local cam = workspace.CurrentCamera
                
                local boxes = {}
                
                local function createBox()
                    return {
                        top = Drawing.new("Line"),
                        bottom = Drawing.new("Line"),
                        left = Drawing.new("Line"),
                        right = Drawing.new("Line")
                    }
                end
                
                local function updateBox(box, pos, size, color)
                    local topLeft = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
                    local topRight = Vector2.new(pos.X + size.X/2, pos.Y - size.Y/2)
                    local bottomLeft = Vector2.new(pos.X - size.X/2, pos.Y + size.Y/2)
                    local bottomRight = Vector2.new(pos.X + size.X/2, pos.Y + size.Y/2)
                    
                    box.top.From = topLeft
                    box.top.To = topRight
                    box.top.Color = color
                    
                    box.bottom.From = bottomLeft
                    box.bottom.To = bottomRight
                    box.bottom.Color = color
                    
                    box.left.From = topLeft
                    box.left.To = bottomLeft
                    box.left.Color = color
                    
                    box.right.From = topRight
                    box.right.To = bottomRight
                    box.right.Color = color
                end
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= me then
                        boxes[player] = createBox()
                    end
                end
                
                Players.PlayerAdded:Connect(function(player)
                    if player ~= me then
                        boxes[player] = createBox()
                    end
                end)
                
                Players.PlayerRemoving:Connect(function(player)
                    if boxes[player] then
                        for _, line in pairs(boxes[player]) do
                            line:Remove()
                        end
                        boxes[player] = nil
                    end
                end)
                
                RunService.RenderStepped:Connect(function()
                    for player, box in pairs(boxes) do
                        if player and player.Character then
                            local root = player.Character:FindFirstChild("HumanoidRootPart")
                            if root then
                                local pos, onScreen = cam:WorldToViewportPoint(root.Position)
                                if onScreen then
                                    local distance = (cam.CFrame.Position - root.Position).Magnitude
                                    local size = Vector2.new(2000/distance, 3000/distance)
                                    local color = Color3.fromRGB(255, 50, 50)
                                    
                                    for _, line in pairs(box) do
                                        line.Thickness = 1
                                        line.Visible = true
                                    end
                                    
                                    updateBox(box, Vector2.new(pos.X, pos.Y), size, color)
                                else
                                    for _, line in pairs(box) do
                                        line.Visible = false
                                    end
                                end
                            else
                                for _, line in pairs(box) do
                                    line.Visible = false
                                end
                            end
                        else
                            for _, line in pairs(box) do
                                line.Visible = false
                            end
                        end
                    end
                end)
            ]])()
        end
    end
})

VisualTab:CreateToggle({
    Name = "ESP Linha",
    CurrentValue = false,
    Flag = "ESPLine",
    Callback = function(value)
        if value then
            loadstring([[
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local me = Players.LocalPlayer
                local cam = workspace.CurrentCamera
                
                local lines = {}
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= me then
                        local line = Drawing.new("Line")
                        line.Visible = false
                        line.Thickness = 2
                        line.Color = Color3.fromRGB(255, 0, 0)
                        lines[player] = line
                    end
                end
                
                Players.PlayerAdded:Connect(function(player)
                    if player ~= me then
                        local line = Drawing.new("Line")
                        line.Visible = false
                        line.Thickness = 2
                        line.Color = Color3.fromRGB(255, 0, 0)
                        lines[player] = line
                    end
                end)
                
                RunService.RenderStepped:Connect(function()
                    for player, line in pairs(lines) do
                        if player and player.Character then
                            local root = player.Character:FindFirstChild("HumanoidRootPart")
                            if root then
                                local pos, onScreen = cam:WorldToViewportPoint(root.Position)
                                if onScreen then
                                    line.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                                    line.To = Vector2.new(pos.X, pos.Y)
                                    line.Visible = true
                                else
                                    line.Visible = false
                                end
                            else
                                line.Visible = false
                            end
                        else
                            line.Visible = false
                        end
                    end
                end)
            ]])()
        end
    end
})

VisualTab:CreateToggle({
    Name = "ESP Vida",
    CurrentValue = false,
    Flag = "ESPHealth",
    Callback = function(value)
        if value then
            loadstring([[
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local me = Players.LocalPlayer
                local cam = workspace.CurrentCamera
                
                local healthBars = {}
                
                local function createHealthBar()
                    return {
                        bg = Drawing.new("Line"),
                        fill = Drawing.new("Line")
                    }
                end
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= me then
                        healthBars[player] = createHealthBar()
                    end
                end
                
                RunService.RenderStepped:Connect(function()
                    for player, bar in pairs(healthBars) do
                        if player and player.Character then
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            local root = player.Character:FindFirstChild("HumanoidRootPart")
                            
                            if humanoid and root and humanoid.Health > 0 then
                                local pos, onScreen = cam:WorldToViewportPoint(root.Position)
                                if onScreen then
                                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                                    local barHeight = 50 * healthPercent
                                    local barX = pos.X + 30
                                    local barY = pos.Y
                                    
                                    -- Fundo
                                    bar.bg.From = Vector2.new(barX, barY - 25)
                                    bar.bg.To = Vector2.new(barX, barY + 25)
                                    bar.bg.Thickness = 4
                                    bar.bg.Color = Color3.new(0, 0, 0)
                                    bar.bg.Visible = true
                                    
                                    -- Preenchimento
                                    bar.fill.From = Vector2.new(barX, barY + 25)
                                    bar.fill.To = Vector2.new(barX, barY + 25 - barHeight)
                                    bar.fill.Thickness = 2
                                    bar.fill.Visible = true
                                    
                                    -- Cor baseada na vida
                                    if healthPercent > 0.7 then
                                        bar.fill.Color = Color3.new(0, 1, 0)
                                    elseif healthPercent > 0.3 then
                                        bar.fill.Color = Color3.new(1, 1, 0)
                                    else
                                        bar.fill.Color = Color3.new(1, 0, 0)
                                    end
                                else
                                    bar.bg.Visible = false
                                    bar.fill.Visible = false
                                end
                            else
                                bar.bg.Visible = false
                                bar.fill.Visible = false
                            end
                        end
                    end
                end)
            ]])()
        end
    end
})

VisualTab:CreateToggle({
    Name = "FullBright",
    CurrentValue = false,
    Flag = "FullBright",
    Callback = function(value)
        if value then
            local Lighting = game:GetService("Lighting")
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            local Lighting = game:GetService("Lighting")
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.FogEnd = 10000
            Lighting.GlobalShadows = true
        end
    end
})

-- ============ TAB AIMBOT ============
local AimbotTab = Window:CreateTab("🎯 Aimbot", 4483362458)

AimbotTab:CreateSection("Configurações do Aimbot")

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Radius = 100
fovCircle.Thickness = 2
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Filled = false
fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

AimbotTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "Aimbot",
    Callback = function(value)
        modules.Aimbot.enabled = value
        fovCircle.Visible = value
        
        if value then
            spawn(function()
                while modules.Aimbot.enabled and RunService.Stepped:Wait() do
                    local closestTarget = nil
                    local closestDistance = modules.Aimbot.fov
                    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            local head = player.Character:FindFirstChild("Head")
                            
                            if humanoid and humanoid.Health > 0 and head then
                                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                                if onScreen then
                                    local targetPos = Vector2.new(pos.X, pos.Y)
                                    local distance = (mousePos - targetPos).Magnitude
                                    
                                    if distance < closestDistance then
                                        closestDistance = distance
                                        closestTarget = head
                                    end
                                end
                            end
                        end
                    end
                    
                    if closestTarget then
                        local targetPos = closestTarget.Position
                        local cameraPos = Camera.CFrame.Position
                        local direction = (targetPos - cameraPos).Unit
                        
                        local newCFrame = CFrame.new(cameraPos, cameraPos + direction)
                        Camera.CFrame = Camera.CFrame:Lerp(newCFrame, modules.Aimbot.smoothness)
                    end
                end
            end)
        end
    end
})

AimbotTab:CreateSlider({
    Name = "FOV",
    Range = {10, 300},
    Increment = 10,
    Suffix = "px",
    CurrentValue = 100,
    Flag = "AimbotFOV",
    Callback = function(value)
        modules.Aimbot.fov = value
        fovCircle.Radius = value
    end
})

AimbotTab:CreateSlider({
    Name = "Suavidade",
    Range = {0.1, 1},
    Increment = 0.1,
    CurrentValue = 0.2,
    Flag = "AimbotSmooth",
    Callback = function(value)
        modules.Aimbot.smoothness = value
    end
})

AimbotTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Flag = "SilentAim",
    Callback = function(value)
        modules.SilentAim.enabled = value
    end
})

AimbotTab:CreateToggle({
    Name = "Trigger Bot",
    CurrentValue = false,
    Flag = "TriggerBot",
    Callback = function(value)
        modules.TriggerBot.enabled = value
        if value then
            spawn(function()
                while modules.TriggerBot.enabled do
                    task.wait(modules.TriggerBot.delay)
                    mouse1click()
                end
            end)
        end
    end
})

-- ============ TAB COMBATE ============
local CombatTab = Window:CreateTab("⚔️ Combate", 4483362458)

CombatTab:CreateToggle({
    Name = "Sem Recoil",
    CurrentValue = false,
    Flag = "NoRecoil",
    Callback = function(value)
        modules.NoRecoil.enabled = value
    end
})

CombatTab:CreateToggle({
    Name = "Sem Spread",
    CurrentValue = false,
    Flag = "NoSpread",
    Callback = function(value)
        modules.NoSpread.enabled = value
    end
})

CombatTab:CreateToggle({
    Name = "Tiro Instantâneo",
    CurrentValue = false,
    Flag = "InstantHit",
    Callback = function(value)
        modules.InstantHit.enabled = value
    end
})

CombatTab:CreateToggle({
    Name = "Wall Bang",
    CurrentValue = false,
    Flag = "WallBang",
    Callback = function(value)
        modules.WallBang.enabled = value
    end
})

CombatTab:CreateToggle({
    Name = "Rapid Fire",
    CurrentValue = false,
    Flag = "RapidFire",
    Callback = function(value)
        modules.RapidFire.enabled = value
    end
})

CombatTab:CreateToggle({
    Name = "Munição Infinita",
    CurrentValue = false,
    Flag = "InfiniteAmmo",
    Callback = function(value)
        modules.InfiniteAmmo.enabled = value
    end
})

CombatTab:CreateToggle({
    Name = "One Hit Kill",
    CurrentValue = false,
    Flag = "OneHitKill",
    Callback = function(value)
        modules.OneHitKill.enabled = value
    end
})

-- ============ TAB MOVIMENTO ============
local MovementTab = Window:CreateTab("🏃‍♂️ Movimento", 4483362458)

MovementTab:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = false,
    Flag = "SpeedHack",
    Callback = function(value)
        modules.SpeedHack.enabled = value
        if value then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = modules.SpeedHack.speed
            end
            
            LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(1)
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum.WalkSpeed = modules.SpeedHack.speed
                end
            end)
        else
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
})

MovementTab:CreateSlider({
    Name = "Velocidade",
    Range = {16, 200},
    Increment = 10,
    Suffix = "studs/s",
    CurrentValue = 50,
    Flag = "SpeedValue",
    Callback = function(value)
        modules.SpeedHack.speed = value
        if modules.SpeedHack.enabled then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end
})

MovementTab:CreateToggle({
    Name = "High Jump",
    CurrentValue = false,
    Flag = "HighJump",
    Callback = function(value)
        modules.HighJump.enabled = value
        if value then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = modules.HighJump.jump
            end
  
  LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(1)
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum.JumpPower = modules.HighJump.jump
                end
            end)
        else
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = 50
            end
        end
    end
})

MovementTab:CreateSlider({
    Name = "Altura do Pulo",
    Range = {50, 200},
    Increment = 10,
    Suffix = "studs",
    CurrentValue = 50,
    Flag = "JumpValue",
    Callback = function(value)
        modules.HighJump.jump = value
        if modules.HighJump.enabled then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = value
            end
        end
    end
})

MovementTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(value)
        modules.NoClip.enabled = value
        if value then
            spawn(function()
                while modules.NoClip.enabled do
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(value)
        modules.Fly.enabled = value
        if value then
            loadstring([[
                local plr = game:GetService("Players").LocalPlayer
                local mouse = plr:GetMouse()
                
                local flying = true
                local speed = 50
                
                local function fly()
                    local torso = plr.Character:FindFirstChild("HumanoidRootPart")
                    if not torso then return end
                    
                    torso.Velocity = Vector3.new(0, 0, 0)
                    torso.GravityScale = 0
                    
                    while flying do
                        torso.Velocity = Vector3.new(0, 0, 0)
                        
                        if mouse.Button1Pressed then
                            local forward = (torso.CFrame.LookVector * 10) * speed
                            torso.Velocity = forward
                        end
                        
                        if mouse.Button2Pressed then
                            local backward = (torso.CFrame.LookVector * -10) * speed
                            torso.Velocity = backward
                        end
                        
                        game:GetService("RunService").Heartbeat:Wait()
                    end
                    
                    torso.GravityScale = 1
                end
                
                fly()
            ]])()
        end
    end
})

-- ============ TAB MISC ============
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateButton({
    Name = "Copiar Position",
    Callback = function()
        if LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                setclipboard(tostring(root.Position))
                Rayfield:Notify({
                    Title = "Posição Copiada",
                    Content = tostring(root.Position),
                    Duration = 3
                })
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "TP para Spawn",
    Callback = function()
        local spawnLocation = Workspace:FindFirstChild("SpawnLocation")
        if spawnLocation then
            LocalPlayer.Character:MoveTo(spawnLocation.Position)
        end
    end
})

MiscTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        Rayfield:Notify({
            Title = "Server Hop",
            Content = "Procurando novo servidor...",
            Duration = 3
        })
        
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local PlaceID = game.PlaceId
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Desc&limit=100"))
        
        for _, server in pairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(PlaceID, server.id)
                break
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

-- Loop para atualizar FOV circle
RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
    fovCircle.Radius = modules.Aimbot.fov
    fovCircle.Visible = modules.Aimbot.enabled
end)

-- Notificação inicial
Rayfield:Notify({
    Title = "Delta FPS Hub",
    Content = "Hub carregado com sucesso!",
    Duration = 5
})