DROP FUNCTION IF EXISTS f_ki_ki031000(text);
CREATE OR REPLACE FUNCTION f_ki_ki031000 (
    req_json text
)
RETURNS TABLE (
    shcode character varying
    , hname character varying
    , etf_type character varying
    , expn_rate character varying
    , mmnt numeric
    , mmnt_size bigint
    , d20_vol_size int
    , d20_vol numeric
    , d20_volaccu_size int
    , d20_volaccu numeric
    , d5_mmnt_size int
    , d5_mmnt numeric
    , d5_mmnt_score numeric
    , d5_std_dev numeric
    , d10_mmnt_size int
    , d10_mmnt numeric
    , d10_mmnt_score numeric
    , d10_std_dev numeric
    , d20_mmnt_size int
    , d20_mmnt numeric
    , d20_mmnt_score numeric
    , d20_std_dev numeric
    , d60_mmnt_size int
    , d60_mmnt numeric
    , d60_mmnt_score numeric
    , d60_std_dev numeric
    , m3_mmnt_size int
    , m3_mmnt numeric
    , m3_mmnt_score numeric
    , m3_std_dev numeric
    , m6_mmnt_size int
    , m6_mmnt numeric
    , m6_mmnt_score numeric
    , m6_std_dev numeric
    , m12_mmnt_size int
    , m12_mmnt numeric
    , m12_mmnt_score numeric
    , m12_std_dev numeric
    )
