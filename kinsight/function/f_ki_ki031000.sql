CREATE OR REPLACE FUNCTION public.f_ki_ki031000(
	req_json text
	)
RETURNS TABLE(
		shcode character varying
		, hname character varying
		, asset character varying
		, region character varying
		, category character varying
		, etf_type character varying
		, expn_rate character varying
		, date character varying
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
		, navdiff numeric
		, nav numeric
		, navchange numeric
		, crate numeric
		, grate numeric
		, jisu numeric
		, jichange numeric
		, jirate numeric
		, d20_vol_size integer
		, d20_vol numeric
		, d20_volaccu_size integer
		, d20_volaccu numeric
		, d5_mmnt_size integer
		, d5_mmnt numeric
		, d5_mmnt_score numeric
		, d5_std_dev numeric
		, d10_mmnt_size integer
		, d10_mmnt numeric
		, d10_mmnt_score numeric
		, d10_std_dev numeric
		, d20_mmnt_size integer
		, d20_mmnt numeric
		, d20_mmnt_score numeric
		, d20_std_dev numeric
		, d60_mmnt_size integer
		, d60_mmnt numeric
		, d60_mmnt_score numeric
		, d60_std_dev numeric
		, m3_mmnt_size integer
		, m3_mmnt numeric
		, m3_mmnt_score numeric
		, m3_std_dev numeric
		, m6_mmnt_size integer
		, m6_mmnt numeric
		, m6_mmnt_score numeric
		, m6_std_dev numeric
		, m12_mmnt_size integer
		, m12_mmnt numeric
		, m12_mmnt_score numeric
		, m12_std_dev numeric
		, mmnt numeric
		, mmnt_size bigint
		)
 LANGUAGE plpgsql
AS $function$
DECLARE
	query_text TEXT := '';
	v_std_trdd_no int;
	v_std_trdd varchar(8);
	v_etf_mc_min int;
	v_etf_volaccu_min int;
	v_etf_etfd_from decimal(4, 2);
	v_etf_etfd_to decimal(4, 2);
	v_etf_ter_from decimal(4, 2);
	v_etf_ter_to decimal(4, 2);
	v_mmnt_date varchar(8);
	v_mmnt_unit int;
	v_mmnt_scope int;
	v_mmnt_min_max varchar(3);
	v_mmnt_threshold decimal(8, 4);
	v_threshold varchar(128);
	v_sort varchar(128);
	v_rules TEXT := '';
