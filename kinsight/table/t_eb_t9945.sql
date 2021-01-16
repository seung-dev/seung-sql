DROP TABLE IF EXISTS t_eb_t9945 CASCADE;
CREATE TABLE t_eb_t9945 (
	shcode varchar(6)
	, date_inst timestamp DEFAULT NOW()
	, date_updt timestamp DEFAULT NOW()
	, hash varchar(32)
	, hname varchar(40)
	, expcode varchar(12)
	, etfchk varchar(1)
	, filler varchar(5)
);

CREATE UNIQUE INDEX uni_t_eb_t9945 ON t_eb_t9945 (shcode);

COMMENT ON TABLE t_eb_t9945 IS '이베스트 주식마스터조회 API용';

COMMENT ON COLUMN t_eb_t9945.shcode IS '종목코드';
COMMENT ON COLUMN t_eb_t9945.date_inst IS '등록일시';
COMMENT ON COLUMN t_eb_t9945.date_updt IS '수정일시';
COMMENT ON COLUMN t_eb_t9945.hash IS 'data hash';
COMMENT ON COLUMN t_eb_t9945.hname IS '종목명';
COMMENT ON COLUMN t_eb_t9945.expcode IS '확장코드';
COMMENT ON COLUMN t_eb_t9945.etfchk IS 'ETF구분';
COMMENT ON COLUMN t_eb_t9945.filler IS 'filler';
