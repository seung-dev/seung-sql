DROP FUNCTION IF EXISTS f_ki_ki030000(text);
CREATE OR REPLACE FUNCTION f_ki_ki030000 (
	req_json text
)
RETURNS TABLE (
	shcode character varying
	, hname character varying
	)
AS
$$
DECLARE
BEGIN

	RETURN QUERY
		SELECT
			t8430.shcode
			, t8430.hname
		FROM
			t_eb_t8430 t8430
		WHERE 1 = 1
			AND t8430.gubun = '1'
			AND t8430.etfgubun = '1'
		ORDER BY t8430.shcode
		;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
