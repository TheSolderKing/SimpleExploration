entity = class()

function entity:init(x,y,d)
    -- you can accept and set parameters here
    self.pos = vec2(x,y)
    self.d = d
end

function entity:move(amount)
    local newX,newY = self.pos.x + amount.x, self.pos.y + amount.y
    collX,collY = false,false
    local collX,collY = self:testColl(newX,newY)
    if not collX then
        self.pos.x = self.pos.x + amount.x
    end
    if not collY then
        self.pos.y = self.pos.y + amount.y
    end
    if collX or collY then
        return true
    end
end

function entity:testColl(x,y)
    local bx,by = w:convertToWorld(self.pos.x,self.pos.y)
    local collX,collY = false,false
    for xx=-1,1 do
        for yy=-1,1 do
            if bx + xx > 0 and bx + xx < w.mapSize + 1 and by + yy > 0 and by + yy < w.mapSize + 1 and w.worldMap[bx+xx][by+yy].id ~= 1 then
                if self.pos.x >= ((bx+xx) - 1) * WIDTH/w.mapSize - self.d.x/2 and self.pos.x <= ((bx+xx) - 1) * WIDTH/w.mapSize + WIDTH/w.mapSize + self.d.x/2 and not (y<(by+yy-1) * WIDTH/w.mapSize - self.d.x/2 or y>(by+yy-1) * WIDTH/w.mapSize + WIDTH/w.mapSize + self.d.x/2) then
                    collY = true
                end
                if self.pos.y >= ((by+yy) - 1) * WIDTH/w.mapSize - self.d.x/2 and self.pos.y <= ((by+yy) - 1) * WIDTH/w.mapSize + WIDTH/w.mapSize + self.d.x/2 and not (x<(bx+xx-1)*WIDTH/w.mapSize - self.d.x/2 or x>(bx+xx-1) * WIDTH/w.mapSize + WIDTH/w.mapSize + self.d.x/2) then
                    collX = true
                end
            end
        end
    end
    return collX,collY
end
function entity:testCollWithPlayer(player)
    if self.pos.x>player.pos.x-player.d.x/2 and self.pos.x<player.pos.x+player.d.x/2 and self.pos.y>player.pos.y-player.d.y/2 and self.pos.y<player.pos.y+player.d.y/2 then
        return true
    end
    return false
end
function entity:destroy()
    world:killEntity(i)
end
