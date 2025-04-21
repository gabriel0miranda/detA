#!/usr/bin/lua

-- DetA, um pequeno programa em Lua que gera uma matriz quadrada aleatória e calcula seu determinante usando a fórmula geral.
--

-- Criando objeto de matriz (ver arquivo matrices.lua)
local matrix = require("matrices")

-- Criando tabela para as permutações do num de colunas da matriz
local p = {{}}

-- Função que gera as permutações dos números contidos em values(table) e insere em output(table)
local function permutacoes(values, num, output)
	if num == 0 then
		table.insert(output,values)
	else
		for i = 1, num do
			values[i], values[num] = values[num], values[i]
			permutacoes(values, num - 1, output)
			values[i], values[num] = values[num], values[i]
		end
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
--matrix:print()

-- Inserindo quantidade de colunas da matriz no primeiro array da tabela das permutações
for i=1,matrix:getN() do
  table.insert(p[1],i)
end

-- Executando função que gera as permutações do num de colunas da matriz
permutacoes(p[1],table.getn(p[1]),p)

for i=1, table.getn(p) do
  print(table.concat(p[i],", "))
  print(inversoes(p[i]))
end



