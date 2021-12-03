Vector = {}


Vector.__index = Vector

function Vector:new()
      local vector = {}
      setmetatable(vector, Vector)
      vector.X = 0
      vector.Y = 0
      vector.Z = 0
      return vector
end
function Vector:setX(val)
 self.X = val
end
function Vector:setY(val)
 self.Y = val
end
function Vector:setZ(val)
 self.Z = val
end
function Vector:getX()
 return self.X
end
function Vector:getY()
 return self.Y
end
function Vector:getZ()
 return self.Z
end
function Vector:addUpdate(x,y,z)
  self.X = self.X + x
  self.Y = self.Y + y
  self.Z = self.Z + z
end 
function Vector:subUpdate(x,y,z)
  self.X = self.X - x
  self.Y = self.Y - y
  self.Z = self.Z - z
end 
function Vector:mulUpdate(val)
  self.X = self.X * val
  self.Y = self.Y * val
  self.Z = self.Z * val
end 
function Vector:scaleUpdate(x,y,z)
  self.X = self.X * x
  self.Y = self.Y * y
  self.Z = self.Z * z
end 
function Vector:scale(x,y,z)
  local v = self:clone()
  v:scaleUpdate(x,y,z)
  return v
end 
function Vector:rotate(axis,angle)
  

  local cosTheta = 1
  local sinTheta = 0
  
  if(angle == 90)
  then
    cosTheta = 0
    sinTheta = 1
  elseif(angle == 180)
  then
     cosTheta  = -1
     sinTheta  = 0
  elseif(angle == 270)
  then
     cosTheta  = 0
     sinTheta  = -1
  else  
     local radAngle = math.rad(angle)
     cosTheta       = math.cos(radAngle)
     sinTheta       = math.sin(radAngle)
  end
 
 local rotated = axis * cosTheta + (axis * self:dot(axis) * (1 - cosTheta)) + (axis:cross(self) * sinTheta)
 return rotated
end

function Vector:norm()
    v       = self:clone()
    v:normUpdate()
    return v;
end
function Vector:normUpdate()
  
    mag     = self:magn()
    if(mag > 0)
     then
      magnInv = 1 / mag
      self:mulUpdate(magnInv)
    end
end

function Vector:dot(other)
  return self.X * other:getX() + self.Y * other:getY() + self.Y * other:getY()
end
function Vector:cross(other)
  v = Vector:new()
  
  v:setX(self.Y * other:getZ() - self.Z * other:getY())
  v:setY(self.Z * other:getX() - self.X * other:getZ())
  v:setZ(self.X * other:getY() - self.Y * other:getX())
  
  return v
end
function Vector:clone()
    v = Vector:new()
    v:setX(self.X)
    v:setY(self.Y)
    v:setZ(self.Z)
    return v
end
function Vector:magn()
   return math.sqrt(self:magn2())
end
function Vector:magn2()
   return self.X * self.X + self.Y * self.Y + self.Z * self.Z
end  
function Vector:toString()
    return "X" .. self.X .. "Y" .. self.Y .. "Z" .. self.Z
end
--overload +
function Vector.__add(this, that)
local p = Vector:new()
 p:addUpdate(this.X,this.Y,this.Z)
 p:addUpdate(that.X,that.Y,that.Z)
 return p
end
--overload -
function Vector.__sub(this, that)
local p = Vector:new()
 p:addUpdate(this.X,this.Y,this.Z)
 p:subUpdate(that.X,that.Y,that.Z)
 return p
end
function Vector.__mul(this, that)
 local v = this:clone()
 v:mulUpdate(that)
 return v
end
function Vector:Test()
  
p = Vector:new()
p:setX(5)
print(p:toString())
p:addUpdate(1,2,3)
print(p:toString())
p:subUpdate(1,2,3)
print(p:toString())

p2 = Vector:new()
p2:setX(5)
p2:setY(6)
p2:setZ(7)

p3 = p + p2

print(p3:toString())
p3 = p3 - p2

print(p3:toString())

p3 = p + p2
print(p3:toString())

p3 = p3:norm()
print(p3:toString())
print(p3:magn())

p3 = p3*3
print(p3:magn())
print(p3:toString())

print("rot90")
local vtorot = Vector:new()
vtorot:setX(1)
vtorot:setY(1)
print(vtorot:toString())
local vaxis = Vector:new()
vaxis:setZ(1)
print(vaxis:toString())
local vrotated = vtorot:rotate(vaxis,90)
print(vrotated:toString())
end

return Vector