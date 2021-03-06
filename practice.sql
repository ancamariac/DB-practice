/*
 Se da baza de date cu structura 
Angajati (AngID, Nume, Prenume, Data_nasterii, Data_ang, Salariu, DepID, Supervizor)
Departamente (DepID, NumeDep, Manager)
Proiecte (PrID, NumeDep, DepID)
Lucreaza (AngID, PrID, NrOreSapt)
Intretinuti (IntrID, Nume, Prenume, Data_nasterii, AngID)
*/

-- 1. Gasiti numele si prenumele managerilor departamentelor ce au mai putin de 3 persoane in intretinere
select A.Nume, A.Prenume from Angajati A
join Departamente D on A.AngajatID = D.ManagerID
where (select count(I.IntretinutID) from Intretinuti I
where I.AngajatID = A.AngajatID) < 3 

select * from Angajati
select * from Departamente
select * from Intretinuti

-- 2. Gasiti managerii care au cel putin 2 persoane in subordine
select A.Nume, A.Prenume from Angajati A
join Departamente D on A.AngajatID = D.ManagerID
where (select count(*) from Angajati A1
where A1.SupervizorID = A.AngajatID) >=2

-- 3. Afisati proiectele la care lucreaza cei mai vechi 3 angajati ai companiei.
select P.NumeProiect from Proiecte P 
join AngajatiProiecte AP on AP.ProiectID=P.ProiectID
join Angajati A on AP.AngajatID = A.AngajatID
where A.DataAngajarii IN (select TOP 3 A1.DataAngajarii from 
Angajati A1 order by A1.DataAngajarii asc)
select * from Angajati
select * from AngajatiProiecte
select * from Proiecte

-- 4. Afisati angajatii care au lucrat mai mult de 100 de ore la proiecte din departamentul din care acestia fac parte.
select A.Nume, A.Prenume, A.AngajatID from Angajati A
where (select sum(AP.NrOreSaptamana) from 
AngajatiProiecte AP 
join Proiecte P on AP.ProiectID = P.ProiectID
where AP.AngajatID=A.AngajatID and 
P.DepartamentID = A.DepartamentID) > 100
select * from Angajati
select * from AngajatiProiecte
select * from Proiecte

-- 5. Afisati numele supervizorilor care au persoane in intretinere si nu lucreaza la niciun proiect.
select S.Nume, S.Prenume from Angajati S
where S.AngajatID IN (select A.SupervizorID from Angajati A)
AND S.AngajatID IN (select I.AngajatID from Intretinuti I)
AND S.AngajatID NOT IN (select AP.AngajatID from AngajatiProiecte AP)

-- 6. Gasiti numele si prenumele managerilor departamentelor ce au mai putin de 3 persoane in intretinere.
select A.Nume, A.Prenume from Angajati A 
join Departamente D on A.AngajatID = D.ManagerID 
where (select count(I.IntretinutID) from Intretinuti I where
I.AngajatID = A.AngajatID) < 3
select * from Angajati
select * from Intretinuti

-- 7. Afisati supervizorii care lucreaza la mai putin de 3 proiecte din departamentul din care fac parte.
select S.Nume, S.Prenume from Angajati S
join AngajatiProiecte AP on AP.AngajatID = S.AngajatID
where (select count(P.ProiectID) from AngajatiProiecte P
join Proiecte PR on PR.ProiectID = P.ProiectID  
where P.AngajatID = S.AngajatID AND PR.DepartamentID = S.DepartamentID) < 3
AND S.AngajatID IN (select A.SupervizorID from Angajati A)
group by S.Nume, S.Prenume

-- 8. Afisati angajatii care au salariul cel putin dublu fata de orice alt angajat din departamentul din care fac parte.
select A.Nume, A.Prenume from Angajati A 
where exists (select A1.Salariu from Angajati A1
where A1.DepartamentID = A.DepartamentID AND A.Salariu >= 2*A1.Salariu)
select * from Angajati

