function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setFont(love.graphics.newFont("assets/pico8.ttf", 60))
    love.mouse.setVisible(false)
    sfx0 = love.audio.newSource("assets/sfx0.ogg")
    sfx1 = love.audio.newSource("assets/sfx1.ogg")
    idx = 1
    sheet="undef"

    sfx1:play()
end

function love.filedropped(file)
    sfx0:play()
    local w = assert(io.open(file:getFilename(), "rb"))
    local x = love.filesystem.newFileData(w:read("*a"), "")
    sheet = love.graphics.newImage(x)
    w:close()
end

function love.update(dt)
    local x, y = love.mouse.getPosition()
	c = math.floor(x / (8*CONF.cameraZoom))
	r = math.floor(y / (8*CONF.cameraZoom))
	idx = ((8*r)+c)+1
end

function love.draw(dt)
	love.graphics.setColor(255, 255, 255, 255)
    if sheet == "undef" then
        love.graphics.printf("drag & drop sheet",0,10*CONF.cameraZoom, CONF.width*CONF.cameraZoom, "center")
    else
        love.graphics.draw(sheet,0,0,0,CONF.cameraZoom,CONF.cameraZoom)

        love.graphics.setColor(125, 255, 122, 200)
        love.graphics.printf(idx, 0,(CONF.height*CONF.cameraZoom)-58, CONF.width*CONF.cameraZoom, "center")

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle("line", c*8*CONF.cameraZoom,r*8*CONF.cameraZoom, 8*CONF.cameraZoom, 8*CONF.cameraZoom)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle("line", (c*8*CONF.cameraZoom)+1 , (r*8*CONF.cameraZoom)+1, (8*CONF.cameraZoom)-2, (8*CONF.cameraZoom)-2)
        love.graphics.setColor(255, 0, 30, 255)
        love.graphics.rectangle("line", (c*8*CONF.cameraZoom)+2 , (r*8*CONF.cameraZoom)+2, (8*CONF.cameraZoom)-4, (8*CONF.cameraZoom)-4)
    end
end
