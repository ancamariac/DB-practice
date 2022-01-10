-- 1. Afisati numarul de persoane aflate in intretinerea fiecarui angajat. 
select A.AngajatID, count(I.IntretinutID) as nrintrt
from Angajati A inner join Intretinuti I on A.AngajatID = I.AngajatID
group by A.AngajatID

SELECT A.Nume,A.Prenume , Count(I.IntretinutID) 
FROM  Angajati A LEFT JOIN Intretinuti I
ON A.AngajatID = I.AngajatID
GROUP BY A.Nume,A.Prenume;

select * from Intretinuti

-- 2.  Afisati lista cu numele, prenumele, salariul si departamentul din care provin angajatii care
-- lucreaza minim 5 ore/sapt la proiectul cu ID-ul 2. 
select A.Nume, A.Prenume, A.Salariu, A.DepartamentID 
from Angajati A inner join AngajatiProiecte AP on A.AngajatID = AP.AngajatID
and AP.ProiectID = 2 and AP.NrOreSaptamana >= 5

SELECT A.Nume, A.Prenume, A.Salariu, D.NumeDepartament 
FROM Angajati A 
JOIN AngajatiProiecte P ON A.AngajatID=P.AngajatID
JOIN Departamente D ON A.DepartamentID=D.DepartamentID
WHERE P.NrOreSaptamana>5 AND P.ProiectID=2

-- 3. Afisati lista cu numele, prenumele, salariul si departamentul din care provin angajatii care
-- lucreaza minim 5 ore/sapt la proiectul cu numele ‘Site UPB’.select A.Nume, A.Prenume, A.Salariu, A.AngajatID, D.NumeDepartament, P.ProiectIDfrom Angajati A inner join AngajatiProiecte AP on A.AngajatID = AP.AngajatID and AP.NrOreSaptamana >= 5 join Departamente D on A.DepartamentID = D.DepartamentIDjoin Proiecte P on AP.ProiectID = P.ProiectID andP.NumeProiect = 'Site UPB'SELECT A.Nume, A.Prenume, A.Salariu, D.NumeDepartament
FROM Angajati A 
JOIN AngajatiProiecte AP ON A.AngajatID=AP.AngajatID
JOIN Departamente D ON A.DepartamentID=D.DepartamentID
JOIN Proiecte P ON AP.ProiectID=P.ProiectID
WHERE AP.NrOreSaptamana>5 AND P.NumeProiect='Site UPB'-- 4. Pentru fiecare departament, afisati numarul de proiecte pe care le coordoneaza. select  D.NumeDepartament, D.DepartamentID, count(P.ProiectID) as numarPrjfrom Departamente D join Proiecte P on D.DepartamentID = P.DepartamentIDgroup by D.NumeDepartament, D.DepartamentID
SELECT D.NumeDepartament, COUNT(P.ProiectID)
FROM Departamente D
LEFT JOIN Proiecte P ON D.DepartamentID= P.DepartamentID
GROUP BY D.NumeDepartament


-- 5. Afisati toate numele de proiecte la care lucreaza angajatul cu numele ‘Ionescu ‘sau care
-- apartin de departamentul la care 'Popescu' este manager.
select P.NumeProiect 
from Proiecte P 
join AngajatiProiecte AP on P.ProiectID = AP.ProiectID
join Angajati A on AP.AngajatID = A.AngajatID
join Departamente D on D.DepartamentID = P.DepartamentID
where A.Nume = 'Ionescu' or  (A.AngajatID = D.ManagerID and A.Nume = 'Popescu')

SELECT P.NumeProiect
FROM Proiecte P
JOIN AngajatiProiecte AP ON AP.ProiectID=P.ProiectID
JOIN Angajati A ON A.AngajatID = AP.AngajatID
WHERE A.Nume='Ionescu'
UNION
SELECT P.NumeProiect
FROM Proiecte P
JOIN AngajatiProiecte AP ON AP.ProiectID=P.ProiectID
JOIN Angajati A ON A.AngajatID = AP.AngajatID
JOIN Departamente D ON D.ManagerID =A.AngajatID
WHERE A.Nume='Popescu';

-- 6. Afisati numarul de angajati si media salariilor angajatilor pentru fiecare departament al
-- companiei. 
select D.NumeDepartament, count(AngajatID) as nrAngaj, avg(Salariu)
from Departamente D
join Angajati A on A.DepartamentID = D.DepartamentID
group by D.NumeDepartament

SELECT D.NumeDepartament, COUNT(*),AVG(A.Salariu)
FROM Departamente D
LEFT JOIN Angajati A ON A.DepartamentID = D.DepartamentID
GROUP BY D.NumeDepartament

-- 7. Sa se determine numele si prenumele angajatilor care lucreaza minim 10 ore/saptamana la cel
-- putin 3 proiecte coordonate de departamentul cu ID-ul 1. 
select A.Nume, A.Prenume
from Angajati A
join AngajatiProiecte AP on AP.AngajatID = A.AngajatID
join Proiecte P on P.ProiectID = AP.ProiectID
join Departamente D on P.DepartamentID = D.DepartamentID
where  P.DepartamentID = 1
group by A.Nume, A.Prenume
having count(P.ProiectID) >=3 and sum(AP.NrOreSaptamana) >= 10 

SELECT A.Nume, A.Prenume
FROM Angajati A 
JOIN AngajatiProiecte AP ON AP.AngajatID = A.AngajatID
JOIN Proiecte P ON AP.ProiectID = P.ProiectID
WHERE P.DepartamentID=1
GROUP BY  A.Nume, A.Prenume 
HAVING COUNT(*) >= 3 AND SUM(AP.NrOreSaptamana)>=10 

-- 8. Pentru fiecare proiect al companiei, selectati numarul de angajati care lucreaza la el, precum si
-- numarul de ore care ii sunt alocate saptamanal (in total). 
select P.NumeProiect, sum(AP.NrOreSaptamana) as nrore, count(AP.AngajatID) as nrang
from Proiecte P 
join AngajatiProiecte AP on AP.ProiectID = P.ProiectID
group by P.NumeProiect

SELECT P.NumeProiect, 
COUNT(*) AS Nr_Angajati, 
SUM(AP.NrOreSaptamana) AS Total_Ore
FROM Proiecte P 
JOIN AngajatiProiecte AP ON AP.ProiectID = P.ProiectID
GROUP BY P.NumeProiect