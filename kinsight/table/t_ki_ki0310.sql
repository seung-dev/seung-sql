DROP TABLE IF EXISTS t_ki_ki0310 CASCADE;
CREATE TABLE t_ki_ki0310 (
	shcode varchar(6) NOT NULL
	, trdd varchar(8) NOT NULL
	, date_inst timestamp DEFAULT NOW()
	, date_updt timestamp DEFAULT NOW()
	, d20_vol_size int
	, d20_vol decimal(14, 4)
	, d20_volaccu_size int
	, d20_volaccu decimal(12, 4)
	, d5_mmnt_size int
	, d5_mmnt decimal(8, 4)
	, d5_mmnt_score decimal(6, 4)
	, d5_std_dev decimal(6, 4)
	, d10_mmnt_size int
	, d10_mmnt decimal(8, 4)
	, d10_mmnt_score decimal(6, 4)
	, d10_std_dev decimal(6, 4)
	, d20_mmnt_size int
	, d20_mmnt decimal(8, 4)
	, d20_mmnt_score decimal(6, 4)
	, d20_std_dev decimal(6, 4)
	, d60_mmnt_size int
	, d60_mmnt decimal(8, 4)
	, d60_mmnt_score decimal(6, 4)
	, d60_std_dev decimal(6, 4)
	, m3_mmnt_size int
	, m3_mmnt decimal(8, 4)
	, m3_mmnt_score decimal(6, 4)
	, m3_std_dev decimal(6, 4)
	, m6_mmnt_size int
	, m6_mmnt decimal(8, 4)
	, m6_mmnt_score decimal(6, 4)
	, m6_std_dev decimal(6, 4)
	, m12_mmnt_size int
	, m12_mmnt decimal(8, 4)
	, m12_mmnt_score decimal(6, 4)
	, m12_std_dev decimal(6, 4)
);
CREATE UNIQUE INDEX pk_t_ki_ki0310 ON t_ki_ki0310 (shcode, trdd DESC);

COMMENT ON TABLE t_ki_ki0310 IS 'ETF 일자별 수치';

COMMIT;
