/**
The following code snippet is authored by:
- Markus Fath https://github.com/fath-markus
**/

-- DDL
CREATE TABLE "TEST"(
	"ID" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"TEXT" NCLOB,
	"VECTOR" REAL_VECTOR(2)
);
TRUNCATE TABLE TEST;
-- INSERT
INSERT INTO TEST ("TEXT", "VECTOR") VALUES('some text', TO_REAL_VECTOR('[0.1, 0.8]'));
-- INSPECT
SELECT *, TO_NVARCHAR("VECTOR") AS "VECTOR_STR" FROM TEST;
-- METADATA
SELECT * FROM TABLE_COLUMNS WHERE SCHEMA_NAME = 'VDB';
-- TOP K NN
SELECT TOP 10 "ID", "TEXT", COSINE_SIMILARITY("VECTOR", TO_REAL_VECTOR('[0.2, 0.9]')) AS "COS_SIM"
	FROM TEST
	ORDER BY "COS_SIM" DESC;
SELECT TOP 10 "ID", "TEXT", L2DISTANCE("VECTOR", TO_REAL_VECTOR('[0.2, 0.9]')) AS "L2_DIST"
	FROM TEST
	ORDER BY "L2_DIST" ASC;
-- WHERE filter
SELECT "ID", "TEXT", COSINE_SIMILARITY("VECTOR", TO_REAL_VECTOR('[0.2, 0.9]')) AS "COS_SIM"
	FROM TEST
	WHERE COSINE_SIMILARITY("VECTOR", TO_REAL_VECTOR('[0.2, 0.9]')) > 0.8
	ORDER BY "COS_SIM" DESC;
