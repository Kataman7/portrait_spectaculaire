function set_room(x)
    map = {}
    map.room = x
    map.spawn = {}
    map.spawn.x = {50,294,3031,1034,827,370, 0}
    map.spawn.y = {300,2157,156,851,634,322, 0}
    map.sound = {}
    map.sound.x = {1979, 2554, 329, 3192, 2233, 122, 0}
    map.sound.y = {954, 348, 1265, 555, 2702, 2135, 0}
    map.texture = {"png/room"..map.room..".png"}

    background = love.graphics.newArrayImage(map.texture)
end

function set_player()
    player = {}
    player.x = map.spawn.x[map.room]
    player.y = map.spawn.y[map.room]
    player.speed = 2
    player.texture = {"png/main_right.png"}

    main = love.graphics.newArrayImage(player.texture)
end

function next_room()
    if map.room == 1 then -- 1979,1062 - 2056 954
        if (1979 <= player.x and player.x <= 2056) and (954 <= player.y and player.y <= 1062) then
            can_print_text = true
            teleport()
        else can_print_text = false end
    elseif map.room == 2 then
        if (2554 <= player.x and player.x <= 2661) and (348 <= player.y and player.y <= 456) then
            can_print_text = true
            teleport()
        else can_print_text = false end
    elseif map.room == 3 then
        if (329 <= player.x and player.x <= 400) and (1265 <= player.y and player.y <= 1458) then
            can_print_text = true
            teleport()
        else can_print_text = false end
    elseif map.room == 4 then
        if (3192 <= player.x and player.x <= 3286) and (555 <= player.y and player.y <= 652) then
            can_print_text = true
            teleport()
        else can_print_text = false end
    elseif map.room == 5 then
        if (2233 <= player.x and player.x <= 2358) and (2702 <= player.y and player.y <= 2838) then
            can_print_text = true
            teleport()
        else can_print_text = false end
    elseif map.room == 6 then
        if (122 <= player.x and player.x <= 231) and (2135 <= player.y and player.y <= 2306) then
            can_print_text = true
            teleport()
        else can_print_text = false end
    else can_print_text = false end 
        
end

function teleport()
    text = "Passer la porte? [espace]"

    if love.keyboard.isDown("space") then
        set_room(map.room+1)
        set_player()
        if map.room == 3 then position("left")
        else position("right") end
    end
end

function music()
    if not source:isPlaying( ) then
	    love.audio.play( source )
	end
end

function volume()
    player_door = (math.sqrt((player.x - map.sound.x[map.room])^2+(player.y - map.sound.y[map.room])^2))
    spawn_door = (math.sqrt((map.spawn.x[map.room] - map.sound.x[map.room])^2+(map.spawn.y[map.room] - map.sound.y[map.room])^2))
    source:setVolume(1-(player_door/spawn_door))
end

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    source = love.audio.newSource("KatanaZero-Nocturne.mp3", "stream")
    set_room(1)
    set_player()

    Camera = require "libraries/camera"
    cam = Camera(player.x, player.y)
end

function love.update(dt)

    volume()
    next_room()
    music()

    if love.keyboard.isDown("up") then
        player.x = player.x - ((math.sqrt(3))/2)*player.speed
        player.y = player.y - (1/2)*player.speed
        position("left")
    elseif love.keyboard.isDown("down") then
        player.x = player.x + ((math.sqrt(3))/2)*player.speed
        player.y = player.y + (1/2)*player.speed
        position("right")
    elseif love.keyboard.isDown("left") then
        player.x = player.x - ((math.sqrt(3))/2)*player.speed
        player.y = player.y + (1/2)*player.speed
        position("left")
    elseif love.keyboard.isDown("right") then
        player.x = player.x + ((math.sqrt(3))/2)*player.speed
        player.y = player.y - (1/2)*player.speed
        position("right")
    end

    cam:lookAt(player.x, player.y)
    print(player.x, player.y)
end

function love.draw()
    cam:attach()
        if map.room == 7 then
            love.graphics.setBackgroundColor( 1, 1, 1 )
        else
            love.graphics.draw(background, 0, 0)
            love.graphics.draw(main, player.x, player.y)
            if can_print_text == true then love.graphics.print({{185/240, 202/240, 222/240}, text},player.x+100,player.y-100, 0, 2, 2) end
        end
    cam:detach()
end

function position(pos)
    player.texture = {"png/main_"..pos..".png"}
    main = love.graphics.newArrayImage(player.texture)
end