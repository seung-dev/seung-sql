DROP FUNCTION IF EXISTS f_ki_ki012000(text);
CREATE OR REPLACE FUNCTION f_ki_ki012000 (
	req_json text
)
RETURNS TABLE (
	rn bigint
	, trdd_no int
	, trdd character varying
	, shcode character varying
	, open integer
	, high integer
	, low integer
	, close integer
	, jdiff_vol integer
	, value integer
	, sign character varying
	)
AS
$$
DECLARE
	req_shcode character varying;
	req_trdd_from character varying;
	req_trdd_to character varying;
	req_page_index int;
	req_page_size int;
	row_from int;
	row_to int;
BEGIN

	SELECT
		req::json->>'shcode'
		, REGEXP_REPLACE(req::json->>'trdd_from', '[^0-9]', '', 'g') AS trdd_from
		, REGEXP_REPLACE(req::json->>'trdd_to', '[^0-9]', '', 'g') AS trdd_to
		, req::json->'page_index'
		, req::json->'page_size'
	INTO
		req_shcode
		, req_trdd_from
		, req_trdd_to
		, req_page_index
		, req_page_size
	FROM
		(SELECT CAST(req_json AS json) AS req) init
	;
	
	SELECT
		COALESCE(req_trdd_from, '20000101')
		, COALESCE(req_trdd_to, TO_CHAR(NOW(), 'YYYYMMDD'))
		, COALESCE(req_page_index, 1)
		, COALESCE(req_page_size, 20)
	INTO
		req_trdd_from
		, req_trdd_to
		, req_page_index
		, req_page_size
		;
	
	row_from = (req_page_index - 1) * req_page_size + 1;
	row_to = req_page_index * req_page_size;
	
	RETURN QUERY
		SELECT
			ki012000.rn
			, ki012000.trdd_no
			, ki012000.trdd
			, ki012000.shcode
			, ki012000.open
			, ki012000.high
			, ki012000.low
			, ki012000.close
			, ki012000.jdiff_vol
			, ki012000.value
			, ki012000.sign
		FROM (
			SELECT
				ROW_NUMBER() OVER (ORDER BY trd.trdd_no DESC) AS rn
				, trd.trdd_no
				, trd.trdd
				, t8413.shcode
				, t8413.open
				, t8413.high
				, t8413.low
				, t8413.close
				, t8413.jdiff_vol
				, t8413.value
				, t8413.sign
			FROM
				t_etf_trdd trd
				, t_eb_t8413 t8413
			WHERE 1 = 1
				AND trd.trdd = t8413.date
				AND trd.trdd >= req_trdd_from
				AND trd.trdd <= req_trdd_to
				AND t8413.shcode = req_shcode
			) ki012000
		WHERE 1 = 1
			AND ki012000.rn >= row_from
			AND ki012000.rn <= row_to
		;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
