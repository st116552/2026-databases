-- 1. Данные на Партизана (включая вид животного).
SELECT *
FROM Pet p
JOIN Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
WHERE p.Nick = 'Partizan';

SELECT *
FROM Pet p, Pet_Type pt
WHERE p.Pet_Type_ID = pt.Pet_Type_ID
  AND p.Nick = 'Partizan';

-- 1. для соответствия ответам из файла
SELECT p.Nick, pt.Name
FROM Pet p
JOIN Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
WHERE p.Nick = 'Partizan';

SELECT p.Nick, pt.Name
FROM Pet p, Pet_Type pt
WHERE p.Pet_Type_ID = pt.Pet_Type_ID
  AND p.Nick = 'Partizan';


-- 2. Список всех собак с кличками, породой и возрастом.
SELECT p.Nick, p.Breed, p.Age
FROM Pet p
JOIN Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
WHERE pt.Name = 'DOG';

SELECT p.Nick, p.Breed, p.Age
FROM Pet p, Pet_Type pt
WHERE p.Pet_Type_ID = pt.Pet_Type_ID
  AND pt.Name = 'DOG';


-- 3. Средний возраст кошек.
SELECT AVG(CONVERT(DECIMAL, Age))
FROM Pet p
JOIN Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
WHERE pt.Name = 'CAT';

SELECT AVG(CONVERT(DECIMAL, Age))
FROM Pet p, Pet_Type pt
WHERE p.Pet_Type_ID = pt.Pet_Type_ID
  AND pt.Name = 'CAT';


-- 4. Время и исполнители невыполненных заказов.
SELECT o.Time_Order, p.Last_Name
FROM Order1 o
JOIN Employee e ON o.Employee_ID = e.Employee_ID
JOIN Person p ON e.Person_ID = p.Person_ID
WHERE o.Is_Done = 0;

SELECT o.Time_Order, p.Last_Name
FROM Order1 o, Employee e, Person p
WHERE o.Employee_ID = e.Employee_ID
  AND e.Person_ID = p.Person_ID
  AND o.Is_Done = 0;

-- 5. Список хозяев собак (имя, фамилия, телефон). 
SELECT DISTINCT pr.Last_Name, pr.First_Name, pr.Phone
FROM Owner ow
JOIN Person pr ON ow.Person_ID = pr.Person_ID
JOIN Pet p ON ow.Owner_ID = p.Owner_ID
JOIN Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
WHERE pt.Name = 'DOG';

SELECT DISTINCT pr.Last_Name, pr.First_Name, pr.Phone
FROM Owner ow, Person pr, Pet p, Pet_Type pt
WHERE ow.Person_ID = pr.Person_ID
  AND ow.Owner_ID = p.Owner_ID
  AND p.Pet_Type_ID = pt.Pet_Type_ID
  AND pt.Name = 'DOG';

-- 6. Все виды питомцев и клички представителей этих видов (внешнее соединение).
SELECT pt.Name AS Pet_Type_Name, p.Nick
FROM Pet_Type pt
LEFT JOIN Pet p ON pt.Pet_Type_ID = p.Pet_Type_ID;

-- 7. Сколько имеется котов, собак и т.д. в возрасте 1 год, 2 года, и т.д.
SELECT pt.Name AS Pet_Type, p.Age, COUNT(*) AS Count
FROM Pet p
JOIN Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
GROUP BY pt.Name, p.Age
ORDER BY p.Age;

SELECT pt.Name AS Pet_Type, p.Age, COUNT(*) AS Count
FROM Pet p, Pet_Type pt
WHERE p.Pet_Type_ID = pt.Pet_Type_ID
GROUP BY pt.Name, p.Age
ORDER BY p.Age;

-- 8. Фамилии сотрудников, выполнивших более трех заказов.
SELECT p.Last_Name, COUNT(*) AS count_of_orders
FROM Order1 o
JOIN Employee e ON o.Employee_ID = e.Employee_ID
JOIN Person p ON e.Person_ID = p.Person_ID
WHERE o.Is_Done = 1
GROUP BY p.Last_Name
HAVING COUNT(*) > 3;

SELECT p.Last_Name, COUNT(*) AS count_of_orders
FROM Order1 o, Employee e, Person p
WHERE o.Employee_ID = e.Employee_ID
  AND e.Person_ID = p.Person_ID
  AND o.Is_Done = 1
GROUP BY p.Last_Name
HAVING COUNT(*) > 3;

-- 9. см в SQLQuery2