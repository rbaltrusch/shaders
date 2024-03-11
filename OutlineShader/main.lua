function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    local shaderCode = love.filesystem.read("outline_shader.frag")
    shader = love.graphics.newShader(shaderCode)
    shader:send("u_outline_colour", {0, 1, 0})
    love.graphics.setBackgroundColor({0, 0, 0, 0})
    screenshot = nil
    transform = love.math.newTransform()
    love.graphics.setShader(shader)
    player = {
        x = 0,
        y = 0,
        speed_x = 0,
        speed_y = 0,
        image = love.graphics.newImage("skull.png"),
    }
    shader:send("u_resolution", {player.image:getWidth(), player.image:getHeight()})
end

function love.update(dt)
    player.x = player.x + player.speed_x * dt
    player.y = player.y + player.speed_y * dt
end

function love.keypressed(key)
    if key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    elseif key == "escape" then
        love.event.quit(0)
    end

    if key == "right" then
        player.speed_x = 80
    elseif key == "left" then
        player.speed_x = -80
    elseif key == "up" then
        player.speed_y = -80
    elseif key == "down" then
        player.speed_y = 80
    end

    if key == "space" then
        if love.graphics.getShader() then
            love.graphics.setShader()
        else
            love.graphics.setShader(shader)
        end
    end
end

function love.keyreleased()
    player.speed_x = 0
    player.speed_y = 0
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0, 0)
    love.graphics.draw(player.image, love.math.newTransform(player.x, player.y, 0, 4))
end
