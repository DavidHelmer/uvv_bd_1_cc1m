<div align="center">

  # Problem Set 3

</div>

### Aluno: David Helmer Cândido | Professor: Abrantes Araújo Silva Filho | Monitor(a) Suellen Miranda Amorim

#### Atenção!! Este pset foi feito utilizando o banco de dados "uvv" previamente criado no pset 1.

## Querys Hierárquicas
> Neste pset foi feita uma query hierárquica, recursiva, para poder demonstrar claramente quais classificações eram filhas e quais eram pais umas das outra.
## Código utilizado:
~~~SQL
WITH RECURSIVE classificacao_geral
AS ( SELECT codigo, nome, codigo_pai, CAST (nome AS TEXT) AS arranjo
FROM classificacao
WHERE codigo_pai IS NULL
UNION ALL
SELECT c.codigo, cg.nome, c.codigo_pai, CAST(cg.arranjo || ' -> ' || c.nome AS TEXT)
FROM classificacao c
INNER JOIN classificacao_geral cg ON c.codigo_pai = cg.codigo)
SELECT arranjo AS "Arranjo", codigo_pai AS "Código pai"
FROM classificacao_geral cg
ORDER BY arranjo;
