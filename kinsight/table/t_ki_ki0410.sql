-- Drop table

-- DROP TABLE public.t_ki_ki0410;

DROP TABLE IF EXISTS public.t_ki_ki0410;
CREATE TABLE public.t_ki_ki0410 (
	memb_code varchar(32) NOT NULL
	, inv_sec_code varchar(8) NOT NULL
	, inv_sec_id varchar(32) NOT NULL
	, date_inst timestamp NULL DEFAULT now()
	, date_updt timestamp NULL DEFAULT now()
	, inv_sec_enc text
);

CREATE UNIQUE INDEX uni_t_ki_ki0410 ON public.t_ki_ki0410 USING btree (memb_code, inv_sec_code, inv_sec_id);

COMMENT ON TABLE public.t_ki_ki0410 IS 'Kinsight 회원 증권사 정보';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0410.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0410.inv_sec_code IS '증권사코드 - ebest: 이베스트';
COMMENT ON COLUMN public.t_ki_ki0410.inv_sec_id IS '증권사 아이디';
COMMENT ON COLUMN public.t_ki_ki0410.date_inst IS '등록일시';
COMMENT ON COLUMN public.t_ki_ki0410.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0410.inv_sec_enc IS '증권사 접속정보 암호화 텍스트';