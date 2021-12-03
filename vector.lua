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
function Vector:add(x,y,z)
  self.X = self.X + x
  self.Y = self.Y + y
  self.Z = self.Z + z
end 
function Vector:sub(x,y,z)
  self.X = self.X - x
  self.Y = self.Y - y
  self.Z = self.Z - z
end 
function Vector:mul(val)
  self.X = self.X * val
  self.Y = self.Y * val
  self.Z = self.Z * val
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
      self:mul(magnInv)
    end
end

function Vector:dot(other)
  return self.X * other:getX() + self.Y * other:getY() + self.Y * other:getY()
end
function Vector:cross(other)
  v = vector:new()
  
  v:setX(self.Y * other.getZ() - self.Z * other.getY())
  v:setY(self.Z * other.getX() - self.X * other.getZ())
  v:setZ(self.X * other.getY() - self.Y * other.getX())
  
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
 p:add(this.X,this.Y,this.Z)
 p:add(that.X,that.Y,that.Z)
 return p
end
--overload -
function Vector.__sub(this, that)
local p = Vector:new()
 p:add(this.X,this.Y,this.Z)
 p:sub(that.X,that.Y,that.Z)
 return p
end
function Vector.__mul(this, that)
 local v = this:clone()
 v:mul(that)
 return v
end
function Vector:Test()
  
p = Vector:new()
p:setX(5)
print(p:toString())
p:add(1,2,3)
print(p:toString())
p:sub(1,2,3)
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

end

return Vector