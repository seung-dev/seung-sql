CREATE OR REPLACE FUNCTION f_ki_ki011001 (
)
RETURNS TABLE (
	prev int
	, post int
	)
AS
$$
DECLARE
	base_date varchar(8) := '20021014';
	prev_count int := 0;
	post_count int := 0;
BEGIN

	INSERT INTO t_ki_ki0110 (
		trdd
		, trdd_no
		)
	SELECT
		ord.trdd
		, ord.trdd_no
	FROM (
		SELECT
			ROW_NUMBER() OVER(ORDER BY date ASC) AS trdd_no
			, t8413.date AS trdd
		FROM
			(
				SELECT
					DISTINCT date
				FROM
					t_eb_t8413
				WHERE 1 = 1
					AND date >= base_date
			) t8413
		) ord
		LEFT OUTER JOIN t_ki_ki0110 ki0110
			ON 1 = 1
			AND ki0110.trdd = ord.trdd
	WHERE 1 = 1
		AND ki0110.trdd IS NULL
	;
	
	GET DIAGNOSTICS post_count = ROW_COUNT;
	
	INSERT INTO t_ki_ki0110 (
		trdd
		, trdd_no
		)
	SELECT
		ord.trdd
		, ord.trdd_no * -1 + 1 AS trdd_no
	FROM (
		SELECT
			ROW_NUMBER() OVER(ORDER BY date DESC) AS trdd_no
			, t8413.date AS trdd
		FROM
			(
				SELECT
					DISTINCT date
				FROM
					t_eb_t8413
				WHERE 1 = 1
					AND date < base_date
			) t8413
		) ord
		LEFT OUTER JOIN t_ki_ki0110 ki0110
			ON 1 = 1
			AND ki0110.trdd = ord.trdd
	WHERE 1 = 1
		AND ki0110.trdd IS NULL
	;
	
	GET DIAGNOSTICS prev_count = ROW_COUNT;
	
	RETURN QUERY SELECT prev_count AS prev, post_count AS post;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
