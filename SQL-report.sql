 user_id | register_date | register_device
---------+---------------+-----------------
 U001    | 2016-08-26    |               1
 U002    | 2016-08-26    |               2
 U003    | 2016-08-27    |               3
(3 行)


SELECT
user_id
, CASE
    WHEN register_device=1 THEN 'PC'
    WHEN register_device=2 THEN 'SP'
    WHEN register_device=3 THEN 'アプリ'
END AS device_name
FROM mst_users;


 user_id | device_name
---------+-------------
 U001    | PC
 U002    | SP
 U003    | アプリ
(3 行)

-----------------------------------------------------------------------

