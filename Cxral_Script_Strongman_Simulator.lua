local library = loadstring(game:HttpGet("https://pastebin.com/GZGpURdR", true))()
local w = library:CreateWindow('Strongman Simulator')
local Workout_Mul = 1
-- GUI SECTION
w:Section('Script Made By Cxral')
w:Section('Discord > discord.gg/hZpKTqtGWJ')
-- GUI Toggles
local FarmHydra = w:Toggle('Farm Hydra', {flag = "FarmHydra"})
local FarmStrength = w:Toggle('Farm Strength', {flag = "FarmStrength"})
 
w:Box("Workout Multi",{type = "number"},function(v)
   Workout_Mul = v
end)
-- [[ GUI FUNCTIONS ]] --
 
local Best_WorkOut,Best_Num = nil,0
for i,v in pairs(game:GetService("Workspace").Areas:GetDescendants()) do
   if v.Name == "WorkoutNumber" and v.Value > Best_Num then
       Best_WorkOut,Best_Num = v.Parent.Parent,v.Value
   end
end
 
function FarmHydra()
       --clear
 
 -- Local Player
 local Plr = game:GetService("Players").LocalPlayer
 local Char = Plr.Character
 local RootPart = Char.HumanoidRootPart
 local LowerTorso = Char.LowerTorso
 
 -- Game Stuff
--   local Loader = game:GetService("Workspace").BadgeColliders.FarmBadge
 local Hydra_Item = game:GetService("Workspace").Areas["Area14_Retro"].DraggableItems:FindFirstChildOfClass("MeshPart")
 
 if Hydra_Item == nil then
     -- We need to load part of the map in.
     RootPart.CFrame = CFrame.new(-132.68457, 45.386734, 4114.20654, 1, 0, 0, 0, 1, 0, 0, 0, 1)
     return true;
 end
 
 local Hydra = Hydra_Item:WaitForChild("InteractionPoint")
 local Proximity = Hydra:FindFirstChild("ProximityPrompt")
 
 -- Teleport and grab Hydra
 RootPart.CFrame = Hydra.CFrame
 wait(0.1)
 Proximity:InputHoldBegin()
 Proximity:InputHoldEnd()
 
 -- Teleport us to the finish (I have some nasty hard coded stuff in here.)
 repeat
  for i,v in pairs(game:GetService("Workspace").PlayerDraggables[game.Players.LocalPlayer.UserId]:GetChildren()) do
      v.Anchored = true
      v.CFrame = game:GetService("Workspace").Areas["Area9_Space"].Goal.CFrame
      wait()
      v.Anchored = false
  end
  wait()
until #game:GetService("Workspace").PlayerDraggables[game.Players.LocalPlayer.UserId]:GetChildren() < 1
 
end
 
function FarmStrength()
 
 -- Local Player
 local Plr = game:GetService("Players").LocalPlayer
 local Char = Plr.Character
 local RootPart = Char.HumanoidRootPart
 
 -- Game Stuff
 local Gym = Best_WorkOut
 local Proximity = Gym.ProximityPrompt
 
 -- Teleport to Weights
 RootPart.CFrame = Gym.CFrame
 wait(0.0)
 
 -- Start Workout
 Proximity:InputHoldBegin()
 wait(0.0)
 Proximity:InputHoldEnd()
 
while w.flags.FarmStrength do
    wait(0.0)
    game:GetService("ReplicatedStorage")["StrongMan_UpgradeStrength"]:InvokeServer(Workout_Mul)
end
 
 -- Jump to end Workout
 Char.Humanoid.Jump = true
end
 
 
-- [[ GUI LISTENERS ]] --
 
-- Farm Hydra
spawn(function()
 while wait() do
     if w.flags.FarmHydra then
         FarmHydra()
     end
 end
end)
 
-- Farm Strength
spawn(function()
 while wait() do
     if w.flags.FarmStrength then
         FarmStrength()
     end
 end
end)