DROP TABLE IF EXISTS t_server_info CASCADE;
CREATE TABLE t_server_info (
	server_no serial
	, host_name varchar(16) NOT NULL
	, is_lock numeric(1, 0) DEFAULT 0
	, date_updt timestamp DEFAULT NOW()
	, ip4v varchar(17)
	, domain varchar(32)
	, os_name varchar(16)
	, os_ver varchar(16)
	, server_desc varchar(256)
);

CREATE UNIQUE INDEX uni_t_server_info ON t_server_info (host_name);

CREATE INDEX idx_i_t_server_info ON t_server_info (server_no);
CREATE INDEX idx_ii_t_server_info ON t_server_info (is_lock);

COMMENT ON TABLE t_server_info IS '서버정보';

COMMENT ON COLUMN t_server_info.server_no IS '서버번호';
COMMENT ON COLUMN t_server_info.host_name IS '호스트명';
COMMENT ON COLUMN t_server_info.is_lock IS '사용여부 - 0: 사용, 1: 미사용';
COMMENT ON COLUMN t_server_info.date_updt IS '수정일시';
COMMENT ON COLUMN t_server_info.ip4v IS 'IP';
COMMENT ON COLUMN t_server_info.domain IS '도메인';
COMMENT ON COLUMN t_server_info.os_name IS 'OS명';
COMMENT ON COLUMN t_server_info.os_ver IS 'OS버전';
COMMENT ON COLUMN t_server_info.server_desc IS '서버설명';

COMMIT;
