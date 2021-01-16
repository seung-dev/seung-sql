DROP TABLE IF EXISTS t_naver_d012000 CASCADE;
CREATE TABLE t_naver_d012000 (
	item_code varchar(6) NOT NULL
	, item_sd varchar(6)
	, date_inst timestamp DEFAULT NOW()
	, date_updt timestamp DEFAULT NOW()
	, data_hash varchar(32) NOT NULL
	, is_est smallint DEFAULT 0
	, item_ta decimal(12, 2)
	, item_tl decimal(12, 2)
	, item_te decimal(12, 2)
	, item_tr decimal(12, 2)
	, item_oi decimal(12, 2)
	, item_ni decimal(12, 2)
	, item_nici decimal(12, 2)
	, item_cfo decimal(12, 2)
	, item_de decimal(12, 2)
);

CREATE UNIQUE INDEX uni_t_naver_d012000 ON t_naver_d012000 (item_code, item_sd);

COMMENT ON TABLE t_naver_d012000 IS '네이버 종목별 재무제표';
COMMENT ON COLUMN t_naver_d012000.item_code IS '종목코드';
COMMENT ON COLUMN t_naver_d012000.item_sd IS 'Settlement Date';
COMMENT ON COLUMN t_naver_d012000.date_inst IS '등록일시';
COMMENT ON COLUMN t_naver_d012000.date_updt IS '수정일시';
COMMENT ON COLUMN t_naver_d012000.data_hash IS 'data hash';
COMMENT ON COLUMN t_naver_d012000.is_est IS '1: estimated';
COMMENT ON COLUMN t_naver_d012000.item_ta IS 'Total Assets';
COMMENT ON COLUMN t_naver_d012000.item_tl IS 'Total Liabilities';
COMMENT ON COLUMN t_naver_d012000.item_te IS 'Total Equity';
COMMENT ON COLUMN t_naver_d012000.item_tr IS 'Total Revenue';
COMMENT ON COLUMN t_naver_d012000.item_oi IS 'Operating Income';
COMMENT ON COLUMN t_naver_d012000.item_ni IS 'Net Income';
COMMENT ON COLUMN t_naver_d012000.item_nici IS 'Net Income in Controlling Interest';
COMMENT ON COLUMN t_naver_d012000.item_cfo IS 'Cash From Operating';
COMMENT ON COLUMN t_naver_d012000.item_de IS 'Debt to Equity';

COMMIT;

