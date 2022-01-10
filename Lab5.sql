-- Exercitii lab
--1. Gasiti angajatii care castiga cel mai mare salariu pentru fiecare departamet.Sortati in
--ordinea descrescatoare a salariului. 
select A.Nume, A.Prenume, A.Salariu, A.DepartamentID
from Angajati A 
where A.Salariu in (select max(A2.Salariu) from Angajati A2
where A2.DepartamentID = A.DepartamentID)
order by A.Salariu desc

SELECT a.nume, a.prenume, a.salariu, a.DepartamentID
FROM angajati a
WHERE a.salariu IN
(SELECT max(a2.salariu) FROM angajati a2
WHERE a2. departamentID=a.departamentID)
ORDER BY a.salariu DESC

SELECT a.nume,a.prenume,a.salariu,a.DepartamentID
FROM Angajati A
WHERE a.salariu=(SELECT max(aa.salariu) FROM Angajati aa WHERE
aa.DepartamentID=a.DepartamentID )
ORDER BY a.Salariu DESC

-- 2. Gasiti cei mai recenti angajati din fiecare departament.Ordonati dupa data angajarii. 
SELECT nume, prenume, departamentID, dataangajarii
FROM angajati
WHERE (dataangajarii) IN
(SELECT max(a2.dataangajarii) FROM angajati a2
WHERE a2. departamentID=angajati.departamentID
GROUP BY departamentID)
ORDER BY dataangajarii

-- 3. Afisati numele, prenumele, salariul si numele departamentului la care lucreaza pentru
--orice angajat care castiga un salariu mai mare decat media pentru departamentul din care face
--parte. 

select A.Nume, A.Prenume, A.Salariu, D.NumeDepartament
from Angajati A
join Departamente D on A.DepartamentID = D.DepartamentID
where A.Salariu > (select avg(A2.Salariu) from Angajati A2
where A2.DepartamentID = A.departamentID
)

-- 4. Listati toate departamentele care nu au angajati (folositi o subcerere)
select D.NumeDepartament 
from Departamente D
where D.DepartamentID IN 
(select A.DepartamentID from Angajati A where A.DepartamentID = NULL) 

--  Sa se obtina numele primilor 5 angajati care au salariul cel mai mare.
-- Rezultatul se va ordona descrescator dupa salariu. 
SELECT I.Nume, I. Salariu
FROM (SELECT TOP 5 A.Nume as Nume, A.Prenume as Prenume, A.Salariu as
 Salariu
FROM Angajati A
ORDER BY A.Salariu DESC ) as I 


-- 5. Afisati numele , prenumele si salariul primilor trei angajati in functie de salariul
--castigat.
select A.Nume, A.Prenume, A.Salariu
from (select distinct top 3 An.Nume, An.Prenume, An.Salariu as Salariu
from Angajati An
order by An.Salariu DESC) as A

-- 6. In ce an s-au angajat cei mai multi in companie ? Afisati anul si numarul angajatilor. 
SELECT year(dataangajarii), count(*)
FROM angajati
GROUP BY year(dataangajarii)
HAVING count (*) IN (SELECT TOP 1 count(*)
FROM angajati
GROUP BY year(dataangajarii)
ORDER BY 1 DESC)

-- 7. --Aflati angajatii care au salariul mai mare decat vreun angajat al departamentului cu
-- ID-ul 2 si care nu fac parte din acest departament.
select A.Nume, A.Prenume
from Angajati A
where A.Salariu > ANY(select A2.Salariu from Angajati A2 where A2.DepartamentID = 2)
AND A.DepartamentID != 2


-- 8. Gasiti angajatii care au salariul mai mare decat toti angajatii departamentului cu ID-ul 5.
select A.Nume, A.Prenume
from Angajati A
where A.Salariu > (select max(A2.Salariu) 
from Angajati A2 where A2.DepartamentID = 5)

-- 9.Gasiti numele, data angajarii si salariul angajatilor al caror salariu este mai mare decat
--cel mai mare salariu al vreunei persoane angajate dupa data de 01.01.2007.
select A.Nume, A.DataAngajarii, A.Salariu
from Angajati A
where A.Salariu > (select max(A2.Salariu) from 
Angajati A2 where A2.DataAngajarii > '01.01.2007')

--10. Gasiti angajatii care nu au subordonati.
select A.Nume, A.Prenume
from Angajati A
where A.AngajatID NOT IN (select A2.AngajatID
from Angajati A2 join Angajati A3 
on A2.AngajatID = A3.SupervizorID
group by A2.AngajatID)



--11. Gasiti angajatii care au cel putin 2 persoane in intretinere. 
select A.Nume, A.Prenume
from Angajati A
where (select count(*) from Angajati A2
join Intretinuti I on I.AngajatID = A2.AngajatID
where A.AngajatID = A2.AngajatID) >=2

SELECT a.nume, a.prenume
FROM angajati a INNER JOIN Intretinuti i ON a.AngajatID=i.angajatid
GROUP BY i.AngajatID, a.Nume, a.Prenume
HAVING count(i.IntretinutID) >=2-- 12. Afisati numele si departamentul angajatilor care ii sunt subordonati angajatului cu
-- numele Popescu. 
select A.Nume, A.Prenume, D.NumeDepartament
from Angajati A
join Departamente D on A.DepartamentID = D.DepartamentID
where A.SupervizorID = (select A2.AngajatID from Angajati A2
where A2.Nume = 'Popescu')

-- 13. Sa se afiseze numele, prenumele si salariul angajatului insotit de codul managerului
-- pentru angajatii al caror salariu este mai mic de 1500 lei. 
select A.Nume, A.Prenume, A.Salariu, D.ManagerID
from Angajati A 
join Departamente D on A.DepartamentID = D.DepartamentID
where A.Salariu < 1500

-- 14. Sa se afiseze numele salariatilor care lucreaza intr-un departament in care exista cel
-- putin un angajat cu salariul mai mare de 2000 lei. 
select A.Nume, A.Prenume from Angajati A
join Departamente D on A.DepartamentID = D.DepartamentID
where (select max(A2.Salariu) from Angajati A2 
where A2.DepartamentID = D.DepartamentID) > 2000

-- 15. --Sa se afiseze numele si salariul angajatilor al caror salariu este mai mare decat
-- salariile medii din toate departamentele.
select A.Nume, A.Prenume, A.Salariu
from Angajati A 
where A.Salariu > (Select AVG(A2.Salariu) from Angajati A2
where A2.DepartamentID = A.DepartamentID)

-- 16. Exercitiu suplimentar. Sa se afiseze numele, prenumele si media nr de ore lucrate de
-- fiecare angajat pe saptamana la toate proiectele la care lucreaza.SELECT X.Nume, X.Prenume, Y.MedieOreSapt
FROM Angajati X JOIN
(SELECT AngajatID, AVG(NrOreSaptamana) AS MedieOreSapt
FROM AngajatiProiecte
GROUP BY AngajatID) Y
ON X.AngajatID = Y.AngajatID