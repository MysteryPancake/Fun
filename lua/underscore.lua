--- If a function returns several values, but you only need it's second value, skip the first with an underscore.

local _, variable = myFunction()

--- You can use select to avoid this as well.

local variable = select(2, myFunction())

--- This is often seen in loops with unused index variables.

for _, v in pairs({}) do
    print(tostring(v))
end
