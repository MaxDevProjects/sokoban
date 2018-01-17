local hero = {}
box = {}
hero.line = 5
hero.column = 18
hero.x = 0
hero.y = 0

hero.imgCurrent = 1
hero.SpeedAnimPlay = 5
hero.images = {}
hero.images[1] = love.graphics.newImage("images/character.png")

hero.dir = nil

function hero.Load(pGame)
  
end

function hero.Update(pBox, pCamera, pGame, pMap,dt)
  hero.imgCurrent = hero.imgCurrent + (hero.SpeedAnimPlay*dt)
  if math.floor(hero.imgCurrent) > #hero.images then
    hero.imgCurrent = 1
  end
  
  if love.keyboard.isDown("z","q","s","d") then
    
    if hero.KeyPressed == false then
      
      local oldC = hero.column
      local oldL = hero.line
      
      if love.keyboard.isDown("z") then
        hero.line = hero.line - 1
        hero.dir = "up"
        print(hero.dir)
      end
      if love.keyboard.isDown("s") then
        hero.line = hero.line + 1
        hero.dir = "down"
        print(hero.dir)
      end
      if love.keyboard.isDown("q") then
        hero.column = hero.column - 1
        hero.dir = "left"
        print(hero.dir)
      end
      if love.keyboard.isDown("d") then
        hero.column = hero.column + 1
        hero.dir = "right"
        print(hero.dir)
      end
      
      
      local oldBoxL, oldBoxC
      local l = hero.line
      local c = hero.column
      local id = pMap[((l-1)*25) + c]
      if pMap.isSolid(id) then
        hero.line = oldL
        hero.column = oldC   
        
        --local box = {}
        --box.l = 0
        --box.c = 0
        
        -- **revoir pour mouvements de box** --------
        --box.l = hero.line 
        --box.c = hero.column 
        --box.type = pGame.tileType[13]
        --if hero.dir == "right" and box.type then
        --  print("boxX : "..box.c)
        --end
      end
      hero.KeyPressed = true
    end 
  else
    hero.KeyPressed = false
  end      
end

function hero.Draw(pMap, pCam)
  hero.x = (hero.column - 1) * pMap.TILE_WIDTH 
  hero.y = (hero.line - 1) * pMap.TILE_HEIGHT 
  love.graphics.draw(hero.images[math.floor(hero.imgCurrent)], hero.x + pCam.column, hero.y + pCam.line, 0, 2, 2)
  
 -- local l = hero.line
 -- local c = hero.column
 -- local ID = pMap[ ((l-1)*25) + c ]
 -- love.graphics.setColor(255,255,255)
 -- love.graphics.present("type"..tostring(pGame.tileType[ID]))
 -- love.graphics.setColor(0,0,0)  
end

return hero