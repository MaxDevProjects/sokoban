local game = {}
currentLvl = 0
map = require("maps/level"..tostring(currentLvl))
hero = require("hero")
box = require("box")

game.level = map.layers[1].data
--game.level = map.layers[2].data
--game.level = map.layers[3].data




imgTiles = {}
game.tileTextures = {}
game.tileSheet = nil
game.tileType = {}

game.camera = {}
game.camera.column = 0
game.camera.line = 0

game.level.TILE_WIDTH = 64
game.level.TILE_HEIGHT = 64 

box.nb = {}
box.line = 0
box.column = 0

local tileType = nil

function game.level.isSolid(pID)
  
  tileType = game.tileType[pID]
  
  if tileType == "wall" or
     tileType == "box" then
    return true
  end
  return false
end

function game.Load()
  
  wScreen = love.graphics.getWidth()
  hScreen = love.graphics.getHeight()
  
  
  hero.Load(game)
  
  print("chargement des tuiles...")
  
  game.tileSheet = love.graphics.newImage("images/tileSheet.png")
  local nbCol = game.tileSheet:getWidth()/game.level.TILE_WIDTH
  local nbLine = game.tileSheet:getHeight()/game.level.TILE_HEIGHT
  
  game.tileTextures[0] = nil
  
  local l,c
  local id = 1
  
  for l=1, nbLine do
    for c=1, nbCol do
      game.tileTextures[id] = love.graphics.newQuad(
        (c-1) * game.level.TILE_WIDTH,
        (l-1) * game.level.TILE_HEIGHT,
        game.level.TILE_WIDTH,
        game.level.TILE_HEIGHT,
        game.tileSheet:getWidth(),
        game.tileSheet:getHeight()
      )      
      id = id + 1   
      --if id == 14 then
      --  hero.line = l
      --  hero.column = c
      --end
    end
  end
    
  print("fin de chargement des tuiles.")
  
  game.tileType[1]  ="wall" 
  game.tileType[2]  ="wall"
  game.tileType[8]  ="wall"
  game.tileType[16] ="wall"
  game.tileType[55] ="wall"
  game.tileType[56] ="wall"
  game.tileType[48] ="wall"
  game.tileType[42] ="wall"
  game.tileType[41] ="wall"
  game.tileType[54] ="wall"
  game.tileType[53] ="wall"
  game.tileType[47] ="wall"
  game.tileType[43] ="wall"
  game.tileType[9]  ="wall"
  game.tileType[18] ="wall"
  game.tileType[19] ="wall"
  game.tileType[20] ="wall"
  game.tileType[26] ="wall"
  game.tileType[23] ="wall"
  game.tileType[39] ="wall"
  game.tileType[34] ="wall"
  game.tileType[35] ="wall"
  game.tileType[36] ="wall"
  game.tileType[31] ="wall"
  game.tileType[17] ="wall"
  game.tileType[33] ="wall"
  game.tileType[24] ="wall"
  game.tileType[40] ="wall"
  game.tileType[37] ="wall"
  game.tileType[19] ="wall"
  game.tileType[20] ="wall"
  game.tileType[22] ="wall"
  game.tileType[24] ="wall"
  game.tileType[27] ="wall"
  game.tileType[21] ="wall"
  game.tileType[29] ="wall" 
  game.tileType[30] ="wall" 
  game.tileType[37] ="wall" 
  game.tileType[38] ="wall" 
  game.tileType[31] ="wall" 
  
  game.tileType[13] ="box"
  game.tileType[12] ="button"
  
  game.tileType[4] = "door"
  game.tileType[5] = "door"
  game.tileType[6] = "door"
  game.tileType[25] ="door"
  game.tileType[32] ="door"
  game.tileType[48] ="door"
  game.tileType[49] ="door"
  game.tileType[50] ="door"
  game.tileType[46] ="door"

  game.tileType[11] ="floor"
  game.tileType[10] ="floor"
  
  game.tileType[14] ="player"
  
  --for i=#game.level, 1, -1 do
  --      for j = #game.level, 1, -1 do
  --        local boxType = game.tileType[13]
  --        if boxType then
  --            box.nb = game.level[]
  --            print(box.nb)
  --      end
  --    end
  --  end
  
  local tiles = 25 --nombre de tuiles en longueur
  --print(tiles)
  
  local nbLines =#game.level/(#game.level/game.level.TILE_WIDTH) --taille d'une tuile 64
  --print(nbLines)
  local line, col
  local x,y
  for line = nbLines, 1, -1 do
    for col = 1, tiles do
      local tile= game.level[((line-1)*tiles)+col]
      local texQuad=game.tileTextures[tile]
      if tile == 13 then
        --print(tile) -- **imprime "13" 6 fois soit le nombre de la map level1**
        table.insert(box.nb, tile)
        print(#box.nb) --affichage du nombre de boite présente dans un niveau
        box.line = line
        box.column = col
        print("l:"..box.line,"c :"..box.column)
      end
        if tile ==  4 
        or tile ==  5
        or tile ==  6 
        or tile ==  25
        or tile ==  32 
        or tile ==  48
        or tile ==  49
        or tile ==  50 
        or tile ==46 then
          hero.line = line
          hero.column = col
          tile = 11
          print("lHero:"..hero.line,"cHero :"..hero.column)
        end
        --local x= ((col-1)*game.level.TILE_WIDTH) 
        --local y= ((line-1)*game.level.TILE_HEIGHT) 
        
        --love.graphics.draw(game.tileSheet, texQuad, x + game.camera.column, y + game.camera.line )
        
      end
    end
  end
  
function game.Update(dt)
  
  hero.Update(box,game.camera, game, game.level,dt)
  
  if love.keyboard.isDown("up") then
    game.camera.line = game.camera.line + 10
  end
  if love.keyboard.isDown("down") then
    game.camera.line = game.camera.line - 10
  end
  if love.keyboard.isDown("left") then
    game.camera.column = game.camera.column + 10
  end
  if love.keyboard.isDown("right") then
    game.camera.column = game.camera.column - 10
  end
  

  
end

function drawGame()
  
 
  love.graphics.setColor(255,255,255)
  --love.graphics.push()
  --love.graphics.scale(0.6,0.6)
  
  local tiles = 25 --nombre de tuiles en longueur
  --print(tiles)
  
  local nbLines =#game.level/(#game.level/game.level.TILE_WIDTH) --taille d'une tuile 64
  --print(nbLines)
  local line, col
  local x,y
  for line = nbLines, 1, -1 do
    for col = 1, tiles do
      local tile= game.level[((line-1)*tiles)+col]
      local texQuad=game.tileTextures[tile]
      if texQuad~=nil then
        local x= ((col-1)*game.level.TILE_WIDTH) 
        local y= ((line-1)*game.level.TILE_HEIGHT) 
        love.graphics.draw(game.tileSheet, texQuad, x + box.column + game.camera.column, y + box.line + game.camera.line )
        
      end
    end
  end
  hero.Draw(game.level, game.camera)
  
  love.graphics.print("nbBox :"..#box.nb)
  love.graphics.setColor(0,0,0)
  
  --love.graphics.pop()
  
  --darkness
  --love.graphics.setColor(0,0,0,200)
  --love.graphics.rectangle("fill", 0,0,wScreen, hScreen)
  --love.graphics.setColor(0,0,0)
  ----------
  --local mx = hero.line
  --local my = love.mouse.getY()
  --local c = math.floor(mx / game.level.TILE_WIDTH) + 1
  --local l = math.floor(my / game.level.TILE_HEIGHT) + 1
  --local ID = game.level[ ((l-1)*25) + c ]
  --love.graphics.setColor(255,255,255)
  --love.graphics.print("n°"..ID..tostring(game.tileType[ID]))
  --love.graphics.setColor(0,0,0)  
  
end

function game.Draw()
  drawGame()
  
end



return game