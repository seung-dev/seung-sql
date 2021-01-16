-- Drop table

-- DROP TABLE public.t_ki_ki0450;

DROP TABLE IF EXISTS public.t_ki_ki0450;
CREATE TABLE public.t_ki_ki0450 (
	memb_code varchar(32) NOT NULL
	, inv_sec_code varchar(8) NOT NULL
	, inv_sec_id varchar(32) NOT NULL
	, accno varchar(16) NOT NULL
	, shcode varchar(6)
	, date_inst timestamp NULL DEFAULT now()
	, date_updt timestamp NULL DEFAULT now()
	, memb_rate numeric(5, 2)
	, rebal_rate numeric(5, 2)
	, lose_rate numeric(5, 2)
);

CREATE UNIQUE INDEX uni_t_ki_ki0450 ON public.t_ki_ki0450 USING btree (memb_code, inv_sec_code, inv_sec_id, shcode);

COMMENT ON TABLE public.t_ki_ki0450 IS '종목별 개인 설정 정보';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0450.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0450.inv_sec_code IS '증권사코드 - ebest: 이베스트';
COMMENT ON COLUMN public.t_ki_ki0450.inv_sec_id IS '증권사 아이디';
COMMENT ON COLUMN public.t_ki_ki0450.accno IS '계좌번호';
COMMENT ON COLUMN public.t_ki_ki0450.shcode IS '종목코드';
COMMENT ON COLUMN public.t_ki_ki0450.date_inst IS '등록일시';
COMMENT ON COLUMN public.t_ki_ki0450.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0450.memb_rate IS '목표비중';
COMMENT ON COLUMN public.t_ki_ki0450.rebal_rate IS '리밸런스 기준';
COMMENT ON COLUMN public.t_ki_ki0450.lose_rate IS '손절매 기준';
