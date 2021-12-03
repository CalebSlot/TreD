local vector = require("vector")

Point = {}


Point.__index = Point


function Point:new(vX,vY,vZ)
      local point = {}
      setmetatable(point, Point)
      point.X = vX or 0
      point.Y = vY or 0
      point.Z = vZ or 0
      point.c = nil
      return point
end
function Point:setX(val)
 self.X = val
end
function Point:setY(val)
 self.Y = val
end
function Point:setZ(val)
 self.Z = val
end
function Point:getX()
 return self.X
end
function Point:getY()
 return self.Y
end
function Point:getZ()
 return self.Z
end
function Point:add(x,y,z)
  self.X = self.X + x
  self.Y = self.Y + y
  self.Z = self.Z + z
end 
function Point:sub(x,y,z)
  self.X = self.X - x
  self.Y = self.Y - y
  self.Z = self.Z - z
end  

function Point:translate(translationVector)
  p = Point:new()
  p:add(self.X,self.Y,self.Z)
  p:add(translationVector:getX(),translationVector:getY(),translationVector:getZ())
  return p
end  

function Point:mid(endPoint)
  p = Point:new()
  local diff = endPoint - self
  p:setX(self.X + diff:getX() / 2)
  p:setY(self.Y + diff:getY() / 2)
  return p
end

function Point:toString()
    return "X" .. self.X .. "Y" .. self.Y .. "Z" .. self.Z
end
--overload +
function Point.__add(this, that)
 v = vector:new()
 v:add(this.X,this.Y,this.Z)
 v:add(that.X,that.Y,that.Z)
 return v
end
--overload -
function Point.__sub(this, that)
 v = vector:new()
 v:add(this.X,this.Y,this.Z)
 v:sub(that.X,that.Y,that.Z)
 return v
end

function Point:toCircle(radius,color)
  if(self.c ~=nil)
  then
    display.remove(self.c)
  end
  self.c = display.newCircle(self.X,self.Y,radius)
  self.c:setFillColor(unpack(color))

end

function Point:Test()
  
p = Point:new()
p:setX(5)
print(p:toString())
p:add(1,2,3)
print(p:toString())
p:sub(1,2,3)
print(p:toString())

p2 = Point:new()
p2:setX(5)
p2:setY(6)
p2:setZ(7)

v3 = p + p2

print(v3:toString())
v3 = v3 - p2

print(v3:toString())
end

return Point