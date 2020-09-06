DROP FUNCTION IF EXISTS f_ki_ki011000(text);
CREATE OR REPLACE FUNCTION f_ki_ki011000 (
	req_json text
)
RETURNS TABLE (
	trdd_no_min int4
	, trdd_from character varying
	, trdd_no_max int4
	, trdd_to character varying
	)
AS
$$
DECLARE
BEGIN

	RETURN QUERY
		SELECT
			grp.trdd_no_min
			, (SELECT trdd FROM t_ki_ki0110 WHERE trdd_no = grp.trdd_no_min) AS trdd_from
			, grp.trdd_no_max
			, (SELECT trdd FROM t_ki_ki0110 WHERE trdd_no = grp.trdd_no_max) AS trdd_to
		FROM (
			SELECT
				MIN(ki0110.trdd_no) AS trdd_no_min
				, MAX(ki0110.trdd_no) AS trdd_no_max
			FROM
				t_ki_ki0110 ki0110
			) grp
		;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
