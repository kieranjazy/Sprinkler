
local mod = RegisterMod("Sprinkler", 1)
local itemSprinkler = Isaac.GetItemIdByName("Sprinkler")
local sprinklerCount = 0
local sprinklerEnabled = true

local up = Vector(0, -10)
local upRight = Vector(10, -10)
local right = Vector(10, 0)
local downRight = Vector(10, 10)
local down = Vector(0, 10)
local leftDown = Vector(-10, 10)
local left = Vector(-10, 0)
local leftUp = Vector(-10, -10)

local dirStringArray = {
  "Top", 
  "Top Right",
  "Right",
  "Bottom Right",
  "Bottom",
  "Bottom Left",
  "Left",
  "Top Left"
}

local velDirArray = {
  up,
  upRight,
  right,
  downRight,
  down,
  leftDown, 
  left,
  leftUp
}

function degreesToDirString(angleDegrees)
  if angleDegrees == 0 then
    return "Right"
  elseif angleDegrees == 45 then
    return "Bottom Right"
  elseif angleDegrees == 90 then
    return "Bottom"
  elseif angleDegrees == 135 then
    return "Bottom Left"
  elseif angleDegrees == 180 then
    return "Left"
  elseif angleDegrees == 225 then
    return "Top Left"
  elseif angleDegrees == 270 then
    return "Top"
  elseif angleDegrees == 315 then
    return "Top Right"
  else
  end
end

function singleBrimstoneFire(position, angleDegrees, sourceEntity, sprite)
  sprite:Play(degreesToDirString(angleDegrees), false)
  local laser = EntityLaser.ShootAngle(1, position, angleDegrees, 5, Vector(LaserOffset.LASER_BRIMSTONE_OFFSET - 4, LaserOffset.LASER_BRIMSTONE_OFFSET - 33), sourceEntity)
  laser.MaxDistance = 115
  laser.DisableFollowParent = true
  sprinklerIncrease()
end

function isActiveEnemy()
  local entities = Isaac.GetRoomEntities()
  for i = 1, #entities do
    if entities[i]:IsActiveEnemy(false) then
      return true
    end
  end
  return false
end

function singleDrFetusFire(player, position, direction, dirString, sprite)
  sprite:Play(dirString, false)
  player:FireBomb(position, direction)
  sprinklerIncrease()
end

function singleTechXFire(player, position, direction, dirString, sprite)
  sprite:Play(dirString, false)
  player:FireTechXLaser(position, direction, 6)
  sprinklerIncrease()
end

function singleSprinklerFire(player, position, direction, dirString, sprite, setIncrease)
  sprite:Play(dirString, false)
  player:FireTear(position, direction, false, false, false)
  if setIncrease then
    sprinklerIncrease()
  end
end

function sprinklerIncrease()
  if sprinklerCount ~= 7 then
    sprinklerCount = sprinklerCount + 1
  else
    sprinklerCount = 0
  end
end


