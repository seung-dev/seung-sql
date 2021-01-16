CREATE OR REPLACE VIEW v_table_schem
AS
SELECT
	cols.table_name
	, pc.table_comment
	, cols.column_name
	, cols.ordinal_position
	, pa.column_comment
	, cols.column_default
	, cols.is_nullable
	, cols.data_type
	, CASE
		WHEN cols.data_type::text = 'numeric'::text THEN cols.numeric_precision::integer
		WHEN cols.data_type::text = 'bigint'::text THEN cols.numeric_precision::integer
		WHEN cols.data_type::text = 'int'::text THEN cols.numeric_precision::integer
		WHEN cols.data_type::text ~~ 'time'::text THEN '-1'::integer
		ELSE cols.character_maximum_length::integer
		END AS "precision"
	, CASE
		WHEN cols.data_type::text = 'numeric'::text THEN cols.numeric_scale::integer
		WHEN cols.data_type::text = 'bigint'::text THEN cols.numeric_scale::integer
		WHEN cols.data_type::text = 'int'::text THEN cols.numeric_scale::integer
		WHEN cols.data_type::text ~~ 'time'::text THEN '-1'::integer
		ELSE 0
		END AS scale
FROM
	information_schema.columns cols
	, (
		SELECT
			pg_class.oid
			, pg_class.relname
			, obj_description(pg_class.oid, 'pg_class'::name) AS table_comment
		FROM
			pg_class
	) pc
	, (
		SELECT
			pg_attribute.attrelid
			, pg_attribute.attname
			col_description(pg_attribute.attrelid, pg_attribute.attnum::integer) AS column_comment
		FROM
			pg_attribute
	) pa
WHERE 1 = 1
	AND cols.table_name::name = pc.relname
	AND pc.oid = pa.attrelid
	AND cols.column_name::name = pa.attname
	AND cols.table_schema::text = 'public'::text
ORDER BY cols.table_name, cols.ordinal_position
;

COMMIT;
