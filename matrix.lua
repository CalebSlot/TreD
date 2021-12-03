local vector = require("vector")
local quad   = require("quad")

Matrix = {}



Matrix.__index = Matrix

function Matrix:new()
      local matrix = {}
      setmetatable(matrix, Matrix)
      matrix.X = vector:new()
      matrix.Y = vector:new()
      matrix.Z = vector:new()
      return matrix
end
function Matrix:getX()
  return self.X
end
function Matrix:getY()
  return self.Y
end
function Matrix:getZ()
  return self.Z
end
function Matrix:multiplyV(vectorV)
  
  v = vector:new()
  v:setX(self.X:getX() * vectorV:getX() + self.Y:getX() * vectorV:getY() + self.Z:getX() * vectorV:getZ())
  v:setY(self.X:getY() * vectorV:getX() + self.Y:getY() * vectorV:getY() + self.Z:getY() * vectorV:getZ())
  v:setZ(self.X:getZ() * vectorV:getX() + self.Y:getZ() * vectorV:getY() + self.Z:getZ() * vectorV:getZ())
  return v
  
end

function Matrix:multiplyQ(quadQ)
  q = quad:new(quadQ:getFirst():getX(),quadQ:getFirst():getY(),quadQ:getSecond():getX(),quadQ:getSecond():getY(),quadQ:getThird():getX(),quadQ:getThird():getY(),quadQ:getFourth():getX(),quadQ:getFourth():getY())  
  self:multiplyUpdateQ(q)
  return q
end

function Matrix:multiplyUpdateQ(quadQ)
  
  primo   = quadQ:getFirst()
  secondo = quadQ:getSecond()
  terzo   = quadQ:getThird()
  quarto  = quadQ:getFourth()
  
  quadQ:updateFirst(self.X:getX() * primo:getX() + self.Y:getX() * primo:getY() + self.Z:getX() * primo:getZ(),  self.X:getY() * primo:getX() + self.Y:getY() * primo:getY() + self.Z:getY() * primo:getZ())

 quadQ:updateSecond(self.X:getX() * secondo:getX() + self.Y:getX() * secondo:getY() + self.Z:getX() * secondo:getZ(),  self.X:getY() * secondo:getX() + self.Y:getY() * secondo:getY() + self.Z:getY() * secondo:getZ())
 
  quadQ:updateThird(self.X:getX() * terzo:getX() + self.Y:getX() * terzo:getY() + self.Z:getX() * terzo:getZ(),  self.X:getY() * terzo:getX() + self.Y:getY() * terzo:getY() + self.Z:getY() * terzo:getZ())
  
   quadQ:updateFourth(self.X:getX() * quarto:getX() + self.Y:getX() * quarto:getY() + self.Z:getX() * quarto:getZ(),  self.X:getY() * quarto:getX() + self.Y:getY() * quarto:getY() + self.Z:getY() * quarto:getZ())
  
end

function Matrix:rotationZ(zRot)
  
  
  cos = 1
  sin = 0
  
  if(zRot == 90)
  then
    cos = 0
    sin = 1
  elseif(zRot == 180)
  then
     cos  = -1
     sin  = 0
  elseif(zRot == 270)
  then
     cos  = 0
     sin  = -1
  else  
    zRot = math.rad(zRot)
    cos  = math.cos(zRot)
    sin  = math.sin(zRot)
  end
  
  self.X:setX(cos)
  self.X:setY(sin)
  self.X:setZ(0)
  
  self.Y:setX(-sin)
  self.Y:setY(cos)
  self.Y:setZ(0)
  
  self.Z:setX(0)
  self.Z:setY(0)
  self.Z:setZ(1)
  
end
  --TODO: build precalculated 90 180 270 matrixes
function Matrix:toString()
  v1 = self:getX()
  v2 = self:getY()
  v3 = self:getZ()
  return "X[" .. v1:toString() .. "]\nY[" .. v2:toString() .. "]\nZ[" .. v3:toString() .. "]"
end

function Matrix:Test()
  m = Matrix:new()
  print(m:toString())
  m:rotationZ(90)
  print(m:toString())
  v = vector:new()
  v:setX(1)
  v:setY(1)
  v:setZ(1)
  v = m:multiplyV(v)
  print(v:toString())
end

return Matrix