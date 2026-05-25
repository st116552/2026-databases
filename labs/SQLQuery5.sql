-- 1. Все оценки по выполненным заказам, исполнителями которых являлись студенты.(используйте IN (SELECT...))

SELECT Mark
FROM Order1
WHERE Is_Done = 1
  AND Employee_ID IN (
      SELECT Employee_ID
      FROM Employee
      WHERE Spec = 'student'
  );

-- 2. Фамилии исполнителей, не получивших еще ни одного заказа.

SELECT 
    e.Employee_ID,
    p.Last_Name
FROM Employee e
JOIN Person p ON e.Person_ID = p.Person_ID
LEFT JOIN Order1 o ON e.Employee_ID = o.Employee_ID
WHERE o.Order_ID IS NULL;

-- 3. Список заказов (вид услуги, время, фамилия исполнителя, кличка питомца, фамилия владельца).

SELECT
    s.Name,
    o.Time_Order,
    pEmp.Last_Name,
    pet.Nick,
    pOwn.Last_Name
FROM Order1 o
JOIN Service s ON o.Service_ID = s.Service_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
JOIN Person pEmp ON e.Person_ID = pEmp.Person_ID
JOIN Pet pet ON o.Pet_ID = pet.Pet_ID
JOIN Owner own ON pet.Owner_ID = own.Owner_ID
JOIN Person pOwn ON own.Person_ID = pOwn.Person_ID
ORDER BY o.Time_Order;

-- 4. Общий список комментариев, имеющихся в базе.(используйте UNION)
             
SELECT Comments FROM Order1 WHERE Comments IS NOT NULL AND Comments != ''
UNION
SELECT Description FROM Pet WHERE Description IS NOT NULL AND Description != ''
UNION
SELECT Description FROM Owner WHERE Description IS NOT NULL AND Description != '';

-- 5. Имена и фамилии сотрудников, хотя бы раз получивших четверку за выполнение заказа.  (используйте EXISTS)

SELECT DISTINCT
    p.First_Name,
    p.Last_Name
FROM Person p
WHERE EXISTS (
    SELECT 1
    FROM Employee e
    JOIN Order1 o ON e.Employee_ID = o.Employee_ID
    WHERE e.Person_ID = p.Person_ID
      AND o.Mark = 4
);

-- 6. Перепишите предыдущий запрос в каком-либо ином синтаксисе, без EXISTS.

SELECT DISTINCT
    First_Name,
    Last_Name
FROM Person
WHERE Person_ID IN (
    SELECT Person_ID
    FROM Employee
    WHERE Employee_ID IN (
        SELECT Employee_ID
        FROM Order1
        WHERE Mark = 4
    )
);
