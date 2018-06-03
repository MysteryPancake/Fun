local var = 123
-- var is now a local variable set as 123.
-- ALWAYS, ALWAYS, ALWAYS use 'local' when defining variables.
-- THIS CODE IS WRONG AND IF YOU DO THIS THEN YOU ARE HUMAN FILTH:
var = 123

-- However, when redefining variables, you do not need to use local:
local var = 123
var = 456

-- Variables can have the following values:

-- NUMBERS:
local num = 1
local num = 2.5
local num = 0
local num = -1

-- BOOLEANS:
local var = true
local var = false

-- STRINGS:
local str = "test"
local str = ""

-- TABLES:
local tbl = {}

-- NIL:
local var = nil
local var

-- FUNCTIONS:
local func = function()
end
-- The code above does the same as this:
local function func()
end

-- There's a few more kinds of variables, but these are the main ones.

-- NUMBERS: Numbers are self explanatory.
local num = 123

-- This code will print 3:
print( 1 + 2 )
-- This code will print 2:
print( 3 - 1 )

-- BOOLEANS: Bools are simply true or false.
local bool = true

-- You can use bools in if statements:
if bool then
    -- bool must be true for this code to run.
end
-- You can invert bools like so:
print( not bool )

-- STRINGS: Strings are for humans to read.
local str = "Humans can read this."

-- You can join strings like so:
print( "abc" .. "123" )
-- The code above does the same as this:
print( "abc123" )

-- TABLES: Tables are for organizing lots of variables.
local tbl = { "foo", "bar" }

-- Tables can be accessed like so:
print( tbl[ 1 ] )
-- The code above will print "foo" because Lua starts tables at 1.
-- Lua is wrong. Tables start from 0 in every other language.
print( tbl[ 2 ] )
-- The code above will print "bar", because it's second in the table.

-- All values in tables can be accessed using loops.
-- This will print 1, "foo", and 2, "bar":
for k, v in ipairs( tbl ) do
    print( k, v )
end

-- If you are not using the key or value, set it as _.
-- This example does not need the key variable:
for _, v in ipairs( tbl ) do
    print( v )
end
-- This will print "foo" and "bar".

-- To set a value in a table, do this:
tbl[ 2 ] = "blah"
-- Now the table will equal this:
local tbl = { "foo", "blah" }

-- Tables can have keys other than numbers:
local tbl = { [ "string" ] = "foo", [ 123 ] = "bar" }
-- You can access string keys like so:
print( tbl.string )
-- This code will print "foo".

-- You can access other keys like so:
print( tbl[ 123 ] )
-- This will print "bar".

-- If your table has keys that aren't numbers, you must use pairs.
-- This code will not work:
for k, v in ipairs( tbl ) do
    print( k, v )
end
-- This code will work:
for k, v in pairs( tbl ) do
    print( k, v )
end

-- NIL: nil is the value of variables that aren't defined.
local var = nil

-- Setting variables as nil makes them local so you can avoid using global variables.
local var
-- Later, this code will NOT set a global variable:
var = 123

-- If statements do not like nil:
if var then
    -- This will never run.
end

-- FUNCTIONS: Functions can run repeated code easily.
local function foo()
    print( "bar" )
end

-- To run that function, do this:
foo()
-- The code above does the same as this:
print( "bar" )

-- You can pass variables to functions:
local function foo( bar )
    print( bar )
end
-- This code will now print "abc123":
foo( "abc123" )
