DROP TABLE IF EXISTS t_app_job CASCADE;
CREATE TABLE t_app_job (
	app_no int
	, job_no int
	, is_lock numeric(1, 0) DEFAULT 0
	, date_updt timestamp DEFAULT NOW()
);

CREATE UNIQUE INDEX uni_t_app_job ON t_app_job (app_no, job_no);

COMMENT ON TABLE t_app_job IS '어플리케이션별 업무 할당내역';

COMMENT ON COLUMN t_app_job.app_no IS '어플리케이션번호';
COMMENT ON COLUMN t_app_job.job_no IS '업무번호';
COMMENT ON COLUMN t_app_job.is_lock IS '사용여부 - 0: 사용, 1: 미사용';
COMMENT ON COLUMN t_app_job.date_updt IS '수정일시';

COMMIT;

INSERT INTO kinsight.public.t_app_job (
	app_no
	, job_no
	, job_state
)
SELECT
	*
FROM
	(
		SELECT
			ainfo.app_no
			, jinfo.job_no
			, 'P' AS job_state
		FROM
			kinsight.public.t_app_info ainfo
			, kinsight.public.t_job_info jinfo
	) tmp
WHERE 1 = 1
	AND NOT EXISTS (
		SELECT
			1
		FROM
			kinsight.public.t_app_job ajob
		WHERE 1 = 1
			AND ajob.job_no = tmp.job_no
			AND ajob.app_no = tmp.app_no
	)
;
