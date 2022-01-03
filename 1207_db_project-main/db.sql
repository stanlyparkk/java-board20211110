DROP DATABASE IF EXISTS text_board;

CREATE DATABASE text_board;
USE text_board;

CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

UPDATE article
SET updateDate = NOW(),
title = '안녕1',
`body` = '반가워1'
WHERE id = 6;

DESC article;
SELECT * FROM article;

SELECT COUNT(*)
FROM article
WHERE id = 3;

CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(100) NOT NULL,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(100) NOT NULL
);

DESC `member`;

SELECT COUNT(*) FROM `member`
WHERE loginId = 'admin';

SELECT * FROM `member`;
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

DESC article;
SELECT * FROM article;

SELECT a.*, m.name AS extra_writer
FROM article AS a
LEFT JOIN `member` AS m
ON a.memberId = m.id
WHERE a.id = 9;

SELECT a.*, m.name AS extra_writer
FROM article AS a
LEFT JOIN `member` AS m
ON a.memberId = m.id
ORDER BY a.id DESC;

ALTER TABLE article ADD COLUMN hit INT(10) UNSIGNED NOT NULL;
SELECT * FROM article;

SELECT a.*, m.name AS extra_writer
FROM article AS a
LEFT JOIN `member` AS m
ON a.memberId = m.id
WHERE a.title LIKE '%d%';

SELECT * FROM `member`;
DESC article;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = '제목1',
`body` = '내용1',
hit = 30;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = '제목2',
`body` = '내용2',
hit = 50;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = '제목3',
`body` = '내용3',
hit = 10;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = '제목4',
`body` = '내용4',
hit = 305;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = '제목5',
`body` = '내용5',
hit = 60;

SELECT * FROM article;

## getArticles 페이징
SELECT a.*, m.name AS extra_writer
FROM article AS a
LEFT JOIN `member` AS m
ON a.memberId = m.id
ORDER BY a.id DESC
LIMIT 15, 5;

SELECT COUNT(*)
FROM article
WHERE title LIKE '%d%';

## like 테이블 생성
## liketype 1 = 추천, 2 = 반대
CREATE TABLE `like` (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    likeType TINYINT(1) NOT NULL
);

DROP TABLE `like`;

DESC `like`;
SELECT * FROM `like`;
SELECT * FROM article;
SELECT * FROM `member`;

## like 했는지 체크
## 추천/비추천 했다면 해당하는 likeType 값 리턴
## 추천/비추천 안했다면 0 리턴
SELECT
CASE WHEN COUNT(*) != 0
THEN likeType ELSE 0 END
FROM `like`
WHERE articleId = 69 AND memberId = 1;

SELECT COUNT(*)
FROM `like`
WHERE articleId = 69 AND likeType = 2;

SELECT *
FROM `like`
WHERE articleId = 6;

## comment 테이블 생성
CREATE TABLE `comment` (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    title CHAR(100) NOT NULL,
    `body` CHAR(100) NOT NULL
);

DESC `comment`;
SELECT * FROM `comment`;

SELECT COUNT(*)
FROM `comment`
WHERE id = 3 AND articleId = 69;

SELECT c.*, m.name AS extra_writer
FROM `comment` c
INNER JOIN `member` m
ON c.memberId = m.id
WHERE articleId = 69
LIMIT 5, 5;

DROP DATABASE a4;
CREATE DATABASE a4;

# 직원 테이블
CREATE TABLE emp (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  `name` CHAR(100) NOT NULL,
  regDate DATETIME NOT NULL,
  pay INT(10) UNSIGNED NOT NULL,
  deptId INT(10) UNSIGNED NOT NULL,
  rankId INT(10) UNSIGNED NOT NULL,
  comm INT(10) UNSIGNED NOT NULL
);

SELECT * FROM emp;
DESC emp;

CREATE TABLE rankNo (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  `name` CHAR(100) NOT NULL
);

CREATE TABLE deptNo (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  `name` CHAR(100) NOT NULL
);

SHOW TABLES;

# deptNo 데이터 입력
INSERT INTO deptNo
SET `name` = '재무';

