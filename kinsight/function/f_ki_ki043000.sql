DROP FUNCTION IF EXISTS f_ki_ki043000(text);
CREATE OR REPLACE FUNCTION f_ki_ki043000 (
	req_json text
)
RETURNS TABLE (
	memb_code character varying
	, memb_name character varying
	, inv_sec_code character varying
	, inv_sec_id character varying
	, is_rebal numeric
	, rebal_intv character varying
	, accno character varying
	, date_no character varying
	, sunamt numeric
	, dtsunik numeric
	, mamt numeric
	, sunamt1 numeric
	, cts_expcode character varying
	, tappamt numeric
	, tdtsunik numeric
	)
AS
$$
DECLARE
	req_memb_email character varying;
BEGIN

SELECT
	COALESCE(req::json->>'memb_email', '') AS memb_email
INTO
	req_memb_email
FROM
	(SELECT CAST(req_json AS json) AS req) init
;

RETURN QUERY
	SELECT
		ki0400.memb_code
		, ki0400.memb_name
		, COALESCE(ki04.inv_sec_code, '') AS inv_sec_code
		, COALESCE(ki04.inv_sec_id, '') AS inv_sec_id
		, COALESCE(ki04.is_rebal, 0) AS is_rebal
		, COALESCE(ki04.rebal_intv, 'M') AS rebal_intv
		, COALESCE(ki04.accno, '') AS accno
		, COALESCE(ki04.date_no::varchar, '') AS date_no
		, COALESCE(ki04.sunamt, -1) AS sunamt
		, COALESCE(ki04.dtsunik, -1) AS dtsunik
		, COALESCE(ki04.mamt, -1) AS mamt
		, COALESCE(ki04.sunamt1, -1) AS sunamt1
		, COALESCE(ki04.cts_expcode, '') AS cts_expcode
		, COALESCE(ki04.tappamt, -1) AS tappamt
		, COALESCE(ki04.tdtsunik, -1) AS tdtsunik
	FROM
		t_ki_ki0400 ki0400
		LEFT OUTER JOIN (
			SELECT
				ki0410.memb_code
				, ki0410.inv_sec_code
				, ki0410.inv_sec_id
				, ki0420.is_rebal
				, ki0420.rebal_intv
				, ki0430.accno
				, ki0430.date_no
				, ki0430.date_updt
				, ki0430.sunamt
				, ki0430.dtsunik
				, ki0430.mamt
				, ki0430.sunamt1
				, ki0430.cts_expcode
				, ki0430.tappamt
				, ki0430.tdtsunik
			FROM
				t_ki_ki0410 ki0410
				LEFT OUTER JOIN t_ki_ki0420 ki0420
					ON 1 = 1
					AND ki0410.memb_code = ki0420.memb_code
					AND ki0410.inv_sec_code = ki0420.inv_sec_code
					AND ki0410.inv_sec_id = ki0420.inv_sec_id
				LEFT OUTER JOIN t_ki_ki0430 ki0430
					ON 1 = 1
					AND ki0410.memb_code = ki0430.memb_code
					AND ki0410.inv_sec_code = ki0430.inv_sec_code
					AND ki0410.inv_sec_id = ki0430.inv_sec_id
			) ki04
			ON 1 = 1
			AND ki0400.memb_code = ki04.memb_code
	WHERE 1 = 1
		AND ki0400.memb_email = req_memb_email
;

END;
$$
LANGUAGE plpgsql;

COMMIT;
