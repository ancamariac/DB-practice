select * from Angajati
select * from Intretinuti
select * from AngajatiProiecte
select * from Proiecte
select * from Departamente

-- 1.     Afisati toate numele proiectelor pentru care numarul 
--de ore lucrate de angajatii de sex feminin este mai mic decat 60. Ordonati rezultatul de la Z-A.
select P.NumeProiect from Proiecte P
join AngajatiProiecte AP on P.ProiectID = AP.ProiectID
join Angajati A on A.AngajatID = AP.AngajatID
where A.Sex = 'F'
group by P.NumeProiect
having sum(AP.NrOreSaptamana) < 60 
order by P.NumeProiect desc

select * from AngajatiProiecte
select * from Proiecte
select * from Angajati

--  2.    Afisati managerii (nume si prenume) care lucreaza la toate proiectele 
--coordonate de departamentul pe care il conduc.
select A.Nume, A.Prenume from Angajati A
join Departamente D on D.ManagerID = A.AngajatID
where
(select count(distinct P.ProiectID) from AngajatiProiecte AP, Proiecte P
where A.AngajatID = AP.AngajatID and P.DepartamentID = A.DepartamentID
and P.ProiectID = AP.ProiectID)
=
(select count(distinct P2.ProiectID) from Proiecte P2
where A.DepartamentID = P2.DepartamentID)
group by A.Nume, A.Prenume

select * from Angajati
Select * from Departamente
select * from AngajatiProiecte
select * from Proiecte

