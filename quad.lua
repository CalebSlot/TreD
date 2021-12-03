
local Point = require("point")

Quad = {}

Quad.__index = Quad

function Quad:new(X1,Y1,X2,Y2,X3,Y3,X4,Y4)
      local quad = {}
      setmetatable(quad, Quad)
      quad.first     = Point:new(X1 or 0,Y1 or 0,0)
      quad.second    = Point:new(X2 or 0,Y2 or 0,0)
      quad.third     = Point:new(X3 or 0,Y3 or 0,0)
      quad.fourth    = Point:new(X4 or 0,Y4 or 0,0)
      quad.mesh      = nil
      quad.updated   = false
      return quad
end

function Quad:getFirst()
 return self.first
end

function Quad:getSecond()
 return self.second
end

function Quad:getThird()
 return self.third
end

function Quad:getFourth()
 return self.fourth
end

function Quad:updateFirst(X,Y)
    self.first:setX(X)
    self.first:setY(Y)
    self.updated = true
end

function Quad:updateSecond(X,Y)
    self.second:setX(X)
    self.second:setY(Y)
    self.updated = true
end

function Quad:updateThird(X,Y)
    self.third:setX(X)
    self.third:setY(Y)
    self.updated = true
end

function Quad:updateFourth(X,Y)
    self.fourth:setX(X)
    self.fourth:setY(Y)
    self.updated = true
end

function Quad:updatePoints(X1,Y1,X2,Y2,X3,Y3,X4,Y4)

      self.first:setX(X1 or 0)
      self.second:setX(X2 or 0)
      self.third:setX(X3 or 0)
      self.fourth:setX(X4 or 0)
      
      self.first:setY(Y1 or 0)
      self.second:setY(Y2 or 0)
      self.third:setY(Y3 or 0)
      self.fourth:setY(Y4 or 0)
      self.updated = true
end
function Quad:toMesh(clone)
  local mesh = nil
  local clona = clone or false
  if(clona == false and self.mesh ~= nil)
  then
    mesh = self.mesh
   
    if(self.updated == true)
    then
     mesh.path:setVertex( 1, self.first:getX(), self.first:getY() )
     mesh.path:setVertex( 2, self.second:getX(), self.second:getY())
     
     mesh.path:setVertex( 4, self.third:getX(), self.third:getY())
     mesh.path:setVertex( 5, self.fourth:getX(), self.fourth:getY())
     
     middleTop = self.first:mid(self.fourth)
     mesh.path:setVertex( 3, middleTop:getX(), middleTop:getY())
     
     self.updated = false
     --mesh:translate( xmin / 2,ymin / 2)
    end
  
  else
  
  middleTop = self.first:mid(self.fourth)

  mesh = display.newMesh(
    {
        x = 0,
        y = 0,
        mode = "indexed",
        vertices = {
            self.first:getX(),self.first:getY(), self.second:getX(),self.second:getY(), middleTop:getX(),middleTop:getY(), self.third:getX(),self.third:getY(), self.fourth:getX(),self.fourth:getY()
        },
        indices = {
            1,2,3,
            2,3,4,
            3,4,5
        }
    })
 
     xmin = self.first:getX()
     if(xmin > self.second:getX())
      then
        xmin = self.second:getX()
     end
     ymin = self.first:getY()
     if(ymin > self.fourth:getY())
      then
        ymin = self.fourth:getY()
     end

   --  mesh:translate( xmin / 2,ymin / 2)
   mesh:translate(mesh.path:getVertexOffset())
  self.mesh = mesh
  end

 return mesh
end

return Quad