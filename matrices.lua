local matrices = {
  mt = {},
  N = nil,
  M = nil
}

function matrices:create()
  math.randomseed(os.time())

  self.N = 10 --math.random(2,10)
  self.M = self.N

  for i=1,self.N do
    for j=1,self.M do
      self.mt[i*self.M + j] = math.random(-10,10)
    end
  end
end

function matrices:print()
  for i=1,self.N do
    for j=1,self.M do
      io.write(self.mt[i*self.M + j], " ")
    end
    io.write("\n")
  end
end

function matrices:getN()
  return self.N
end

function matrices:getM()
  return self.M
end

function matrices:getValue(n,m)
  return self.mt[n*self.M + m]
end

function matrices:permutations()
end

return matrices
