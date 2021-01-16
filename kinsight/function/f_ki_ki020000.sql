DROP FUNCTION IF EXISTS f_ki_ki020000(text);
CREATE OR REPLACE FUNCTION f_ki_ki020000 (
	req_json text
)
RETURNS TABLE (
	shcode character varying
	, hname character varying
	, item_data json
	, date character varying
	, close numeric
	)
AS
$$
DECLARE
	req_item_code character varying;
	req_item_sd_from character varying;
	req_item_sd_to character varying;
BEGIN

	SELECT
		req::json->>'item_code'
		, REGEXP_REPLACE(req::json->>'item_sd_from', '[^0-9]', '', 'g') AS trdd_from
		, REGEXP_REPLACE(req::json->>'item_sd_to', '[^0-9]', '', 'g') AS trdd_to
	INTO
		req_item_code
		, req_item_sd_from
		, req_item_sd_to
	FROM
		(SELECT CAST(req_json AS json) AS req) init
	;
	
	SELECT
		CASE
			WHEN COALESCE(req_item_sd_from, '') = '' THEN '200001'
			ELSE req_item_sd_from
			END AS req_item_sd_from
		, CASE
			WHEN COALESCE(req_item_sd_to, '') = '' THEN CONCAT(TO_CHAR(now() + interval '2 year', 'YYYY'), '12')
			ELSE req_item_sd_to
			END AS req_item_sd_to
	INTO
		req_item_sd_from
		, req_item_sd_to
		;
	
	RETURN QUERY
		SELECT
			item.shcode
			, item.hname
			, ki0201.item_data
			, item.date
			, item.close
		FROM (
			SELECT
				grp.item_code
				, JSON_AGG(
					grp.item_data
					ORDER BY grp.item_sd
					) AS item_data
			FROM
				(
					SELECT
						n0104.item_code
						, n0104.item_sd
						, JSON_BUILD_OBJECT(
							'item_sd'
							, n0104.item_sd
							, 'is_est'
							, n0104.is_est
							, 'item_ta'
							, n0104.item_ta
							, 'item_tl'
							, n0104.item_tl
							, 'item_te'
							, n0104.item_te
							, 'item_tr'
							, n0104.item_tr
							, 'item_oi'
							, n0104.item_oi
							, 'item_ni'
							, n0104.item_ni
							, 'item_nici'
							, n0104.item_nici
							, 'item_cfo'
							, n0104.item_cfo
							, 'item_de'
							, n0104.item_de
							) AS item_data
					FROM (
						SELECT
							item_code
							, item_sd
							, is_est
							, item_ta
							, item_tl
							, item_te
							, item_tr
							, item_oi
							, item_ni
							, item_nici
							, item_cfo
							, item_de
						FROM
							t_naver_n0104
						WHERE 1 = 1
							AND item_code LIKE CONCAT('%', req_item_code, '%')
							AND item_sd >= req_item_sd_from
							AND item_sd <= req_item_sd_to
						) n0104
				) grp
				GROUP BY item_code
			) ki0201
			, (
				SELECT
					t8430.shcode
					, t8430.hname
					, t1305.date
					, t1305.close
				FROM
					t_eb_t8430 t8430
					LEFT OUTER JOIN t_eb_t1305 t1305
						ON 1 = 1
						AND t8430.shcode = t1305.shcode
						AND t1305.date = (
							SELECT
								MAX(trdd) AS trdd
							FROM
								t_ki_ki0110
						)
				WHERE 1 = 1
			) item
		WHERE 1 = 1
			AND ki0201.item_code = item.shcode
		;
	
END;
$$
LANGUAGE plpgsql;

COMMIT;
