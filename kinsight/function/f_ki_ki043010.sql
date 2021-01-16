DROP FUNCTION IF EXISTS f_ki_ki043010();
CREATE OR REPLACE FUNCTION f_ki_ki043010 (
)
RETURNS TABLE (
	memb_code character varying
	, memb_email character varying
	, inv_sec_code character varying
	, inv_sec_id character varying
	, inv_sec_enc text
	, date_no character varying
	)
AS
$$
DECLARE
BEGIN

RETURN QUERY
	SELECT
		ki0400.memb_code
		, ki0400.memb_email
		, ki0410.inv_sec_code
		, ki0410.inv_sec_id
		, ki0410.inv_sec_enc
		, TO_CHAR(NOW(), 'YYYYMMDDHH24MISS')::varchar AS date_no
	FROM
		t_ki_ki0400 ki0400
		, t_ki_ki0410 ki0410
	WHERE 1 = 1
		AND ki0400.memb_code = ki0410.memb_code
	;

END;
$$
LANGUAGE plpgsql;

COMMIT;