INSERT INTO deptNo
SET `name` = '마케팅';

INSERT INTO deptNo
SET `name` = '영업';

INSERT INTO deptNo
SET `name` = '기획';

INSERT INTO deptNo
SET `name` = '무역';

# rankNo 데이터 입력
INSERT INTO rankNo
SET `name` = '사원';

INSERT INTO rankNo
SET `name` = '주임';

INSERT INTO rankNo
SET `name` = '대리';

INSERT INTO rankNo
SET `name` = '과장';

INSERT INTO rankNo
SET `name` = '차장';

INSERT INTO rankNo
SET `name` = '부장';

# emp 데이터 입력
INSERT INTO emp
SET `name` = 'ALLEN'
, regDate = '2018-12-17'
, pay = 2400
, deptId = 1
, rankId = 1
, comm = 200;

INSERT INTO emp
SET `name` = 'SMITH'
, regDate = '2017-02-20'
, pay = 3200
, deptId = 2
, rankId = 2
, comm = 250;

INSERT INTO emp
SET `name` = 'WARD'
, regDate = '2016-09-28'
, pay = 2850
, deptId = 3
, rankId = 3
, comm = 600;

INSERT INTO emp
SET `name` = 'DANIEL'
, regDate = '2010-06-05'
, pay = 4400
, deptId = 4
, rankId = 4
, comm = 500;

INSERT INTO emp
SET `name` = 'JAMES'
, regDate = '2007-07-08'
, pay = 6400
, deptId = 1
, rankId = 6
, comm = 600;

INSERT INTO emp
SET `name` = 'MARK'
, regDate = '2015-12-17'
, pay = 3700
, deptId = 5
, rankId = 4
, comm = 300;

INSERT INTO emp
SET `name` = 'FORD'
, regDate = '2019-09-30'
, pay = 2200
, deptId = 2
, rankId = 1
, comm = 100;

INSERT INTO emp
SET `name` = 'MILLER'
, regDate = '2006-03-04'
, pay = 6500
, deptId = 1
, rankId = 6
, comm = 300;

INSERT INTO emp
SET `name` = 'MARY'
, regDate = '2016-04-21'
, pay = 3400
, deptId = 4
, rankId = 3
, comm = 250;

INSERT INTO emp
SET `name` = 'ARON'
, regDate = '2010-12-17'
, pay = 4800
, deptId = 3
, rankId = 5
, comm = 400;

SELECT * FROM emp;

# 1. 덧셈 연산자를 사용해서 모든 사원에 대해
# $300의 급여 인상을 계산한 후 사원의 이름, 연봉, 인상된연봉을 출력하시오.
SELECT NAME 이름, pay 연봉, pay+300 인상된연봉
FROM emp;

# 2. 사원의 이름, 연봉, 월 평균 급여를 연봉이 많은 것부터 작은 순서로 출력하시오.
# 월 평균 급여는 연봉의 12를 나눈 값입니다.
SELECT NAME 이름, pay 연봉, pay/12 월평균급여
FROM emp
ORDER BY pay DESC;

# 3. 연봉 4000 이상 사원의 이름과 연봉을 출력해주세요.
# 연봉이 많은 것부터 작은 순서로 출력합니다.
SELECT NAME 이름, pay 연봉
FROM emp
WHERE pay >= 4000
ORDER BY pay DESC;
/*
4. 직원중 `N`을 포함하는 사원의 이름과 부서번호를 출력해주세요.
이름을 기준으로 오름 차순으로 정렬합니다.
*/
SELECT NAME 이름, deptId 부서번호
FROM emp
WHERE `name` LIKE '%N'
ORDER BY `name` ASC;

# 5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 연봉을 출력해주세요.
SELECT NAME 이름, pay 연봉
FROM emp
WHERE NOT pay BETWEEN 2000 AND 3000;

# 6. 2010년 1월 1일부터 2014년 12월 31일 사이에 입사한 사원의 이름, 직급번호, 입사일을 출력해주세요.
SELECT NAME 이름, rankId 직급번호, regDate 입사일
FROM emp
WHERE regDate BETWEEN '2010-01-01' AND '2014-12-31';

