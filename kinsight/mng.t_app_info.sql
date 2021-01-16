DROP TABLE IF EXISTS t_app_info CASCADE;
CREATE TABLE t_app_info (
	app_no serial
	, server_no numeric(4, 0)
	, server_port numeric(8, 0)
	, is_lock numeric(1, 0) DEFAULT 0
	, date_updt timestamp DEFAULT NOW()
	, proj_name varchar(32)
	, proj_ver varchar(16)
	, proj_time varchar(16)
);

CREATE UNIQUE INDEX uni_t_app_info ON t_app_info (server_no, server_port);

CREATE INDEX idx_i_t_app_info ON t_app_info (app_no);
CREATE INDEX idx_ii_t_app_info ON t_app_info (is_lock);

COMMENT ON TABLE t_app_info IS '어플리케이션정보';

COMMENT ON COLUMN t_app_info.app_no IS '어플리케이션번호';
COMMENT ON COLUMN t_app_info.server_no IS '서버번호';
COMMENT ON COLUMN t_app_info.server_port IS '서버포트';
COMMENT ON COLUMN t_app_info.is_lock IS '사용여부 - 0: 사용, 1: 미사용';
COMMENT ON COLUMN t_app_info.date_updt IS '수정일시';
COMMENT ON COLUMN t_app_info.proj_name IS '프로젝트코드';
COMMENT ON COLUMN t_app_info.proj_ver IS '프로젝트버전';
COMMENT ON COLUMN t_app_info.proj_time IS '프로젝트시간';

COMMIT;
