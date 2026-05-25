------------------
--task_1

--Vaccination_Type

--Vaccination_Type_ID		    PK
--Vaccination_Type_Name	        Название прививки

--Vaccination

--Vaccination_ID	        	PK
--Pet_ID	                    FK → Pet
--Vaccination_Type_ID          	FK → Vaccination_Type
--Vaccination_Date	            Дата прививки
--Vaccination_Filename	        Имя файла с сканом документов
------------------
CREATE TABLE Vaccination_Type (
    Vaccination_Type_ID   INTEGER      NOT NULL,
    Vaccination_Type_Name VARCHAR(20)  NOT NULL,
    CONSTRAINT Vaccination_Type_PK PRIMARY KEY (Vaccination_Type_ID)
)
;

CREATE TABLE Vaccination (
    Vaccination_ID        INTEGER         NOT NULL,
    Pet_ID                INTEGER         NOT NULL,
    Vaccination_Type_ID   INTEGER         NOT NULL,
    Vaccination_Date      DATE            NOT NULL,
    Vaccination_Filename  VARCHAR(50)     NOT NULL,
    CONSTRAINT Vaccination_PK PRIMARY KEY (Vaccination_ID)
)
;




ALTER TABLE Vaccination ADD CONSTRAINT FK_Vaccination_Pet
    FOREIGN KEY (Pet_ID)
    REFERENCES Pet(Pet_ID)
;

ALTER TABLE Vaccination ADD CONSTRAINT FK_Vaccination_Type
    FOREIGN KEY (Vaccination_Type_ID)
    REFERENCES Vaccination_Type(Vaccination_Type_ID)
;


INSERT INTO Vaccination_Type(Vaccination_Type_ID, Vaccination_Type_Name) VALUES 
(1, 'Бешенство');
INSERT INTO Vaccination_Type(Vaccination_Type_ID, Vaccination_Type_Name) VALUES 
(2, 'Чумка');
INSERT INTO Vaccination_Type(Vaccination_Type_ID, Vaccination_Type_Name) VALUES 
(3, 'Другое');
GO


set dateformat ymd;

INSERT INTO Vaccination(Vaccination_ID, Pet_ID, Vaccination_Type_ID, Vaccination_Date, Vaccination_Filename) 
VALUES (1, 1, 1, '2026-01-11', 'Pet_ID_1_VType_1_scan.pdf');
INSERT INTO Vaccination(Vaccination_ID, Pet_ID, Vaccination_Type_ID, Vaccination_Date, Vaccination_Filename) 
VALUES (2, 1, 2, '2026-02-12', 'Pet_ID_1_VType_2_scan.pdf');
INSERT INTO Vaccination(Vaccination_ID, Pet_ID, Vaccination_Type_ID, Vaccination_Date, Vaccination_Filename) 
VALUES (3, 4, 1, '2026-03-13', 'Pet_ID_4_VType_1_scan.pdf');
INSERT INTO Vaccination(Vaccination_ID, Pet_ID, Vaccination_Type_ID, Vaccination_Date, Vaccination_Filename) 
VALUES (4, 4, 3, '2026-04-14', 'Pet_ID_4_VType_3_scan.pdf');
INSERT INTO Vaccination(Vaccination_ID, Pet_ID, Vaccination_Type_ID, Vaccination_Date, Vaccination_Filename) 
VALUES (5, 3, 3, '2026-05-15', 'Pet_ID_3_VType_3_scan.pdf');
GO

/* 9.Для каждого сотрудника вывести список прививок, 
которые он мог бы проверить — а именно, прививки тех животных, 
с которыми этот сотрудник работал (есть заказы).
Только для прививок, сделанных после 1 марта 2026.*/

SELECT 
    pers.Last_Name AS Employee_LastName,
    p.Nick AS Pet_Nick,
    vt.Vaccination_Type_Name,
    v.Vaccination_Date,
    v.Vaccination_Filename
FROM Vaccination v
JOIN Pet p ON v.Pet_ID = p.Pet_ID
JOIN Order1 o ON p.Pet_ID = o.Pet_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
JOIN Person pers ON e.Person_ID = pers.Person_ID
JOIN Vaccination_Type vt ON v.Vaccination_Type_ID = vt.Vaccination_Type_ID
WHERE v.Vaccination_Date > '2026-03-01'

SELECT 
    pers.Last_Name AS Employee_LastName,
    p.Nick AS Pet_Nick,
    vt.Vaccination_Type_Name,
    v.Vaccination_Date,
    v.Vaccination_Filename
FROM Vaccination v, 
     Pet p, 
     Order1 o, 
     Employee e, 
     Person pers, 
     Vaccination_Type vt
WHERE v.Pet_ID = p.Pet_ID
  AND p.Pet_ID = o.Pet_ID
  AND o.Employee_ID = e.Employee_ID
  AND e.Person_ID = pers.Person_ID
  AND v.Vaccination_Type_ID = vt.Vaccination_Type_ID
  AND v.Vaccination_Date > '2026-03-01'


SELECT 'Vaccination_Type' AS Table_Name, * FROM Vaccination_Type;
SELECT 'Vaccination' AS Table_Name, * FROM Vaccination;
GO
/*
DROP TABLE Vaccination;
DROP TABLE Vaccination_Type;
*/