# 7. 부서번호가 2나 3에 속한 사원의 이름과 직급번호, 부서번호를 출력해주세요.
SELECT NAME 이름, rankId 직급번호, deptId 부서번호
FROM emp
WHERE deptId BETWEEN 2 AND 3;

# 8. 사원의 급여가 2000에서 3000 사이 포함되고 부서번호가 2 또는 3인 사원의 이름, 연봉, 부서번호를 이름을 
# 기준으로 오름차순으로 출력해주세요.
SELECT NAME 이름, pay 연봉, deptId 부서번호
FROM emp
WHERE pay BETWEEN 2000 AND 3000 AND deptId IN(2,3)
ORDER BY 이름 ASC;

# 9. 2010년도 전에 입사한 사원의 이름과 입사일 연봉을 출력하시시오.
SELECT NAME 이름, regDate 입사일, pay 연봉
FROM emp
WHERE regDate BETWEEN 0 AND '2009-12-31';

# 10. 이름이 J로 시작하는 사원의 이름과 입사일을 출력하시오.
SELECT NAME 이름, regDate 입사일
FROM emp
WHERE NAME LIKE 'J%';

# 11. 연봉에 커미션을 더해 모든 직원의 이름과 실수령연봉을 출력하시오. 실수령연봉을 기준으로 내림차순으로 정렬합니다.
SELECT * FROM emp;

SELECT NAME 이름, pay + comm 실수령연봉
FROM emp
ORDER BY 실수령연봉 DESC;

# 12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
SELECT NAME 이름
FROM emp
WHERE NAME LIKE '__R%';

# 13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
SELECT NAME 이름
FROM emp
WHERE `name` LIKE '%A%' AND `name` LIKE '%E%';

# 14. 직급번호가 1, 2, 3이 아닌 모든 사원의 이름, 직급번호, 부서번호, 
# 연봉을 출력하시오. 연봉을 기준으로 내림차순으로 정렬합니다.
SELECT NAME 이름, rankId 직급번호, deptId 부서번호, pay 연봉
FROM emp
WHERE rankId NOT IN(1,2,3)
ORDER BY 연봉 DESC;

# 15. 커미션이 500 이상인 사원의 이름과 연봉, 커미션을 출력하시오. 이름을 기준으로 오름차순으로 정렬합니다.
SELECT NAME 이름, pay 연봉, comm 커미션
FROM emp
WHERE comm >= 500
ORDER BY NAME ASC;

#16. SUBSTR 함수를 사용하여 사원들의 입사년도와 입사월을 출력하세요. 입사년도를 기준으로 오름차순으로 정렬합니다.
SELECT NAME 이름, SUBSTR(regDate, 1, 4) 입사년도, SUBSTR(regDate, 6, 2) 입사월
FROM emp
ORDER BY 입사년도 ASC;

#17. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력하시오.
SELECT * FROM emp
WHERE SUBSTR(regDate, 6, 2) = 4;

#18. MOD 함수를 사용해서 사원번호가 짝수인 사람을 출력하시오.
SELECT * FROM emp
WHERE MOD(id, 2) = 0;

#19. 모든 사원의 연봉 최고액, 최저액, 총액 및 평균연봉을 출력하시오. 평균에 대해서는 정수로 반올림 하시오.
SELECT MAX(pay) '연봉 최고액', MIN(pay) 최저액, SUM(pay) 총액, ROUND(AVG(pay), 0) 평균연봉
FROM emp;

#20. 각 담당 부서별로 부서번호, 연봉 최고액, 최저액, 총액 및 평균연봉을 출력하시오. 평균에 대해서는 정수로 반올림 하시오.
SELECT deptId 부서번호, MAX(pay) '연봉 최고액', MIN(pay) 최저액, SUM(pay) 총액, ROUND(AVG(pay), 0) 평균연봉
FROM emp
GROUP BY deptId;

#21. COUNT(*) 함수를 이용해서 부서 번호와 부서별 사원수를 출력하시오.
SELECT deptId 부서번호, COUNT(*) '부서별 사원수'
FROM emp
GROUP BY deptId;