function sprinklerFunction()
  local entities = Isaac.GetRoomEntities()
  local player = Isaac.GetPlayer(0)
  if Isaac:GetFrameCount() % (player.MaxFireDelay) == 0 then
    for i = 1, #entities do
      if entities[i].Type == 12358 then
        local position = Vector(entities[i].Position.X, entities[i].Position.Y + 15)
        local sprite = entities[i]:GetSprite()
        entities[i]:ToNPC().CanShutDoors = false
        
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) and sprinklerEnabled == true then
          if sprinklerCount == 0 then
            singleBrimstoneFire(position, 270, player, sprite)
          elseif sprinklerCount == 1 then
            singleBrimstoneFire(position, 315, player, sprite)
          elseif sprinklerCount == 2 then
            singleBrimstoneFire(position, 0, player, sprite)
          elseif sprinklerCount == 3 then
            singleBrimstoneFire(position, 45, player, sprite)
          elseif sprinklerCount == 4 then
            singleBrimstoneFire(position, 90, player, sprite)
          elseif sprinklerCount == 5 then
            singleBrimstoneFire(position, 135, player, sprite)
          elseif sprinklerCount == 6 then
            singleBrimstoneFire(position, 180, player, sprite)
          elseif sprinklerCount == 7 then
            singleBrimstoneFire(position, 225, player, sprite)
          else
          end
        end
  
        
        if player:HasCollectible(CollectibleType.COLLECTIBLE_LOKIS_HORNS) and sprinklerEnabled == true then
          if sprinklerCount % 2 == 0 then
            singleSprinklerFire(player, position, up, "Top", sprite, false)
            singleSprinklerFire(player, position, right, "Right", sprite, false)
            singleSprinklerFire(player, position, down, "Down", sprite, false)
            singleSprinklerFire(player, position, left, "Left", sprite, false)
            sprinklerIncrease()
          else 
            singleSprinklerFire(player, position, upRight, "Top Right", sprite, false)
            singleSprinklerFire(player, position, downRight, "Bottom Right", sprite, false)
            singleSprinklerFire(player, position, leftUp, "Top Left", sprite, false)
            singleSprinklerFire(player, position, leftDown, "Bottom Left", sprite, false)
            sprinklerIncrease()
          end
        end
        
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) and sprinklerEnabled == true then
          if sprinklerCount == 0 then
            singleDrFetusFire(player, position, up, "Top", sprite)
          elseif sprinklerCount == 1 then
            singleDrFetusFire(player, position, upRight, "Top Right", sprite)
          elseif sprinklerCount == 2 then
            singleDrFetusFire(player, position, right, "Right", sprite)
          elseif sprinklerCount == 3 then
            singleDrFetusFire(player, position, downRight, "Bottom Right", sprite)
          elseif sprinklerCount == 4 then
            singleDrFetusFire(player, position, down, "Down", sprite)
          elseif sprinklerCount == 5 then
            singleDrFetusFire(player, position, leftDown, "Bottom Left", sprite)
          elseif sprinklerCount == 6 then
            singleDrFetusFire(player, position, left, "Left", sprite)
          elseif sprinklerCount == 7 then
            singleDrFetusFire(player, position, leftUp, "Top Left", sprite)
          else
          end
        end
        
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X)  and sprinklerEnabled == true then
          if sprinklerCount == 0 then
            singleTechXFire(player, position, up, "Top", sprite)
          elseif sprinklerCount == 1 then
            singleTechXFire(player, position, upRight, "Top Right", sprite)
          elseif sprinklerCount == 2 then
            singleTechXFire(player, position, right, "Right", sprite)
          elseif sprinklerCount == 3 then
            singleTechXFire(player, position, downRight, "Bottom Right", sprite)
          elseif sprinklerCount == 4 then
            singleTechXFire(player, position, down, "Down", sprite)
          elseif sprinklerCount == 5 then
            singleTechXFire(player, position, leftDown, "Bottom Left", sprite)
          elseif sprinklerCount == 6 then
            singleTechXFire(player, position, left, "Left", sprite)
          elseif sprinklerCount == 7 then
            singleTechXFire(player, position, leftUp, "Top Left", sprite)
          else
          end
        end
        
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) == false and
        player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) == false and
        player:HasCollectible(CollectibleType.COLLECTIBLE_LOKIS_HORNS) == false and
        player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) == false and
        sprinklerEnabled == true 
        then
          singleSprinklerFire(player, position, velDirArray[sprinklerCount + 1], dirStringArray[sprinklerCount + 1], sprite, true)
        end
        
      end
    end
  end
end

function onSprinklerUse()
  local player = Isaac.GetPlayer(0)
  local pos = Isaac.GetFreeNearPosition(player.Position, 1)
  local entities = Isaac.GetRoomEntities()
  sprinklerCount = 0
  
  for i = 1, #entities do
    if entities[i].Type == 12358 then
      entities[i]:Die()
      Isaac.Spawn(12358, 0, 0, pos, Vector(0, 0), player)
      goto done
    end
  end
  Isaac.Spawn(12358, 0, 0, pos, Vector(0, 0), player)
  ::done::
end



mod:AddCallback(ModCallbacks.MC_USE_ITEM, onSprinklerUse, itemSprinkler)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, sprinklerFunction)
