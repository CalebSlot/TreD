-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local Point  = require("point")
local Vector = require("vector")
local Matrix = require("matrix")
local Quad   = require("quad")

local p = Point:new()
local v = Vector:new()
local m = Matrix:new()


p:Test()
v:Test()
m:Test()

m:rotationZ(91)
print(m:toString())


print(p:toString())
print(v:toString())

p:setX(1)
p:setY(1)
p:setZ(0)

v:setX(3)
v:setY(2)
v:setZ(0)

local pT = p:translate(v)

local vectorDistance = pT - p

print(vectorDistance:toString())
print(vectorDistance:magn())
print(vectorDistance:magn2())

local q = Quad:new(0,0,50,200,100,200,100,100)
q:toMesh()
q:center():toCircle(20,{ 1, 0, 0, 1})

local primo   = Point:new(700,500)
local secondo = Point:new(700,1000) 
local terzo   = Point:new(1000,1000) 
local quarto  = Point:new(1000,500) 

q:updatePoints(primo:getX(),primo:getY(),secondo:getX(),secondo:getY(),terzo:getX(),terzo:getY(),quarto:getX(),quarto:getY())
paintLine = { 1, 1, 0, 1 }
mee = q:toMesh(true)

--print(c:toString())
local paint = { 1, 0, 0.1 }
mee.fill = paint
q:toWhire(5,paintLine)
m:rotationZ(10)

--a new quad, the original is preserved
q1  = m:multiplyQ(q)
mee = q1:toMesh()
paint[3] = paint[3] + 0.2
mee.fill = paint
c = q1:center()
print(c:toString())
c:toCircle(10,paintLine)

q1:toWhire(5,paintLine)
m:rotationZ(-10)
--global rotation to world origin (screen), the object local coordinates are modifieds
m:multiplyUpdateQ(q)
--clone the quad
mee = q:toMesh(true)
q:toWhire(5,paintLine)
mee:rotate(90)
paint[3] = paint[3] + 0.2
mee.fill = paint
m:multiplyUpdateQ(q)
mee = q:toMesh(true)
q:toWhire(5,paintLine)
paint[3] = paint[3] + 0.2
mee.fill = paint
paintLine = { 1, 1, 0, 1 }
q:toWhire(5,paintLine)
--mesh.fill = { type="image", filename="cat.png" }
