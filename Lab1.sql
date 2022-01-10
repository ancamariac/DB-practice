-- 1
SELECT * FROM Departamente

-- 2
SELECT NumeDepartament FROM Departamente
WHERE NumeDepartament like 'I%'

-- 3
select Nume, Prenume from Angajati
where DataAngajarii < '01.01.2007' or DataAngajarii > '01.01.2008'

-- 4
select NumeProiect from Proiecte where 
DepartamentID = 2 order by NumeProiect desc

-- 5  Selectati proiectele al caror nume fie incepe cu �A�, fie contine grupul de litere �ea� in
-- interiorul denumirii. 
 select * from Proiecte 
 where NumeProiect like 'A%' or NumeProiect like '%ea%'

 -- 6 Selectati angajatii care au fost angajati dupa 01.03.2007 si care au salariul mai mare de 3000
-- ron.
select * from Angajati where DataAngajarii > '01.03.2007' and Salariu > 3000

-- 7.  Selectati angajatii care sunt afiliati departamentului cu ID-ul 1, ordonati crescator dupa nume. 
select * from Angajati where DepartamentID = 1 
order by Nume asc

-- 8. Selectati numele, prenumele si salariul pentru angajatul cu cnp 1111111111111. 
select Nume, Prenume, Salariu from Angajati
where CNP = '1111111111111'

-- 9. Selectati salariul, eliminand duplicatele
select distinct Salariu from Angajati

-- 10. Selectati numele si prenumele tuturor angajatilor din departamentul cu ID-ul 2.