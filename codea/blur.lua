function setup()
    backingMode( RETAINED )
    parameter.number( "Blur", 0, 255, 240 )
end
    
function draw()
    tint( 255, 255 - Blur )
    sprite( CAMERA, WIDTH / 2, HEIGHT / 2, math.min( spriteSize( CAMERA ), WIDTH ) )
end
