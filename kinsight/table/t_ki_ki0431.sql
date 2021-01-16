-- Drop table

DROP TABLE IF EXISTS public.t_ki_ki0431;
CREATE TABLE public.t_ki_ki0431 (
	memb_code varchar(32) NOT NULL
	, inv_sec_code varchar(8) NOT NULL
	, inv_sec_id varchar(32) NOT NULL
	, accno varchar(16) NOT NULL
	, date_no varchar(16) NOT NULL
	, date_updt timestamp NULL DEFAULT NOW()
	, sunamt numeric(18, 0)
	, dtsunik numeric(18, 0)
	, mamt numeric(18, 0)
	, sunamt1 numeric(18, 0)
	, cts_expcode varchar(18)
	, tappamt numeric(18, 0)
	, tdtsunik numeric(18, 0)
);

CREATE UNIQUE INDEX uni_t_ki_ki0431 ON public.t_ki_ki0431 USING btree (memb_code, inv_sec_code, inv_sec_id, accno, date_no DESC);

COMMENT ON TABLE public.t_ki_ki0431 IS '회원 계좌 보유 내역';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0431.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0431.inv_sec_code IS '증권사코드 - ebest: 이베스트';
COMMENT ON COLUMN public.t_ki_ki0431.inv_sec_id IS '증권사 아이디';
COMMENT ON COLUMN public.t_ki_ki0431.accno IS '계좌번호';
COMMENT ON COLUMN public.t_ki_ki0431.date_no IS '수집일시';
COMMENT ON COLUMN public.t_ki_ki0431.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0431.sunamt IS '추정순자산';
COMMENT ON COLUMN public.t_ki_ki0431.dtsunik IS '실현손익';
COMMENT ON COLUMN public.t_ki_ki0431.mamt IS '매입금액';
COMMENT ON COLUMN public.t_ki_ki0431.sunamt1 IS '추정D2예수금';
COMMENT ON COLUMN public.t_ki_ki0431.cts_expcode IS 'CTS 종목번호';
COMMENT ON COLUMN public.t_ki_ki0431.tappamt IS '평가금액';
COMMENT ON COLUMN public.t_ki_ki0431.tdtsunik IS '평가손익';
