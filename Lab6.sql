
-- 1. Afisati numele angajatilor care lucreaza mai mult de 20 de ore la cel putin un proiect la
-- care lucreaza si managerul departamentului din care fac parte.
select A.Nume, A.Prenume from Angajati A
JOIN AngajatiProiecte AP on AP.AngajatID = A.AngajatID
JOIN Departamente D on A.DepartamentID = D.DepartamentID
where AP.ProiectID IN (select AP2.ProiectID from AngajatiProiecte AP2 
where AP2.AngajatID = D.ManagerID)
AND AP.NrOreSaptamana > 20 

-- 2. Sa se determine numele si prenumele angajatilor care nu au persoane in intretinere si
--pentru care suma orelor lucrate la proiecte este mai mare decat media orelor lucrate de
--angajatii departamentului cu ID-ul 1. 
select A.Nume, A.Prenume from Angajati A
join AngajatiProiecte AP on A.AngajatID = AP.AngajatID
where A.AngajatID NOT IN (select distinct a2.angajatid from angajati a2, intretinuti i
where a2.angajatid = i.angajatid)
group by a.angajatid, a.nume, a.prenume

having ((select sum(ap.nroresaptamana)
 from angajatiproiecte ap
 where a.angajatid = ap.angajatid) > (select avg(nroresaptamana)
 from angajati a4, angajatiproiecte ap2
where a4.angajatid = ap2.angajatid and
a4.departamentid = 1))

-- 3. Afisati numele departamentelor pentru care media salariilor angajatilor este mai mare
-- decat media salariului pe intreaga companie. 
select D.NumeDepartament from Departamente D
where (select avg(A.Salariu) from Angajati A 
where A.DepartamentID = D.DepartamentID) >
(select avg(A1.Salariu) from Angajati A1)


-- 4. Afisati numele persoanelor aflate in intretinere, al caror intretinator lucreaza la cel putin
-- 2 proiecte.
select I.Nume, I.Prenume from Intretinuti I
where (select count(AP.AngajatID) from AngajatiProiecte AP where 
AP.AngajatID = I.AngajatID) >= 2

-- 5. Selectati angajatii care nu lucreaza la niciun proiect
select A.Nume, A.Prenume from Angajati A
where A.AngajatID NOT IN (select AP.AngajatID from 
AngajatiProiecte AP )

-- 6. Afisati numele si prenumele angajatilor care lucreaza la toate proiectele coordonate de
-- departamentul din care fac parte.
select a.nume, a.prenume
from angajati a
where
(select count(distinct p.proiectid) from angajatiproiecte ap, proiecte
p
where a.angajatid = ap.angajatid and p.departamentid = a.departamentid
and p.proiectid = ap.proiectid)
=
(select count(distinct p2.proiectid) from proiecte p2
where a.departamentid = p2.departamentid)
group by a.angajatid, a.nume, a.prenume