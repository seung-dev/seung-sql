DROP TABLE IF EXISTS t_job_info CASCADE;
CREATE TABLE t_job_info (
	job_no serial
	, job_set varchar(16)
	, job_name varchar(16)
	, is_lock numeric(1, 0) DEFAULT 0
	, date_updt timestamp DEFAULT NOW()
	, run_bd numeric(4, 0) DEFAULT 0
	, job_day varchar(16) DEFAULT '1,2,3,4,5,6,7'
	, time_from numeric(8, 0) DEFAULT 20
	, time_to numeric(8, 0) DEFAULT 2340
	, intv_post numeric(8, 0) DEFAULT 1000
	, limit_ip numeric(8, 0) DEFAULT 10000
	, job_type varchar(4)
	, job_desc varchar(256)
);

CREATE UNIQUE INDEX uni_t_job_info ON t_job_info (job_set, job_name);

CREATE INDEX idx_i_t_job_info ON t_job_info (job_no);

COMMENT ON TABLE t_job_info IS '업무목록';

COMMENT ON COLUMN t_job_info.job_no IS '업무번호';
COMMENT ON COLUMN t_job_info.job_set IS '업무집합';
COMMENT ON COLUMN t_job_info.job_name IS '업무명';
COMMENT ON COLUMN t_job_info.is_lock IS '사용여부 - 0: 사용, 1: 미사용';
COMMENT ON COLUMN t_job_info.date_updt IS '수정일시';
COMMENT ON COLUMN t_job_info.run_bd IS '영업일구분 - 0: job_day에 따라 동작, 1: Business Day만 동작([BTP_MNG_APP].[dbo].[t_date_info] 참조)';
COMMENT ON COLUMN t_job_info.job_day IS '동작요일 - 1: SUN, 2: MON, 3: TUE, 4: WEN, 5: THU, 6: FRI, 7: SAT';
COMMENT ON COLUMN t_job_info.time_from IS '시작시간';
COMMENT ON COLUMN t_job_info.time_to IS '종료시간';
COMMENT ON COLUMN t_job_info.intv_post IS '단위별 지연시간(milliseconds)';
COMMENT ON COLUMN t_job_info.limit_ip IS 'IP당 실행 제한수';
COMMENT ON COLUMN t_job_info.job_type IS '업무구분 - publ: 오픈(공공), fix: 고정인증(고정된 계정 사용), priv: 개인인증';
COMMENT ON COLUMN t_job_info.job_desc IS '업무상세';

COMMIT;

INSERT INTO kinsight.public.t_job_info (
	job_set
	, job_name
	, job_type
	, job_desc
)
SELECT
	*
FROM
	(
		SELECT
			'naver' AS job_set
			, 'd0100' AS job_name
			, 'publ' AS job_type
			, '네이버 종목 목록' AS job_desc
		UNION ALL
		SELECT
			'naver' AS job_set
			, 'd0110' AS job_name
			, 'publ' AS job_type
			, '네이버 종목 기본정보' AS job_desc
		UNION ALL
		SELECT
			'naver' AS job_set
			, 'd0120' AS job_name
			, 'publ' AS job_type
			, '네이버 종목 재무제표' AS job_desc
		UNION ALL
		SELECT
			'dexter' AS job_set
			, 'sr69' AS job_name
			, 'publ' AS job_type
			, '성일 서버 재시작' AS job_desc
	) tmp
WHERE 1 = 1
	AND NOT EXISTS (
		SELECT
			1
		FROM
			kinsight.public.t_job_info jinfo
		WHERE 1 = 1
			AND jinfo.job_set = tmp.job_set
			AND jinfo.job_name = tmp.job_name
	)
;

UPDATE kinsight.public.t_job_info
SET
	date_updt = NOW()
	, time_from = 730
	, time_to = 800
WHERE 1 = 1
	AND job_set = 'dexter'
	AND job_name = 'sr69'
;