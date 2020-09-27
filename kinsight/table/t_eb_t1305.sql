DROP TABLE IF EXISTS t_eb_t1305 CASCADE;
CREATE TABLE t_eb_t1305 (
	shcode varchar(6)
	, date varchar(8)
	, date_inst timestamp DEFAULT NOW()
	, date_updt timestamp DEFAULT NOW()
	, hash varchar(32)
	, open numeric(8, 0)
	, high numeric(8, 0)
	, low numeric(8, 0)
	, close numeric(8, 0)
	, sign varchar(1)
	
	, change numeric(8, 0)
	, diff numeric(6, 2)
	, volume numeric(12, 0)
	, fpvolume numeric(12, 0)
	, covolume numeric(12, 0)
	, ppvolume numeric(12, 0)
	, value numeric(12, 0)
	, marketcap numeric(12, 0)
);

CREATE UNIQUE INDEX uni_t_eb_t1305 ON t_eb_t1305 (shcode, date DESC);

COMMENT ON TABLE t_eb_t1305 IS '이베스트 종목 일별 내역';

COMMENT ON COLUMN t_eb_t1305.shcode IS '종목코드';
COMMENT ON COLUMN t_eb_t1305.date IS '거래일자';
COMMENT ON COLUMN t_eb_t1305.date_inst IS '등록일시';
COMMENT ON COLUMN t_eb_t1305.date_updt IS '수정일시';
COMMENT ON COLUMN t_eb_t1305.hash IS 'data hash';
COMMENT ON COLUMN t_eb_t1305.open IS '시가';
COMMENT ON COLUMN t_eb_t1305.high IS '고가';
COMMENT ON COLUMN t_eb_t1305.low IS '저가';
COMMENT ON COLUMN t_eb_t1305.close IS '종가';
COMMENT ON COLUMN t_eb_t1305.sign IS '종가등락구분 - 1: 상한, 2: 상승, 3: 보합';
COMMENT ON COLUMN t_eb_t1305.change IS '전일대비';
COMMENT ON COLUMN t_eb_t1305.diff IS '등락율';
COMMENT ON COLUMN t_eb_t1305.volume IS '누적거래량';
COMMENT ON COLUMN t_eb_t1305.fpvolume IS '외인순매수';
COMMENT ON COLUMN t_eb_t1305.covolume IS '기관순매수';
COMMENT ON COLUMN t_eb_t1305.ppvolume IS '개인순매수';
COMMENT ON COLUMN t_eb_t1305.value IS '누적거래대금(단위:백만)';
COMMENT ON COLUMN t_eb_t1305.marketcap IS '시가총액(단위:백만)';

COMMIT;
