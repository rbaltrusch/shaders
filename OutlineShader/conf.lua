WIDTH, HEIGHT = 480, 320

function love.conf(table_)
    table_.window.height = HEIGHT
    table_.window.width = WIDTH
    table_.window.title = "OutlineShader"
    table_.window.vsync = 1
end