-- 9. Aflati proiectele la care lucreaza angajatii cu vechimea cea mai mare din departamentul din care proiectul face parte.
select P.NumeProiect, P.ProiectID from Proiecte P
join AngajatiProiecte AP on P.ProiectID = AP.ProiectID
join Angajati A on AP.AngajatID = A.AngajatID
where A.DataAngajarii = (select min(A1.DataAngajarii) from Angajati A1 
where A1.DepartamentID = A.DepartamentID)
select * from Angajati
select * from AngajatiProiecte

-- 10. Afisati angajatii care lucreaza cele mai multe ore la fiecare proiect in parte.
select A.Nume, A.Prenume, A.AngajatID, AP.ProiectID from Angajati A
join AngajatiProiecte AP on AP.AngajatID = A.AngajatID
where AP.NrOreSaptamana = (select max(A1.NrOreSaptamana) from AngajatiProiecte A1 
where AP.ProiectID = A1.ProiectID)
group by A.Nume, A.Prenume, A.AngajatID, AP.ProiectID
select * from AngajatiProiecte

-- 11. Afisati departamentele ce coordoneaza proiecte la care nu lucreaza si angajati ai altor departamente.
SELECT D.NumeDepartament, P.NumeProiect
FROM Departamente D
INNER JOIN Angajati A ON A.DepartamentID = D.DepartamentID
INNER JOIN Proiecte P ON D.DepartamentID = P.DepartamentID
WHERE P.ProiectID NOT IN (SELECT Pr.ProiectID
						  FROM Proiecte Pr
						  INNER JOIN Departamente De ON Pr.DepartamentID = De.DepartamentID
						  INNER JOIN Angajati A1 ON A1.DepartamentID = De.DepartamentID
						  WHERE A1.DepartamentID != A.DepartamentID)
group by D.NumeDepartament, P.NumeProiect

-- 12. Afisati toate numele proiectelor pentru care numarul de ore lucrate de toti angajatii este mai mare decat 50.
select P.NumeProiect, P.ProiectID from Proiecte P 
where (select sum(Ap.NrOreSaptamana) from AngajatiProiecte Ap where Ap.ProiectID = P.ProiectID) > 50

select * from AngajatiProiecte

-- 13. Gasiti angajatii care au cele mai multe persoane in intretinere.
SELECT CONCAT(a.Nume,' ',a.Prenume) as numeAngajat, 
       a.AngajatID, 
       t1.nrintretinuti AS nrIntretinuti 
FROM   Angajati a 
       LEFT JOIN (SELECT Count(i.IntretinutID) AS nrIntretinuti, 
                         i.AngajatID       AS angajatId 
                  FROM   Intretinuti i 
                  GROUP  BY angajatid) t1 
              ON t1.angajatid = a.AngajatID 
WHERE  t1.nrintretinuti = (SELECT Max(cnt) 
                          FROM   (SELECT Count(*) AS cnt 
                                  FROM   intretinuti i 
                                  GROUP  BY AngajatID) t2)
select * from Intretinuti

-- 14. Afisati numele departamentelor ce coordoneaza cel putin 3 proiecte la care lucreaza cel putin 5 angajati
Select D.NumeDepartament 
FROM Departamente D
JOIN Angajati A ON A.DepartamentID = D.DepartamentID
JOIN AngajatiProiecte AP ON A.AngajatID = AP.AngajatID
GROUP BY D.NumeDepartament
HAVING COUNT(AP.ProiectID)>=3 and Count(A.AngajatID)>=5

select * from Departamente
select * from AngajatiProiecte
select * from Proiecte

-- 15. Afisati toate proiectele pentru care numarul de ore lucrate de toti angajatii este mai mare decat numarul total de ore lucrate la proiectul cu id ul 1
select P.NumeProiect from Proiecte P 
where (select sum(AP.NrOreSaptamana) from Proiecte PR
join AngajatiProiecte Ap on PR.ProiectID = AP.ProiectID 
where PR.ProiectID = P.ProiectID) > (select sum(AP.NrOreSaptamana) from AngajatiProiecte AP
where AP.ProiectID = 1)

