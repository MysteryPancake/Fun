--- If a function returns several values, but you only need it's second value, skip the first with an underscore.

local _, variable = myFunction()

--- You can use select to avoid this as well.

local variable = select(2, myFunction())

--- This is often seen in loops with unused index variables.

for _, v in pairs({}) do
    print(tostring(v))
end

--- This can also be used in loops that do not require any of it's variables (i.e. counting iterations)

local x = 0
for _ in pairs({}) Do
    x = x + 1
end
print("There are " .. tostring(x) .. " iterations in the table.")
