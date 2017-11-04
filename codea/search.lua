local function searchProjects()
    hideKeyboard()
    output.clear()
    matches = {}
    for _, p in ipairs( listProjects( "documents" ) ) do
        for _, t in ipairs( listProjectTabs( p ) ) do
            local code = readProjectTab( p .. ":" .. t )
            local i = 1
            for l in string.gmatch( code, "([^\r\n]*)\r?\n?" ) do
                if string.find( l, Search ) then
                    table.insert( matches, { project = p, tab = t, line = i, code = l } )
                    print( p, t, i, l )
                end
                i = i + 1
            end
        end
    end
    searched = true
end

local function drawSearch( y )
    fill( 65, 150, 190 )
    fontSize( 27 )
    local w, h = textSize( "Search(" )
    text( "Search(", 36, y )
    local w2, h2 = textSize( Search )
    fill( 255 )
    text( Search, 36 + w, y )
    if isKeyboardShowing() then
        fill( 0, 155, 225, 155 + math.sin( ElapsedTime * 6 ) * 100 )
        rect( 36 + w + w2, y, 3, h2 )
    end
    fill( 65, 150, 190 )
    text( ")", 36 + w + w2, y )
    return y - h2
end

local function drawLabel( col, str, y )
    fill( col )
    fontSize( 17 )
    local _, h = textSize( str )
    text( str, 36, y )
    return y - h
end

local function drawLine( str, y )
    fill( 110 )
    fontSize( 11 )
    local w = textSize( str )
    text( str, 24 - w, y )
end

function setup()
    supportedOrientations( CurrentOrientation )
    displayMode( FULLSCREEN )
    parameter.text( "Search", "" )
    parameter.action( "Go", searchProjects )
    font( "Inconsolata" )
    textMode( CORNER )
    showKeyboard()
    matches = {}
    searched = false
    scroll = HEIGHT - 33
end

function draw()
    background( 30, 32, 40 )
    fill( 20, 22, 30 )
    rect( 0, 0, 27, HEIGHT )
    local y = drawSearch( scroll )
    if searched then
        y = drawLabel( color( 220, 130, 120 ), #matches .. "_MATCHES", y )
        local prevTitle = ""
        for _, match in ipairs( matches ) do
            local title = "-- " .. match.project .. "/" .. match.tab .. ":"
            if title ~= prevTitle then
                y = drawLabel( color( 30, 160, 140 ), title, y )
            end
            prevTitle = title
            drawLine( match.line, y )
            y = drawLabel( color( 225, 230, 245 ), match.code, y )
        end
    end
end

function touched( touch )
    if touch.state == BEGAN and touch.y > scroll - 16 then
        showKeyboard()
    else
        scroll = scroll + touch.deltaY
    end
end

function keyboard( key )
    if key == "\n" then
        searchProjects()
    elseif key == BACKSPACE then
        Search = string.sub( Search, 1, -2 )
    else
        Search = Search .. key
    end
end
