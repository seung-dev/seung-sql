-- Drop table

-- DROP TABLE public.t_ki_ki0420;

CREATE TABLE public.t_ki_ki0420 (
	memb_code varchar(32) NOT NULL
	, inv_sec_code varchar(8) NOT NULL
	, inv_sec_id varchar(32) NOT NULL
	, date_inst timestamp NULL DEFAULT now()
	, date_updt timestamp NULL DEFAULT now()
	, is_rebal numeric(1, 0)
	, rebal_intv varchar(1)
);

CREATE UNIQUE INDEX uni_t_ki_ki0420 ON public.t_ki_ki0420 USING btree (memb_code, inv_sec_code, inv_sec_id);

COMMENT ON TABLE public.t_ki_ki0420 IS '증권사별 개인 설정 정보';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0420.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0420.inv_sec_code IS '증권사코드 - ebest: 이베스트';
COMMENT ON COLUMN public.t_ki_ki0420.inv_sec_id IS '증권사 아이디';
COMMENT ON COLUMN public.t_ki_ki0420.date_inst IS '등록일시';
COMMENT ON COLUMN public.t_ki_ki0420.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0420.is_rebal IS '자동거래여부 - 0: 중지, 1: 자동';
COMMENT ON COLUMN public.t_ki_ki0420.rebal_intv IS '리밸런싱 주기 - M: monthly';