-- 16. Afisati numele managerilor care conduc mai mult de un departament in care nu exista niciun proiect in derulare
select A.Nume, A.Prenume from Angajati A
join Departamente D on A.AngajatID = D.ManagerID
where (select count(De.DepartamentID) from Departamente De
join Proiecte P on P.DepartamentID = De.DepartamentID
where D.DepartamentID = De.DepartamentID) = 0
select * from Angajati
select * from Departamente
select * from Proiecte

-- 17. Sa se determine lista angajatilor care lucreaza la toate proiectele departamentului de care apartin, la fiecare proiect avand cel putin 10 ore pe saptamana.
select A.Nume, A.Prenume from Angajati A
where (select count(AP.ProiectID) from AngajatiProiecte AP
where AP.AngajatID = A.AngajatID and AP.NrOreSaptamana >= 10) = (select count(P.ProiectID) from Proiecte P
where P.DepartamentID = A.DepartamentID)

select * from Angajati
select * from AngajatiProiecte
select * from Proiecte

-- 18. Afisati toti angajatii care lucreaza  mai multe ore pe un proiect decat supervizorii lor.
select A.Nume, A.Prenume from Angajati A
where (select sum(AP.NrOreSaptamana) from AngajatiProiecte AP
where AP.AngajatID = A.AngajatID) > (select sum(APS.NrOreSaptamana) from AngajatiProiecte APS
where APS.AngajatID = A.SupervizorID)

-- 19. Numele si prenumele angajatilor ce lucreaza mai mult de 45 ore la toate proiectele coordonate de departamentul 
-- din care angajatul face parte.
select A.Nume, A.Prenume from Angajati A 
where (select sum(AP.NrOreSaptamana) from AngajatiProiecte AP
join Proiecte P on AP.ProiectID = P.ProiectID
where P.DepartamentID = A.DepartamentID and AP.AngajatID = A.AngajatID) > 45

-- 20. Afisati lunile in care s-a nascut numarul minim de angajati de sex masculin, acel numar minim de angajati de sex masculin si numarul
-- de intretinuti nascuti in acele luni. 
select a2.Nume, a2.Prenume, d2.NumeDepartament, a2.Sex, month(a2.DataNasterii)
from Angajati a2 join Departamente d2 on a2.DepartamentID = d2.DepartamentID
where a2.Sex = 'M' and month(a2.dataNasterii) in (select month(a.DataNasterii)
FROM Angajati a
where a.sex = 'M'
group by month(a.DataNasterii)
having count(a.angajatID) <= all(select count(a1.angajatID) from Angajati a1 where a1.Sex = 'M' group by month(a1.DataNasterii)))

select a2.nume, a2.Prenume, d.NumeDepartament, a2.Sex, month(a2.DataNasterii) luna
from Angajati a2 join Departamente d on a2.DepartamentID = d.DepartamentID
where month(a2.dataNasterii)  in (
	select  month(a.dataNasterii) luna 
		from Angajati a 
		where a.sex ='m'
		group by month(a.dataNasterii)
		having count(a.angajatID) =  (
			select top 1 count(a2.angajatID)
			from Angajati a2
			where a2.sex = 'm'
			group by month(a2.dataNasterii)
		)
) and a2.sex = 'm'
-- 21. Gasiti numele si prenumele managerilor departamentelor, de sex masculin care au mai mult de 2 persoane in intretinere. Ordonati de la 
-- Z-A
select A.Nume, A.Prenume from Angajati A
join Departamente D on A.AngajatID = D.ManagerID
where A.Sex = 'M' and 
(select count(I.IntretinutID) from Intretinuti I
where I.AngajatID = A.AngajatID) >= 1
order by A.Nume desc
select * from Angajati
select * from Intretinuti
select * from Departamente