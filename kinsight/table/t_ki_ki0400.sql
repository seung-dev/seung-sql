-- Drop table

-- DROP TABLE public.t_ki_ki0400;

CREATE TABLE public.t_ki_ki0400 (
	memb_code varchar(32) NOT NULL DEFAULT UUID_GENERATE_V4()
	, is_lock numeric(1, 0) DEFAULT 0
	, memb_email varchar(128) NOT NULL
	, date_inst timestamp NULL DEFAULT NOW()
	, date_updt timestamp NULL DEFAULT NOW()
	, memb_pass varchar(64)
	, memb_auth varchar(1)
	, memb_name varchar(64)
	, memb_hp varchar(16)
);

CREATE UNIQUE INDEX pk_t_ki_ki0400 ON public.t_ki_ki0400 USING btree (memb_code);
CREATE UNIQUE INDEX uni_t_ki_ki0400 ON public.t_ki_ki0400 USING btree (memb_email);

COMMENT ON TABLE public.t_ki_ki0400 IS 'Kinsight 회원정보';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0400.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0400.is_lock IS '사용여부 - 0: 사용, 1: 중지';
COMMENT ON COLUMN public.t_ki_ki0400.memb_email IS '회원이메일';
COMMENT ON COLUMN public.t_ki_ki0400.date_inst IS '등록일시';
COMMENT ON COLUMN public.t_ki_ki0400.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0400.memb_pass IS '회원비밀번호';
COMMENT ON COLUMN public.t_ki_ki0400.memb_auth IS '회원권한 - S: sys, M: manager, U: member';
COMMENT ON COLUMN public.t_ki_ki0400.memb_name IS '회원이름';
COMMENT ON COLUMN public.t_ki_ki0400.memb_hp IS '회원연락처';