AS
$function$
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
        trd.trdd_no
        , trd.trdd
    INTO
        v_std_trdd_no
        , v_std_trdd
    FROM
        t_etf_trdd trd
    ORDER BY trd.trdd_no DESC
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
    
    query_text := CONCAT(
        query_text
        , '  SELECT'  
        , '      items.shcode'  
        , '      , items.hname'  
        , '      , COALESCE(calc_mmnt.mmnt, -1)'  
        , '      , COALESCE(calc_mmnt.mmnt_size, 0)'  
        , '      , items.etf_type'  
        , '      , items.expn_rate'  
        , '      , tr10001.etf_fm'  
        , '      , tr10001.etf_fv'  
        , '      , tr10001.etf_equity'  
        , '      , tr10001.etf_is'  
        , '      , tr10001.etf_cr'  
        , '      , tr10001.etf_yh'  
        , '      , tr10001.etf_yl'  
        , '      , tr10001.etf_mc'  
        , '      , tr10001.etf_mcr'  
        , '      , tr10001.etf_for'  
        , '      , tr10001.etf_sp'  
        , '      , tr10001.etf_250h'  
        , '      , tr10001.etf_250l'  
        , '      , tr10001.etf_op'  
        , '      , tr10001.etf_hp'  
        , '      , tr10001.etf_lp'  
        , '      , tr10001.etf_hhp'  
        , '      , tr10001.etf_llp'  
        , '      , tr10001.etf_bp'  
        , '      , tr10001.etf_ep'  
        , '      , tr10001.etf_eq'  
        , '      , tr10001.etf_d250h'  
        , '      , tr10001.etf_vs250h'  
        , '      , tr10001.etf_d250l'  
        , '      , tr10001.etf_vs250l'  
        , '      , tr10001.etf_pp'  
        , '      , tr10001.etf_pinc'  
        , '      , tr10001.etf_pcv'  
        , '      , tr10001.etf_fvu'  
        , '      , tr10001.etf_os'  
        , '      , tr10001.etf_osr'  
        , '      , tr40005.trdd'  
        , '      , ABS(tr40005.etf_cp)'  
        , '      , tr40005.etf_inc'  
        , '      , tr40005.etf_pcp'  
        , '      , ABS(tr40005.etf_vol)'  
        , '      , ABS(tr40005.etf_nav)'  
        , '      , ABS(tr40005.etf_volaccu)'  
        , '      , tr40005.etf_indexd'  
        , '      , tr40005.etf_etfd'  
        , '      , tr40005.etf_ter'  
        , '      , tr40005.etf_ti'  
        , '      , tr40005.etf_tiinc'  
        , '      , COALESCE(calc.d20_vol_size, 0)'  
        , '      , COALESCE(calc.d20_vol, -1)'  
        , '      , COALESCE(calc.d20_volaccu_size, 0)'  
        , '      , COALESCE(calc.d20_volaccu, -1)'  
        , '      , COALESCE(calc.d5_mmnt_size, 0)'  
        , '      , COALESCE(calc.d5_mmnt, -1)'  
        , '      , COALESCE(calc.d5_mmnt_score, -1)'  
        , '      , COALESCE(calc.d5_std_dev, -1)'  
        , '      , COALESCE(calc.d10_mmnt_size, 0)'  
        , '      , COALESCE(calc.d10_mmnt, -1)'  
        , '      , COALESCE(calc.d10_mmnt_score, -1)'  
        , '      , COALESCE(calc.d10_std_dev, -1)'  
        , '      , COALESCE(calc.d20_mmnt_size, 0)'  
        , '      , COALESCE(calc.d20_mmnt, -1)'  
        , '      , COALESCE(calc.d20_mmnt_score, -1)'  
        , '      , COALESCE(calc.d20_std_dev, -1)'  
        , '      , COALESCE(calc.d60_mmnt_size, 0)'  
        , '      , COALESCE(calc.d60_mmnt, -1)'  
        , '      , COALESCE(calc.d60_mmnt_score, -1)'  
        , '      , COALESCE(calc.d60_std_dev, -1)'  
        , '      , COALESCE(calc.m3_mmnt_size, 0)'  
        , '      , COALESCE(calc.m3_mmnt, -1)'  
        , '      , COALESCE(calc.m3_mmnt_score, -1)'  
        , '      , COALESCE(calc.m3_std_dev, -1)'  
        , '      , COALESCE(calc.m6_mmnt_size, 0)'  
        , '      , COALESCE(calc.m6_mmnt, -1)'  
        , '      , COALESCE(calc.m6_mmnt_score, -1)'  
        , '      , COALESCE(calc.m6_std_dev, -1)'  
        , '      , COALESCE(calc.m12_mmnt_size, 0)'  
        , '      , COALESCE(calc.m12_mmnt, -1)'  
        , '      , COALESCE(calc.m12_mmnt_score, -1)'  
        , '      , COALESCE(calc.m12_std_dev, -1)'  
        , '      , tr40005.date_updt'  
        );
    
    query_text := CONCAT(
        query_text
        , '  FROM ('  
        , '      SELECT'  
        , '          kw10000.shcode'  
        , '          , kw10000.hname'  
        , '          , n0101.etf_type'  
        , '          , n0102.expn_rate'  
        , '      FROM'  
        , '          t_kw_kw10000 kw10000'  
        , '          LEFT OUTER JOIN t_etf_n0101 n0101'  
        , '              ON 1 = 1'  
        , '              AND kw10000.shcode = n0101.shcode'  
        , '          LEFT OUTER JOIN t_etf_n0102 n0102'  
        , '              ON 1 = 1'  
        , '              AND kw10000.shcode = n0102.shcode'  
        , '      WHERE 1 = 1'  
        , '          AND kw10000.mrkt_type = ''3'''  
        --, '          AND kw10000.on_prgr = ''1'''  
        , '      ) items'  
        );
    
    query_text := CONCAT(
        query_text
        , '      LEFT OUTER JOIN ('  
        , '          SELECT'  
        , '              summ_mmnt.shcode'  
        , '              , summ_mmnt.mmnt_size'  
        , '              , CASE'  
        , '                  WHEN summ_mmnt.mmnt_size <> v_mmnt_scope THEN -1'  
        , '                  ELSE summ_mmnt.mmnt'  
        , '                  END AS mmnt'  
        , '          FROM ('  
        , '              SELECT'  
        , '                  ord_mmnt.shcode'  
        , '                  , COUNT(*) AS mmnt_size'  
        , '                  , AVG(ord_mmnt.mmnt) AS mmnt'  
        , '              FROM ('  
        , '                  SELECT'  
        , '                      tr40005_mmnt.shcode'  
        , '                      , trdd_mmnt.trdd'  
        , '                      , base_mmnt.base_no - trdd_mmnt.trdd_no AS trdd_no'  
        , '                      , ABS(base_mmnt.base_cp / tr40005_mmnt.etf_cp) AS mmnt'  
        , '                  FROM'  
        , '                      t_etf_trdd trdd_mmnt'  
        , '                      , t_kw_tr40005 tr40005_mmnt'  
        , '                      LEFT OUTER JOIN ('  
        , '                          SELECT'  
        , '                              a_mmnt.trdd_no AS base_no'  
        , '                              , b_mmnt.etf_cp AS base_cp'  
        , '                              , b_mmnt.shcode'  
        , '                          FROM'  
        , '                              t_etf_trdd a_mmnt'  
        , '                              , t_kw_tr40005 b_mmnt'  
        , '                          WHERE 1 = 1'  
        , '                              AND a_mmnt.trdd = b_mmnt.trdd'  
        , '                              AND a_mmnt.trdd = v_mmnt_date'  
        , '                          ) base_mmnt'  
        , '                          ON 1 = 1'  
        , '                          AND base_mmnt.shcode = tr40005_mmnt.shcode'  
        , '                  WHERE 1 = 1'  
        , '                      AND trdd_mmnt.trdd = tr40005_mmnt.trdd'  
        , '                      AND trdd_mmnt.trdd < v_mmnt_date'  
        , '                  ) ord_mmnt'  
        , '              WHERE 1 = 1'  
        , '                  AND ord_mmnt.trdd_no % v_mmnt_unit = 0'  
        , '                  AND ord_mmnt.trdd_no <= v_mmnt_unit * v_mmnt_scope'  
        , '              GROUP BY ord_mmnt.shcode'  
        , '              ) summ_mmnt'  
        , '          ) calc_mmnt'  
        , '          ON 1 = 1'  
        , '          AND items.shcode = calc_mmnt.shcode'  
        );
    
    query_text := CONCAT(
        query_text
        , '      LEFT OUTER JOIN t_etf_calc calc'  
        , '          ON 1 = 1'  
        , '          AND items.shcode = calc.shcode'
        , '          AND calc.trdd = v_std_trdd'    
        );
    
    query_text := CONCAT(
        query_text
        , '      , t_kw_tr10001 tr10001'  
        , '      , t_kw_tr40005 tr40005'  
        , '  WHERE 1 = 1'  
        , '      AND items.shcode = tr10001.shcode'  
        , '      AND items.shcode = tr40005.shcode'  
        , '      AND tr40005.trdd = v_std_trdd'  
        --, '      AND tr10001.etf_mc >= v_etf_mc_min'  
        --, '      AND tr40005.etf_volaccu >= v_etf_volaccu_min'  
        --, '      AND tr40005.etf_etfd >= v_etf_etfd_from'  
        --, '      AND tr40005.etf_etfd <= v_etf_etfd_to'  
        --, '      AND tr40005.etf_ter >= v_etf_ter_from'  
        --, '      AND tr40005.etf_ter <= v_etf_ter_to'  
        --, '      AND COALESCE(calc_mmnt.mmnt, -1) >= v_mmnt_threshold'  
        --, '      v_threshold'  
        --, '  ORDER BY COALESCE(calc_mmnt.mmnt, -1) DESC'  
        , '  v_sort'  
        , '  ;'  
        );
    
    --query_text := REPLACE(query_text, 'v_std_trdd_no', COALESCE(v_std_trdd_no, 1)::varchar);
    query_text := REPLACE(query_text, 'v_std_trdd', CONCAT('''', v_std_trdd, ''''));
    --query_text := REPLACE(query_text, 'v_etf_mc_min', COALESCE(v_etf_mc_min, 150)::varchar);
    --query_text := REPLACE(query_text, 'v_etf_volaccu_min', COALESCE(v_etf_volaccu_min, 100)::varchar);
    --query_text := REPLACE(query_text, 'v_etf_etfd_from', COALESCE(v_etf_etfd_from, -5)::varchar);
    --query_text := REPLACE(query_text, 'v_etf_etfd_to', COALESCE(v_etf_etfd_to, 0)::varchar);
    --query_text := REPLACE(query_text, 'v_etf_ter_from', COALESCE(v_etf_ter_from, -5)::varchar);
    --query_text := REPLACE(query_text, 'v_etf_ter_to', COALESCE(v_etf_ter_to, 5)::varchar);
    query_text := REPLACE(query_text, 'v_mmnt_date', CONCAT('''', v_mmnt_date, ''''));
    query_text := REPLACE(query_text, 'v_mmnt_unit', COALESCE(v_mmnt_unit, 20)::varchar);
    query_text := REPLACE(query_text, 'v_mmnt_scope', COALESCE(v_mmnt_scope, 12)::varchar);
    query_text := REPLACE(query_text, 'v_mmnt_min_max', v_mmnt_min_max);
    --query_text := REPLACE(query_text, 'v_mmnt_threshold', COALESCE(v_mmnt_threshold, 1)::varchar);
    --query_text := REPLACE(query_text, 'v_threshold', v_threshold);
    query_text := REPLACE(query_text, 'v_sort', v_sort);
    --query_text := REPLACE(query_text, 'v_rules, v_rules);
    
    RETURN QUERY EXECUTE query_text;
    --RETURN query_text;
    
END;
$function$
LANGUAGE plpgsql;

COMMIT;
