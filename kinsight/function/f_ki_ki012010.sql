DROP FUNCTION IF EXISTS f_ki_ki012010(text);
CREATE OR REPLACE FUNCTION f_ki_ki012010 (
	req_json text
)
RETURNS TABLE (
	rn bigint
	, trdd_no int
	, trdd character varying
	, shcode character varying
	, open numeric
	, high numeric
	, low numeric
	, close numeric
	, sign character varying
	, change numeric
	, diff numeric
	, volume numeric
	, fpvolume numeric
	, covolume numeric
	, ppvolume numeric
	, value numeric
	, marketcap numeric
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
		COALESCE(req_page_index, 1)
		, COALESCE(req_page_size, 20)
		, CASE
			WHEN req_trdd_from = '' THEN '20000101'
			ELSE COALESCE(req_trdd_from, '20000101')
			END AS trddf
		, CASE
			WHEN req_trdd_from = '' THEN TO_CHAR(NOW(), 'YYYYMMDD')
			ELSE COALESCE(req_trdd_to, TO_CHAR(NOW(), 'YYYYMMDD'))
			END AS trddt
	INTO
		req_page_index
		, req_page_size
		, req_trdd_from
		, req_trdd_to
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
			, ki012000.sign
			, ki012000.change
			, ki012000.diff
			, ki012000.volume
			, ki012000.fpvolume
			, ki012000.covolume
			, ki012000.ppvolume
			, ki012000.value
			, ki012000.marketcap
		FROM (
			SELECT
				ROW_NUMBER() OVER (ORDER BY trd.trdd_no DESC) AS rn
				, trd.trdd_no
				, trd.trdd
				, t1305.shcode
				, t1305.open
				, t1305.high
				, t1305.low
				, t1305.close
				, t1305.sign
				, t1305.change
				, t1305.diff
				, t1305.volume
				, t1305.fpvolume
				, t1305.covolume
				, t1305.ppvolume
				, t1305.value
				, t1305.marketcap
			FROM
				t_ki_ki0110 trd
				, t_eb_t1305 t1305
			WHERE 1 = 1
				AND trd.trdd = t1305.date
				AND trd.trdd >= req_trdd_from
				AND trd.trdd <= req_trdd_to
				AND t1305.shcode = req_shcode
			) ki012000
		WHERE 1 = 1
			AND ki012000.rn >= row_from
			AND ki012000.rn <= row_to
		;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
