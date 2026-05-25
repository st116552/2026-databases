-- 1. Данные на Партизана
SELECT * 
FROM Pet 
WHERE Nick = 'Partizan';
-- 2. Клички и породы всех питомцев по возрасту
SELECT Nick, Breed, Age 
FROM Pet 
ORDER BY Age ASC;
-- 3. Питомцы, имеющие хоть какое-нибудь описание
SELECT Pet_ID, Nick, Breed, Age, Description 
FROM Pet 
WHERE Description IS NOT NULL AND Description != '';
-- 4. Средний возраст пуделей
SELECT AVG(CAST(Age AS FLOAT))
FROM Pet 
WHERE Breed = 'poodle';
-- 5. Количество владельцев
SELECT COUNT(DISTINCT Owner_ID)
FROM Pet;
-- 6. Сколько имеется питомцев каждой породы
SELECT Breed, COUNT(*)
FROM Pet 
GROUP BY Breed
-- 7. Сколько имеется питомцев каждой породы (если только один - не показывать эту породу)
SELECT Breed, COUNT(*)
FROM Pet 
GROUP BY Breed
HAVING COUNT(*) > 1
-- 8. запрос с BETWEEN
-- установка формата даты:
set dateformat ymd;
SELECT *
FROM Order1
WHERE Time_Order BETWEEN '2023-09-18 18:00' AND '2023-09-23 10:00'
-- 9. запрос с LIKE
SELECT *
FROM Person
WHERE  First_Name LIKE 'P%'
-- 10.  запрос с IN(...)      (без вложенного select, это будет позже :))
SELECT * 
FROM Order1 
WHERE Service_ID IN (1, 3)