#22. 연봉 최고액과 최저액의 차액을 출력하시오.
SELECT MAX(pay) - MIN(pay)
FROM emp;

#23. 직급별 사원의 최저 연봉을 직급번호와 최저연봉으로 출력하시오. 단, 최저연봉이 5000 이상인 경우는 제외하시오.
SELECT rankId 직급번호, MIN(pay) 최저연봉
FROM emp
GROUP BY rankId
HAVING 최저연봉 < 5000;

#24. 각 부서에 대해 부서번호, 사원수, 부서 내 모든 사원의 평균연봉을 출력하시오.
SELECT deptId 부서번호, COUNT(*) 사원수, AVG(pay) 평균연봉
FROM emp
GROUP BY deptId;

#25. INNER JOIN과 ON을 이용해서 사원 이름과 그 사원이 소속된 부서이름을 출력하시오. 이름을 기준으로 오름차순 정렬하시오.
SELECT e.name 사원명, d.name 부서명
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id
ORDER BY e.name ASC;

SELECT *
FROM emp e, deptNo d
WHERE e.deptId = d.Id;

#26. INNER JOIN과 ON을 이용해서 커미션이 300 이상인 사원의 이름, 부서명, 직급, 연봉, 커미션을 출력하시오.
#이름을 기준으로 오름차순으로 정렬하시오.

SELECT e.name 이름, d.name 부서명, r.name 직급, e.pay 연봉, e.comm 커미션
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id
INNER JOIN rankNo r
ON e.rankId = r.id
WHERE e.comm >= 300
ORDER BY 이름 ASC;

#27. 조인을 사용하지 않고 DANIEL 사원의 이름, 부서번호와 부서명 출력하시오.
# 조인을 하지 않으면 모든 경우의 수가 다 만들어지므로 WHERE로 id 값을 지정

SELECT e.name 이름, e.deptId 부서번호, d.name 부서명
FROM emp e, deptNo d
WHERE e.deptId = d.id AND e.name = 'DANIEL';

SELECT e.name 이름, e.deptId 부서번호, d.name 부서명
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id
WHERE e.name = 'DANIEL';

#28. 조인을 사용하지 않고 이름에 A가 포함된 모든 사원의 이름과 직급을 출력하시오.
# 이름을 기준으로 오름차순 정렬하시오.

SELECT e.name 이름, r.name 직급
FROM emp e, rankNo r
WHERE e.rankId = r.id AND e.name LIKE '%A%'
ORDER BY e.name ASC;

SELECT e.name 이름, r.name 직급
FROM emp e
INNER JOIN rankNo r
ON e.rankId = r.id 
WHERE e.name LIKE '%A%'
ORDER BY e.name ASC;

# 29. INNER JOIN과 ON을 이용해서 2000년 1월 1일부터 2009년 12월 31일 사이에 입사한 사원의 이름, 직급, 입사일, 연봉을 출력해주세요.
# 연봉을 기준으로 내림차순 정렬하고 입사일은 년, 월, 일만 표시합니다.
# BETWEEN '2000-01-01'
# SUBSTR(텍스트, 시작할 문자 번호, 문자의 개수)
# 날짜 -> 숫자값

SELECT e.name 이름, r.name 직급, SUBSTR(e.regDate, 1, 10) 입사일, e.pay 연봉
FROM emp e
INNER JOIN rankNo r
ON e.rankId = r.id
WHERE regDate BETWEEN '2000-01-01' AND '2009-12-31'
ORDER BY e.pay DESC;

SELECT *
FROM emp e
LEFT JOIN deptNo d
ON e.deptId = d.id
UNION
SELECT *
FROM emp e
RIGHT JOIN deptNo d
ON e.deptId = d.id;

#30. INNER JOIN과 ON을 이용해서 6월에 입사한 사원의 이름과 부서명, 입사일을 출력하시오.

SELECT e.name 이름, d.name 부서명, e.regDate 입사일
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id
WHERE SUBSTR(e.regDate, 6, 2) = 6;

#31. 최소 급여를 받는 사원의 이름, 연봉을 표시하시오. 중첩 select 이용

