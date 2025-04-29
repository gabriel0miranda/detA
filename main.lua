#!/usr/bin/lua

-- DetA, um pequeno programa em Lua que gera uma matriz quadrada aleatória e calcula seu determinante usando a fórmula geral.
--

-- Criando objeto de matriz (ver arquivo matrices.lua)
local matrix = require("matrices")

-- Criando variavel para o valor do determinante
local detA = 0

-- Função que gera as permutações dos números contidos em values(table) e insere em output(table)
local function permutacoes(values, num)
	if num == 0 then
		coroutine.yield(values)
	else
		for i = 1, num do
			values[i], values[num] = values[num], values[i]
			permutacoes(values, num - 1)
			values[i], values[num] = values[num], values[i]
		end
	end
end

-- Iterador para a função de permutações
local function perm(values)
  local n = table.getn(values)
  local co = coroutine.create(function () permutacoes(values,n) end)
  return function()
    local code, res = coroutine.resume(co)
    return res
  end
end

-- Função que calcula inversões em permutações. Retorna 1 se o número de inversões for par e -1 se o número de inversões for ímpar
local function inversoes(permutacao)
  local inv = 0
  for i=1, table.getn(permutacao) do
    for j=i, table.getn(permutacao) do
      if permutacao[i] > permutacao[j] then
        inv = inv+1
      end
    end
  end
  if inv%2 == 0 then
    return 1
  else
    return -1
  end
end

-- Criando matriz quadrada de dimensão aleatória chamando o método create()
matrix:create()

-- Imprimindo a matriz usando o método print()
print("Matriz:")
matrix:print()

-- Inserindo quantidade de colunas da matriz num array p
local p = {}
for i=1,matrix:getN() do
  table.insert(p,i)
end

-- Iterando sobre as permutações do número de colunas da matriz e somando o resultado das multiplicações dos valores segundo as permutações multiplicado também pelo valor retornado por inversoes() (UFFA!)
for l in perm(p) do
    local subResult = 1
    for k=1, matrix:getN() do
      subResult = subResult * matrix:getValue(k,l[k])
      --print("SUBRESULT:"..subResult)
    end
    detA = detA + inversoes(l)*subResult
    --print("DetA:"..detA)
end

print("Determinante: "..detA)
