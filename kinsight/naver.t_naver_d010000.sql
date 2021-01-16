DROP TABLE IF EXISTS t_naver_d010000 CASCADE;
CREATE TABLE t_naver_d010000 (
	item_code varchar(6) NOT NULL
	, job_date varchar(8)
	, date_inst timestamp DEFAULT NOW()
	, date_updt timestamp DEFAULT NOW()
	, data_hash varchar(32)
	, item_name varchar(64)
	, etf_type varchar(1)
);

CREATE UNIQUE INDEX uni_t_naver_d010000 ON t_naver_d010000 (item_code);

CREATE INDEX idx_i_t_naver_d010000 ON t_naver_d010000 (job_date);

COMMENT ON TABLE t_naver_d010000 IS '네이버 종목 목록';

COMMENT ON COLUMN t_naver_d010000.item_code IS '종목코드';
COMMENT ON COLUMN t_naver_d010000.job_date IS '종목코드';
COMMENT ON COLUMN t_naver_d010000.date_inst IS '등록일시';
COMMENT ON COLUMN t_naver_d010000.date_updt IS '수정일시';
COMMENT ON COLUMN t_naver_d010000.data_hash IS 'data hash';
COMMENT ON COLUMN t_naver_d010000.item_name IS '종목명';
COMMENT ON COLUMN t_naver_d010000.etf_type IS 'ETF 분류';

COMMIT;