BEGIN

	SELECT
		ki0110.trdd_no
		, ki0110.trdd
	INTO
		v_std_trdd_no
		, v_std_trdd
	FROM
		t_ki_ki0110 ki0110
	ORDER BY ki0110.trdd_no DESC
	LIMIT 1
	;
	
	SELECT
		req.etf_mc::int
		, req.etf_volaccu::int
		, req.etf_etfd_from::decimal
		, req.etf_etfd_to::decimal
		, req.etf_ter_from::decimal
		, req.etf_ter_to::decimal
		, CASE
			WHEN COALESCE(req.mmnt_date, '') = '' THEN v_std_trdd
			ELSE req.mmnt_date
			END AS mmnt_date
		, CASE
			WHEN LOWER(req.mmnt_unit) = 'd' THEN 1
			WHEN LOWER(req.mmnt_unit) = 'w' THEN 5
			WHEN LOWER(req.mmnt_unit) = 'm' THEN 20
			ELSE 0
			END AS mmnt_unit
		, req.mmnt_scope::int
		, req.mmnt_min_max
		, req.mmnt_threshold::decimal
		, CASE
			WHEN req.mmnt_min_max = 'min' THEN CONCAT(
				'AND COALESCE(calc_mmnt.mmnt, -1) >= '
				, req.mmnt_threshold
				)
			WHEN req.mmnt_min_max = 'max' THEN CONCAT(
				'AND COALESCE(calc_mmnt.mmnt, -1) <= '
				, req.mmnt_threshold
				)
			ELSE ''
			END AS v_threshold_sql
		, CASE
			WHEN req.mmnt_min_max = 'min' THEN 'ORDER BY COALESCE(calc_mmnt.mmnt, -1) DESC'
			WHEN req.mmnt_min_max = 'max' THEN 'ORDER BY COALESCE(calc_mmnt.mmnt, -1) ASC'
			ELSE ''
			END AS v_sort_sql
		, COALESCE(req.rules, '')
	INTO
		v_etf_mc_min
		, v_etf_volaccu_min
		, v_etf_etfd_from
		, v_etf_etfd_to
		, v_etf_ter_from
		, v_etf_ter_to
		, v_mmnt_date
		, v_mmnt_unit
		, v_mmnt_scope
		, v_mmnt_min_max
		, v_mmnt_threshold
		, v_threshold
		, v_sort
		, v_rules
	FROM (
		SELECT
			req::json->>'etf_mc' AS etf_mc
			, req::json->>'etf_volaccu' AS etf_volaccu
			, req::json->>'etf_etfd_from' AS etf_etfd_from
			, req::json->>'etf_etfd_to' AS etf_etfd_to
			, req::json->>'etf_ter_from' AS etf_ter_from
			, req::json->>'etf_ter_to' AS etf_ter_to
			, REGEXP_REPLACE(req::json->>'mmnt_date', '[^0-9]', '', 'g') AS mmnt_date
			, req::json->>'mmnt_unit' AS mmnt_unit
			, req::json->>'mmnt_scope' AS mmnt_scope
			, req::json->>'mmnt_min_max' AS mmnt_min_max
			, req::json->>'mmnt_threshold' AS mmnt_threshold
			, req::json->>'rules' AS rules
		FROM
			(SELECT CAST(req_json AS json) AS req) init
		) req
	;
	
	RETURN QUERY
		SELECT
			items.shcode
			, items.hname
			, items.asset
			, items.region
			, items.category
			, items.etf_type
			, items.expn_rate
			, t1305.date
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
			, t1903.navdiff
			, t1903.nav
			, t1903.navchange
			, t1903.crate
			, t1903.grate
			, t1903.jisu
			, t1903.jichange
			, t1903.jirate
			, COALESCE(ki0310.d20_vol_size, -1) AS d20_vol_size
			, COALESCE(ki0310.d20_vol, -1) AS d20_vol
			, COALESCE(ki0310.d20_volaccu_size, -1) AS d20_volaccu_size
			, COALESCE(ki0310.d20_volaccu, -1) AS d20_volaccu
			, COALESCE(ki0310.d5_mmnt_size, -1) AS d5_mmnt_size
			, COALESCE(ki0310.d5_mmnt, -1) AS d5_mmnt
			, COALESCE(ki0310.d5_mmnt_score, -1) AS d5_mmnt_score
			, COALESCE(ki0310.d5_std_dev, -1) AS d5_std_dev
			, COALESCE(ki0310.d10_mmnt_size, -1) AS d10_mmnt_size
			, COALESCE(ki0310.d10_mmnt, -1) AS d10_mmnt
			, COALESCE(ki0310.d10_mmnt_score, -1) AS d10_mmnt_score
			, COALESCE(ki0310.d10_std_dev, -1) AS d10_std_dev
			, COALESCE(ki0310.d20_mmnt_size, -1) AS d20_mmnt_size
			, COALESCE(ki0310.d20_mmnt, -1) AS d20_mmnt
			, COALESCE(ki0310.d20_mmnt_score, -1) AS d20_mmnt_score
			, COALESCE(ki0310.d20_std_dev, -1) AS d20_std_dev
			, COALESCE(ki0310.d60_mmnt_size, -1) AS d60_mmnt_size
			, COALESCE(ki0310.d60_mmnt, -1) AS d60_mmnt
			, COALESCE(ki0310.d60_mmnt_score, -1) AS d60_mmnt_score
			, COALESCE(ki0310.d60_std_dev, -1) AS d60_std_dev
			, COALESCE(ki0310.m3_mmnt_size, -1) AS m3_mmnt_size
			, COALESCE(ki0310.m3_mmnt, -1) AS m3_mmnt
			, COALESCE(ki0310.m3_mmnt_score, -1) AS m3_mmnt_score
			, COALESCE(ki0310.m3_std_dev, -1) AS m3_std_dev
			, COALESCE(ki0310.m6_mmnt_size, -1) AS m6_mmnt_size
			, COALESCE(ki0310.m6_mmnt, -1) AS m6_mmnt
			, COALESCE(ki0310.m6_mmnt_score, -1) AS m6_mmnt_score
			, COALESCE(ki0310.m6_std_dev, -1) AS m6_std_dev
			, COALESCE(ki0310.m12_mmnt_size, -1) AS m12_mmnt_size
			, COALESCE(ki0310.m12_mmnt, -1) AS m12_mmnt
			, COALESCE(ki0310.m12_mmnt_score, -1) AS m12_mmnt_score
			, COALESCE(ki0310.m12_std_dev, -1) AS m12_std_dev
			, COALESCE(calc.mmnt, -1) AS mmnt
			, COALESCE(calc.mmnt_size, -1) AS mmnt_size
			--, -1::numeric AS mmnt
			--, -1::bigint AS mmnt_size
		FROM (
			SELECT
				t8430.shcode
				, t9945.hname
				, COALESCE(ki0120.asset, '') AS asset
				, COALESCE(ki0120.region, '') AS region
				, COALESCE(ki0120.category, '') AS category
				, COALESCE(n0101.etf_type, '') AS etf_type
				, COALESCE(n0102.expn_rate, '') AS expn_rate
			FROM
				t_eb_t8430 t8430
				LEFT OUTER JOIN t_etf_n0101 n0101
					ON 1 = 1
					AND t8430.shcode = n0101.item_code
				LEFT OUTER JOIN t_etf_n0102 n0102
					ON 1 = 1
					AND t8430.shcode = n0102.item_code
				LEFT OUTER JOIN t_ki_ki0120 ki0120
					ON 1 = 1
					AND t8430.shcode = ki0120.shcode
				, t_eb_t9945 t9945
			WHERE 1 = 1
				AND t8430.shcode = t9945.shcode
				AND t8430.gubun = '1'
				AND t8430.etfgubun = '1'
			) items
			LEFT OUTER JOIN (
				SELECT
					summ_mmnt.shcode
					, summ_mmnt.mmnt_size
					, CASE
						WHEN summ_mmnt.mmnt_size <> v_mmnt_scope THEN -1
						ELSE summ_mmnt.mmnt
						END AS mmnt
				FROM (
					SELECT
						ord_mmnt.shcode
						, COUNT(*) AS mmnt_size
						, AVG(ord_mmnt.mmnt) AS mmnt
					FROM (
						SELECT
							t1305_mmnt.shcode
							, trdd_mmnt.trdd
							, base_mmnt.base_no - trdd_mmnt.trdd_no AS trdd_no
							, ABS(base_mmnt.base_cp / t1305_mmnt.close) AS mmnt
						FROM
							t_ki_ki0110 trdd_mmnt
							, t_eb_t1305 t1305_mmnt
							LEFT OUTER JOIN (
								SELECT
									a_mmnt.trdd_no AS base_no
									, b_mmnt.close::decimal AS base_cp
									, b_mmnt.shcode
								FROM
									t_ki_ki0110 a_mmnt
									, t_eb_t1305 b_mmnt
								WHERE 1 = 1
									AND a_mmnt.trdd = b_mmnt.date
									AND a_mmnt.trdd = v_mmnt_date
								) base_mmnt
								ON 1 = 1
								AND base_mmnt.shcode = t1305_mmnt.shcode
							WHERE 1 = 1
								AND trdd_mmnt.trdd = t1305_mmnt.date
								AND trdd_mmnt.trdd < v_mmnt_date
							) ord_mmnt
						WHERE 1 = 1
							AND ord_mmnt.trdd_no % v_mmnt_unit = 0
							AND ord_mmnt.trdd_no <= v_mmnt_unit * v_mmnt_scope
							GROUP BY ord_mmnt.shcode
						) summ_mmnt
				) calc
				ON 1 = 1
				AND items.shcode = calc.shcode
			, t_eb_t1305 t1305
			, t_eb_t1903 t1903
			, t_ki_ki0310 ki0310
		WHERE 1 = 1
			AND items.shcode = t1305.shcode
			AND items.shcode = t1903.shcode
			AND items.shcode = ki0310.shcode
			AND t1305.date = t1903.date
			AND t1305.date = ki0310.trdd
			AND t1305.date = v_std_trdd
		;

END;
$function$
;
