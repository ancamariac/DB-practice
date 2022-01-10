-- 1. Calculati numarul total de ore alocate fiecarui proiect. 
select ProiectID, sum(NrOreSaptamana) as NrOre
from AngajatiProiecte
group by ProiectID

-- 2. Aflati cate persoane au fost angajate in fiecare an.
select distinct year(DataAngajarii), count(*) as NrAngajati
from Angajati
WHERE year(DataAngajarii) IS NOT NULL -- s-a pus asta pentru ca sunt cativa angajati care nu au specificata data angajarii
group by year(DataAngajarii)

-- 3. Aflati cate persoane au fost angajate din 2007 pana in prezent. 
SELECT COUNT(*)
AS NrPersoaneAngajate FROM Angajati 
WHERE Year(DataAngajarii) >= 2007

-- 4. Aflati cate persoane are in intretinere fiecare angajat. 
select AngajatID, count(*) as NrIntretinuti
from Intretinuti
group by AngajatID
select * from Intretinuti

-- 5. Calculati numarul de angajati pentru fiecare departament. 
select DepartamentID, count(*) as NrAngaj
from Angajati
group by DepartamentID
select * from Angajati

-- 6. Afisati ID-urile departamentelor care au mai mult de 5 angajati. 
select DepartamentID, count(AngajatID) as nrAngaj
from Angajati
group by DepartamentID
having count(AngajatID) > 5

-- 7. Afisati ID-urile proiectelor la care se lucreaza mai mult de 20 ore/saptamana. 
select ProiectID, sum(NrOreSaptamana) nrOre
from AngajatiProiecte 
group by ProiectID
having sum(NrOreSaptamana) > 20

--1.	Afisati media orelor lucrate la proiectul cu id-ul 3.
select avg(NrOreSaptamana) as mediaOrelor 
from AngajatiProiecte
where ProiectID = 3
group by ProiectID

--2.	Afisati numarul de ore lucrate in total pe proiecte de catre toti angajatii.
select sum(NrOreSaptamana) nrOre
from AngajatiProiecte

--3.	Afisati angajatii care lucreaza mai mult de 20h la cel putin 3 proiecte.
select AngajatID, sum(NrOreSaptamana) as nrOre, count(ProiectID) as nrProiecte
from AngajatiProiecte 
group by AngajatID
having sum(NrOreSaptamana) > 20 and count(ProiectID) >=3 

--4.	Afisati angajatii care supervizeaza mai mult de 5 persoane.
select AngajatID, count(SupervizorID) 
from Angajati
group by AngajatID
having count(SupervizorID) > 5
select * from Angajati

SELECT SupervizorID FROM Angajati 
WHERE SupervizorID IS NOT NULL 
GROUP BY SupervizorID HAVING COUNT(Nume) > 5

select angajatid from Angajati group by AngajatID having count(SupervizorID) > 5

--5.	Afisati departamentul cu cei mai multi angajati (se presupune ca este unul singur) 
select top 1 DepartamentID from Angajati group by DepartamentID order by count(angajatID)DESC