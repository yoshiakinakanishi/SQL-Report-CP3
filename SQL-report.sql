-----------------------------------------------------------------------
    コード値をラベルに置換する
-----------------------------------------------------------------------


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
    URLから要素を取り出す
-----------------------------------------------------------------------

-----------------------------------------------------------------------
    リファラ―から参照元ホスト名を取得する
-----------------------------------------------------------------------

        stamp        |                       referrer                        |                    url                   
---------------------+-------------------------------------------------------+--------------------------------------------
 2016-08-26 12:02:00 | http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1 | http://www.example.com/video/detail?id=001
 2016-08-26 12:02:01 | http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1 | http://www.example.com/video#ref
 2016-08-26 12:02:01 | https://www.other.com/                                | http://www.example.com/book/detail?id=002(3 行)


SELECT
    stamp
    , substring(referrer from  'https?://([^/]*)') AS referrer_host
FROM access_log;


        stamp        | referrer_host
---------------------+---------------
 2016-08-26 12:02:00 | www.other.com
 2016-08-26 12:02:01 | www.other.net
 2016-08-26 12:02:01 | www.other.com
(3 行)

-----------------------------------------------------------------------
    URLからパスやクエリパラメータの値を抽出する
-----------------------------------------------------------------------

SELECT
    stamp
    , url
    , substring(url from '//[^/]+([^?#]+)') AS pash
    , substring(url from 'id=([^&]*)') AS id
FROM access_log;


        stamp        |                    url                     |     pash      | id
---------------------+--------------------------------------------+---------------+-----
 2016-08-26 12:02:00 | http://www.example.com/video/detail?id=001 | /video/detail | 001
 2016-08-26 12:02:01 | http://www.example.com/video#ref           | /video        |
 2016-08-26 12:02:01 | http://www.example.com/book/detail?id=002  | /book/detail  | 002
(3 行)

-----------------------------------------------------------------------
    文字列を配列に分解する
-----------------------------------------------------------------------

SELECT
    stamp
    , url
    , split_part(substring(url from '//[^/]+([^?#]+)'), '/', 2) AS path1
    , split_part(substring(url from '//[^/]+([^?#]+)'), '/', 3) AS path2
FROM access_log;


        stamp        |                    url                     | path1 | path2
---------------------+--------------------------------------------+-------+--------
 2016-08-26 12:02:00 | http://www.example.com/video/detail?id=001 | video | detail
 2016-08-26 12:02:01 | http://www.example.com/video#ref           | video |
 2016-08-26 12:02:01 | http://www.example.com/book/detail?id=002  | book  | detail
(3 行)