--Structure (DDL) :
--le mail est unique (modifier la structure sur la table existante : ALTER)
ALTER TABLE employees ADD CONSTRAINT emailunique UNIQUE(email);
--le salaire est positif, non nul
ALTER TABLE employees ADD CONSTRAINT salarypostif CHECK(salary>0);
--le salaire max est supérieur au salaire min
ALTER TABLE jobs ADD CONSTRAINT maxsupérieurmin CHECK(max_salary>min_salary);
--un employé ne peut être son propre manager
ALTER TABLE jobs ADD CONSTRAINT paspropremanager CHECK(employee_id!=manager_id);

--Requêtes sur les données : DML (SELECT)
--Extraire le nombre d’employés par département.
SELECT d.department_id, d.department_name, count(e.employee_id) FROM employees e
join departments d ON e.department_id = d.department_id
group by d.department_id,d.department_name;

--Pour chaque département dont la somme des salaires est supérieure à 30 000 €, affichez le nom du département ainsi le sous-total des salaires de ses employés.
SELECT a.department_id, a.department_name, a.sum_salary 
FROM (SELECT d.department_id, d.department_name, SUM(e.salary) sum_salary
    FROM employees e
    join departments d ON e.department_id = d.department_id
    group by d.department_id,d.department_name
) a
WHERE sum_salary>30000;

--Extraire toutes les informations de l’employé qui gagne le moins.
SELECT * FROM employees
WHERE salary=(
    SELECT min(e.salary) min_salary
    FROM employees e
    )

--Extraire le plus gros salaire de chaque département en spécifiant le nom du département et en triant le résultat du plus gros au plus petit mais uniquement pour les salaires supérieurs à 5 000 €.
SELECT a.department_id, a.department_name, a.max_salary 
FROM (SELECT d.department_id, d.department_name, max(e.salary) max_salary
    FROM employees e
    join departments d ON e.department_id = d.department_id
    group by d.department_id,d.department_name
) a
WHERE max_salary>5000 
order by a.max_salary DESC;

--Comptez le nombre de pays dans lesquels il y a un département, sans doublon en affichant le nom du pays et celui de la région.

