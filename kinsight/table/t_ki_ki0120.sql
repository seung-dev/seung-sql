-- DROP TABLE t_ki_ki0110;

CREATE TABLE t_ki_ki0120 (
	shcode varchar(6)
	, date_inst timestamp DEFAULT NOW()
	, date_updt timestamp DEFAULT NOW()
	, hname varchar(20)
	, asset varchar(32)
	, region varchar(32)
	, category varchar(32)
);
CREATE UNIQUE INDEX uni_t_ki_ki0120 ON t_ki_ki0120 (shcode)

-- Column comments

COMMENT ON TABLE t_ki_ki0120 IS '종목별 구분 설정';
COMMENT ON COLUMN t_ki_ki0120.shcode IS '종목코드';
COMMENT ON COLUMN t_ki_ki0120.date_inst IS '등록일시';
COMMENT ON COLUMN t_ki_ki0120.date_updt IS '수정일시';
COMMENT ON COLUMN t_ki_ki0120.hname IS '종목명';
COMMENT ON COLUMN t_ki_ki0120.asset IS '자산종류';
COMMENT ON COLUMN t_ki_ki0120.region IS '지역구분';
COMMENT ON COLUMN t_ki_ki0120.category IS '';
