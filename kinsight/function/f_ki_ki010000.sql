DROP FUNCTION IF EXISTS f_ki_ki010000(text);
CREATE OR REPLACE FUNCTION f_ki_ki010000 (
	req_json text
)
RETURNS TABLE (
	shcode character varying
	, hname character varying
	, gubun character varying
	, etfgubun character varying
	)
AS
$$
DECLARE
	req_gubun character varying;
	req_etf_gubun character varying;
BEGIN

	SELECT
		COALESCE(req::json->>'gubun', '') AS gubun
		, COALESCE(req::json->>'etf_gubun') AS etf_gubun
	INTO
		req_gubun
		, req_etf_gubun
	FROM
		(SELECT CAST(req_json AS json) AS req) init
	;
	
	IF req_gubun = '' AND req_etf_gubun = '' THEN
		RETURN QUERY
			SELECT
				t8430.shcode
				, t8430.hname
				, t8430.gubun
				, t8430.etfgubun
			FROM
				t_eb_t8430 t8430
			ORDER BY t8430.shcode
			;
	ELSIF req_gubun <> '' AND req_etf_gubun = '' THEN
		RETURN QUERY
			SELECT
				t8430.shcode
				, t8430.hname
				, t8430.gubun
				, t8430.etfgubun
			FROM
				t_eb_t8430 t8430
			WHERE 1 = 1
				AND t8430.gubun = req_gubun
			ORDER BY t8430.shcode
			;
	ELSIF req_gubun = '' AND req_etf_gubun <> '' THEN
		RETURN QUERY
			SELECT
				t8430.shcode
				, t8430.hname
				, t8430.gubun
				, t8430.etfgubun
			FROM
				t_eb_t8430 t8430
			WHERE 1 = 1
				AND t8430.etfgubun = req_etf_gubun
			ORDER BY t8430.shcode
			;
	ELSE
		RETURN QUERY
			SELECT
				t8430.shcode
				, t8430.hname
				, t8430.gubun
				, t8430.etfgubun
			FROM
				t_eb_t8430 t8430
			WHERE 1 = 1
				AND t8430.gubun = req_gubun
				AND t8430.etfgubun = req_etf_gubun
			ORDER BY t8430.shcode
			;
	END IF;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
