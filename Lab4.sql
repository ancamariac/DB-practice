-- 1. Afisati toate numele proiectelor pentru care numarul de ore lucrate de toti angajatii este mai
--mare decat 50.
select P.NumeProiect 
from Proiecte P
join AngajatiProiecte AP on AP.ProiectID = P.ProiectID
group by P.NumeProiect
having sum(AP.NrOreSaptamana) > 50

SELECT P.NumeProiect FROM Proiecte P 
	INNER JOIN AngajatiProiecte AP ON  AP.ProiectID=P.ProiectID 
GROUP BY P.NumeProiect 
HAVING SUM(AP.NrOreSAptamana) > 50

-- 2. Afisati angajatii care au salariul mai mare decat cel al managerului departamentului din care fac
--parte.select A.Nume, A.Prenume, A.Salariufrom Angajati Ajoin Departamente D on D.DepartamentID = A.DepartamentIDjoin Angajati AM on D.ManagerID = AM.AngajatIDwhere A.Salariu > AM.SalariuSELECT A.Nume, A.Prenume, A.Salariu
FROM Angajati A 
	INNER JOIN Departamente D ON D.DepartamentID = A.DepartamentID
	INNER JOIN Angajati AM  ON D.ManagerID = AM.AngajatID
	WHERE A.Salariu > AM.Salariu-- SAUSELECT A.Nume, A.Prenume, A.Salariu
FROM Angajati A 
	INNER JOIN Departamente D ON D.DepartamentID = A.DepartamentID
		WHERE A.Salariu > (SELECT AM.Salariu FROM Angajati AM WHERE AM.AngajatID = D.ManagerID)-- 3. Afisati numele, prenumele si salariul pentru toti angajatii, precum si procentul salariului acestora
-- fata de salariul supervizorului.select A.Nume, A.Prenume, A.Salariu, (A.Salariu* 100/Asu.Salariu) from Angajati Ajoin Angajati ASu on A.SupervizorID = ASu.AngajatID -- cica trebuie left joinSELECT A.Nume, A.Salariu,(A.Salariu*100/S.Salariu) AS PS
FROM Angajati A LEFT JOIN Angajati S 
ON A.SupervizorID = S.AngajatID-- 4. Afisati numele departametelor in ordine descrescatoare luand in considerare numarul total de
-- ore lucrate la proiectele din acel department.
select D.NumeDepartament, SUM(NrOreSaptamana)
from Departamente D 
inner join Proiecte P on P.DepartamentID = D.DepartamentID
inner join AngajatiProiecte AP on P.ProiectID = AP.ProiectID
group by D.NumeDepartament 
order by SUM(NrOreSaptamana) desc

SELECT D.NumeDepartament, SUM(AP.NrOreSaptamana) AS NrOreLucrate
FROM Departamente D INNER JOIN Proiecte P 
ON P.DepartamentID = D.DepartamentID
INNER JOIN AngajatiProiecte AP 
ON Ap.ProiectID = P.ProiectID GROUP BY D.NumeDepartament
ORDER BY NrOreLucrate DESC

-- 5. Afisati pentru fiecare department numarul angajatilor si media salariilor angajatilor. Informatiile
-- se vor afisa pentru toate departamentele.
select D.NumeDepartament, count(A.AngajatID) as NumarAngaj, avg(A.Salariu) as MedieSalarii
from Departamente D 
inner join Angajati A on A.DepartamentID = D.DepartamentID
group by D.NumeDepartament 

SELECT D.NumeDepartament, COUNT(A.AngajatID) AS NrAngajati, 
AVG(A.Salariu) AS MedieSalariu FROM Departamente D LEFT JOIN Angajati A
ON A.DepartamentID = D.DepartamentID
GROUP BY D.NumeDepartament


-- 6. Gasiti supervizorii care au cel putin 2 persoane in subordine.
select S.Nume, S.Prenume
from Angajati S 
left join Angajati A on A.SupervizorID = S.AngajatID
group by S.AngajatID, S.Nume, S.Prenume
having count(A.AngajatID) >= 2


-- 7. Să se afişeze numele şi salariul angajaţilor conduşi direct de preşedintele companiei (acesta este
-- considerat angajatul care nu are supervizor).

SELECT A.Nume, A.Prenume, A.Salariu 
FROM Angajati A
WHERE A.SupervizorID IN (SELECT AngajatID FROM Angajati WHERE SupervizorID IS NULL)

select a.Nume, a.prenume, a.Salariu
from Angajati a
inner join Angajati s on s.AngajatID = a.SupervizorID
where s.SupervizorID is NULL


-- 8. Sa se gaseasca cele mai mari 3 salarii ale angajatilor ce lucreaza pentru departamentul “IT”.
select top 3 A.Salariu
from Angajati A
join Departamente D on A.DepartamentID = D.DepartamentID
where D.NumeDepartament = 'IT'
ORDER BY A.Salariu DESC

SELECT TOP 3 A.Salariu
From Angajati A INNER JOIN Departamente D ON A.DepartamentID = D.DepartamentID
WHERE D.NumeDepartament = 'IT'
