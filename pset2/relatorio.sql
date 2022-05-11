-- 1° Questão
select round(avg(f.salario), 2) as media_salarial,
d.nome_departamento
from funcionario f
inner join departamento d
on d.numero_departamento = f.numero_departamento
group by d.nome_departamento;

-- 2° Questão
select round(avg(f.salario), 2) as media_salarial, f.sexo
from funcionario f
group by f.sexo;

-- 3° Questão
select  d.nome_departamento,
concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff(year, data_nascimento, curdate()) as idade,
f.salario
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento;

-- 4° Questão
select concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
timestampdiff(year, data_nascimento, curdate()) as idade,
f.salario as salario_atual,
(case
when (f.salario < 35000) then round(f.salario + (f.salario * 0.2), 2)
else round(f.salario + (f.salario * 0.15), 2)
end) as salario_ajustado
from funcionario f;

--  5° Questão
with gerente as (
select concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome,
f.cpf
from funcionario f
)
select d.nome_departamento as departamento,
g.nome as nome_gerente,
concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff(year, data_nascimento, curdate()) as idade,
f.salario
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento
inner join gerente g on g.cpf = d.cpf_gerente
order by d.nome_departamento asc, f.salario desc;

-- 6° Questão
select d.nome_departamento,
concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
concat(dn.nome_dependente, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_dependente, 
timestampdiff(year, dn.data_nascimento, curdate()) as idade_dependente,
(case
when (dn.sexo = 'M') then 'Masculino'
else 'Feminino'
end) as sexo_dependente
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento
inner join dependente dn on dn.cpf_funcionario = f.cpf;

-- 7° Questão
select 
concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
dp.nome_departamento as departamento,
f.salario
from funcionario f
left join dependente d
on f.cpf = d.cpf_funcionario
inner join departamento dp
on f.numero_departamento = dp.numero_departamento
where d.cpf_funcionario is null;

-- 8° Questão
select dp.nome_departamento departamento, 
p.nome_projeto as projeto,
concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
concat(t.horas, 'h') as horas
from funcionario f 
inner join departamento dp
inner join projeto p 
inner join trabalha_em t
where f.numero_departamento = dp.numero_departamento 
and p.numero_projeto = t.numero_projeto 
and f.cpf = t.cpf_funcionario 
order by p.numero_projeto;

-- 9° Questão
select dp.nome_departamento departamento, 
p.nome_projeto, 
sum(distinct(t.horas)) as tempo_total
from trabalha_em t
inner join funcionario f
on t.cpf_funcionario = f.cpf
inner join departamento dp
on f.numero_departamento = dp.numero_departamento
inner join projeto p
on dp.numero_departamento = p.numero_departamento
group by p.nome_projeto;

-- 10° Questão
select dp.nome_departamento as departamento, 
round(avg(f.salario), 2) as media_salarial
from funcionario f
inner join departamento dp
on dp.numero_departamento = f.numero_departamento
group by dp.nome_departamento;

-- 11° Questão
select concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as funcionário, 
p.nome_projeto,
(case
when t.horas > 0 then (t.horas * 50)
else 0
end) as total_ganho
from funcionario f
inner join trabalha_em t
on f.cpf = t.cpf_funcionario
inner join projeto p
on t.numero_projeto = p.numero_projeto
order by t.horas desc;

-- 12° Questão
select dp.nome_departamento as departamento,
p.nome_projeto projeto,
f.primeiro_nome as funcionario, 
t.horas
from funcionario f 
inner join departamento dp
on f.numero_departamento = dp.numero_departamento
inner join projeto p
on dp.numero_departamento = p.numero_departamento
inner join trabalha_em t
on p.numero_projeto = t.numero_projeto
where t.horas = 0;

-- 13° Questão
select concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
(case
when (f.sexo = 'M') then 'Masculino'
else 'Feminino'
end) as sexo,
timestampdiff(year, f.data_nascimento, curdate()) as idade
from funcionario f
union
select concat(d.nome_dependente, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_dependente,
(case
when (d.sexo = 'M') then 'Masculino'
else 'Feminino'
end) as sexo,
timestampdiff(year, d.data_nascimento, curdate()) as idade
from dependente d 
inner join funcionario f
on d.cpf_funcionario = f.cpf
order by idade desc;

-- 14° Questão
select dp.nome_departamento as departamento,
count(f.numero_departamento) as numero_funcionarios
from funcionario f
inner join departamento dp
on f.numero_departamento = dp.numero_departamento
group by dp.nome_departamento;

-- 15° Questão
select distinct concat(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) as nome_funcionario,
dp.nome_departamento as departamento,
p.nome_projeto
from departamento dp
inner join projeto p 
inner join trabalha_em t 
inner join funcionario f 
where dp.numero_departamento = f.numero_departamento 
and p.numero_projeto = t.numero_projeto 
and t.cpf_funcionario = f.cpf
order by f.primeiro_nome asc;
