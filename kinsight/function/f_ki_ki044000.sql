DROP FUNCTION IF EXISTS f_ki_ki044000(text);
CREATE OR REPLACE FUNCTION f_ki_ki044000 (
	req_json text
)
RETURNS TABLE (
	shcode character varying
	, jangb character varying
	, janqty numeric
	, mdposqt numeric
	, pamt numeric
	, mamt numeric
	, sinamt numeric
	, lastdt character varying
	, msat numeric
	, mpms numeric
	, mdat numeric
	, mpmd numeric
	, jsat numeric
	, jpms numeric
	, jdat numeric
	, jpmd numeric
	, sysprocseq numeric
	, loandt character varying
	, hname character varying
	, marketgb character varying
	, jonggb character varying
	, janrt numeric
	, price numeric
	, appamt numeric
	, dtsunik numeric
	, sunikrt numeric
	, fee numeric
	, tax numeric
	, sininter numeric
	, asset character varying
	, region character varying
	, category character varying
	, memb_rate numeric
	, rebal_rate numeric
	, lose_rate numeric
	, gubun character varying
	, etfgubun character varying
	)
AS
$$
DECLARE
	req_memb_code character varying;
	req_inv_sec_code character varying;
	req_inv_sec_id character varying;
	req_accno character varying;
	req_date_no character varying;
BEGIN

SELECT
	COALESCE(req::json->>'memb_code', '') AS memb_code
	, COALESCE(req::json->>'inv_sec_code', '') AS inv_sec_code
	, COALESCE(req::json->>'inv_sec_id', '') AS inv_sec_id
	, COALESCE(req::json->>'accno', '') AS accno
	, COALESCE(req::json->>'date_no', '') AS accno
INTO
	req_memb_code
	, req_inv_sec_code
	, req_inv_sec_id
	, req_accno
	, req_date_no
FROM
	(SELECT CAST(req_json AS json) AS req) init
;

RETURN QUERY
	SELECT
		ki0440.shcode
		, ki0440.jangb
		, ki0440.janqty
		, ki0440.mdposqt
		, ki0440.pamt
		, ki0440.mamt
		, ki0440.sinamt
		, ki0440.lastdt
		, ki0440.msat
		, ki0440.mpms
		, ki0440.mdat
		, ki0440.mpmd
		, ki0440.jsat
		, ki0440.jpms
		, ki0440.jdat
		, ki0440.jpmd
		, ki0440.sysprocseq
		, ki0440.loandt
		, ki0440.hname
		, ki0440.marketgb
		, ki0440.jonggb
		, ki0440.janrt
		, ki0440.price
		, ki0440.appamt
		, ki0440.dtsunik
		, ki0440.sunikrt
		, ki0440.fee
		, ki0440.tax
		, ki0440.sininter
		, COALESCE(ki0120.asset, '') AS asset
		, COALESCE(ki0120.region, '') AS region
		, COALESCE(ki0120.category, '') AS category
		, COALESCE(ki0450.memb_rate, -1) AS memb_rate
		, COALESCE(ki0450.rebal_rate, -1) AS rebal_rate
		, COALESCE(ki0450.lose_rate, -1) AS lose_rate
		, COALESCE(t8430.gubun, '') AS gubun
		, COALESCE(t8430.etfgubun, '') AS etfgubun
	FROM
		t_ki_ki0440 ki0440
		LEFT OUTER JOIN t_eb_t8430 t8430
			ON 1 = 1
			AND t8430.shcode = ki0440.shcode
		LEFT OUTER JOIN t_ki_ki0120 ki0120
			ON 1 = 1
			AND ki0120.shcode = ki0440.shcode
		LEFT OUTER JOIN t_ki_ki0450 ki0450
			ON 1 = 1
			AND ki0450.memb_code = ki0440.memb_code
			AND ki0450.inv_sec_code = ki0440.inv_sec_code
			AND ki0450.inv_sec_id = ki0440.inv_sec_id
			AND ki0450.accno = ki0440.accno
			AND ki0450.shcode = ki0440.shcode
	WHERE 1 = 1
		AND ki0440.memb_code = req_memb_code
		AND ki0440.inv_sec_code = req_inv_sec_code
		AND ki0440.inv_sec_id = req_inv_sec_id
		AND ki0440.accno = req_accno
		AND ki0440.date_no = req_date_no
;

END;
$$
LANGUAGE plpgsql;

COMMIT;
