DROP TABLE IF EXISTS t_job_hist CASCADE;
CREATE TABLE t_job_hist (
	job_no int
	, job_date varchar(8)
	, date_updt timestamp DEFAULT NOW()
	, elap_ms numeric(10, 0)
	, error_code varchar(4)
	, error_message varchar(256)
);

CREATE UNIQUE INDEX uni_t_job_hist ON t_job_hist (job_no, job_date DESC);

COMMENT ON TABLE t_job_hist IS '업무처리내역';

COMMENT ON COLUMN t_job_hist.job_no IS '업무번호';
COMMENT ON COLUMN t_job_hist.job_date IS '수집일자';
COMMENT ON COLUMN t_job_hist.date_updt IS '수정일시';
COMMENT ON COLUMN t_job_hist.elap_ms IS '처리시간';
COMMENT ON COLUMN t_job_hist.error_code IS '오류코드';
COMMENT ON COLUMN t_job_hist.error_message IS '오류메시지';

COMMIT;
