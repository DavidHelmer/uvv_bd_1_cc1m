-- 1 -> Fazer a média salarial dos funcionários para cada departamento
SELECT AVG(f.salario) AS media_salarial, d.nome_departamento
FROM funcionario f
INNER JOIN departamento d
ON f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento;

-- 2 -> Mostrar a media salárial dos homens e das mulheres
SELECT AVG(f.salario) AS media_salarial, f.sexo
FROM funcionario f
GROUP BY f.sexo;

-- 3 -> 