SELECT NAME 이름, pay 연봉
FROM emp
WHERE pay = (
SELECT MIN(pay) FROM emp
);

#32. INNER JOIN과 ON을 이용해서 평균 연봉이 가장 높은 부서번호와 부서명 평균연봉을 구하시오.
# GROUP BY

SELECT e.deptId 부서번호, d.name 부서명, AVG(e.pay) 평균연봉
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id
GROUP BY e.deptId
ORDER BY 평균연봉 DESC
LIMIT 1;

#33. 연봉이 평균 연봉보다 많은 사원들의 번호와 이름을 표시하시오. 연봉에 대해서는 높은순으로 정렬하시오.

SELECT id 번호, NAME 이름, pay 연봉
FROM emp
WHERE pay > (SELECT AVG(pay) FROM emp)
ORDER BY pay DESC;

#34. 이름에 K가 포함된 사원은 한명입니다. 이 사람과 같은 부서에서 일하는 사원의 사원 번호와 이름을 표시하시오.

SELECT id 번호, NAME 이름
FROM emp
WHERE deptId =
(SELECT deptId
FROM emp
WHERE NAME LIKE '%K%');

#35. 연봉합계가 가장 적은 부서명과 연봉합계을 출력하시오.

SELECT d.name 부서명, SUM(e.pay) 연봉합계
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id
GROUP BY deptId
ORDER BY 연봉합계 ASC
LIMIT 1;

# 개발부, CS부 추가
INSERT INTO deptNo
SET `name` = '개발';

INSERT INTO deptNo
SET `name` = 'CS';

INSERT INTO emp
SET id = 0
, `name` = 'JACK'
, regDate = '2021-12-28'
, pay = 3500
, deptId = 0
, rankId = 2
, comm = 200;

SELECT * FROM emp;

/*
#36. 현재 신설된 부서는 직원이 존재하지 않습니다.
직원이 존재하지 않는 신설부서의 부서번호와 부서명을 LEFT JOIN을 이용해서 출력해주세요.
SELECT d.id 부서번호, d.name 부서명
*/

SELECT *
FROM deptNo d
LEFT JOIN emp e
ON d.id = e.deptId;

/*
#37. 부서명이 존재하지 않는 직원이 있습니다.
INNER JOIN을 사용하면 확인할 수 없지만 LEFT 혹은 RIGHT JOIN을 사용하면 확인할 수 있습니다.
# RIGHT JOIN을 이용해 해당 직원의 이름과 부서명을 출력해주세요.
*/

SELECT e.name 이름, d.name 부서명
FROM deptNo d
RIGHT JOIN emp e
ON d.id = e.deptId
WHERE d.id IS NULL;

/*
#38. 위 쿼리를 INNER JOIN으로 바꿔서 실행해부시오.
*/

SELECT e.name 이름, d.name 부서명
FROM deptNo d
INNER JOIN emp e
ON d.id = e.deptId
WHERE d.id IS NULL;

/*
#39. 해당 직원은 개발부서에 들어온 신입인데 인사부 직원의 실수로 부서 id값이 잘못 입력된 것입니다.
올바른 데이터로 update 해주세요.
*/

UPDATE emp
SET deptId = 6
WHERE `name` = 'JACK';

/*
#40. 1부서부터 7부서까지 각각 문자코드를 A B C ...로 부여하려고 합니다.
case when 구문을 이용해서 칼럼을 만들고 이름, 부서번호, 부서코드, 부서명을 출력해주세요.
*/

SELECT e.name 이름, d.id 부서번호, 
CASE 
    WHEN e.deptId = 1 THEN
    'A'
    WHEN e.deptId = 2 THEN
    'B'
    WHEN e.deptId = 3 THEN
    'C'
    WHEN e.deptId = 4 THEN
    'D'
    WHEN e.deptId = 5 THEN
    'E'
    WHEN e.deptId = 6 THEN
    'F'
    WHEN e.deptId = 7 THEN
    'G'
END 부서코드
, d.name 부서명
FROM emp e
INNER JOIN deptNo d
ON e.deptId = d.id;

