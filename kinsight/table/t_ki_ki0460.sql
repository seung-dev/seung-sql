-- Drop table

-- DROP TABLE public.t_ki_ki0460;

CREATE TABLE public.t_ki_ki0460 (
	memb_code varchar(32) NOT NULL
	, inv_sec_code varchar(8) NOT NULL
	, inv_sec_id varchar(32) NOT NULL
	, shcode varchar(6)
	, data_no numeric(18, 0)
	, date_updt timestamp NULL DEFAULT now()
	, jangb varchar(12)
	, janqty numeric(18, 0)
	, mdposqt numeric(18, 0)
	, pamt numeric(18, 0)
	, mamt numeric(18, 0)
	, sinamt numeric(18, 0)
	, lastdt varchar(8)
	, msat numeric(18, 0)
	, mpms numeric(18, 0)
	, mdat numeric(18, 0)
	, mpmd numeric(18, 0)
	, jsat numeric(18, 0)
	, jpms numeric(18, 0)
	, jdat numeric(18, 0)
	, jpmd numeric(18, 0)
	, sysprocseq numeric(10, 0)
	, loandt varchar(8)
	, hname varchar(8)
	, marketgb varchar(8)
	, jonggb varchar(8)
	, janrt numeric(10, 2)
	, price numeric(8, 0)
	, appamt numeric(18, 0)
	, dtsunik numeric(18, 0)
	, sunikrt numeric(10, 2)
	, fee numeric(10, 0)
	, tax numeric(10, 0)
	, sininter numeric(10, 0)
);

CREATE UNIQUE INDEX uni_t_ki_ki0460 ON public.t_ki_ki0460 USING btree (memb_code, inv_sec_code, inv_sec_id, shcode, data_no DESC);

COMMENT ON TABLE public.t_ki_ki0460 IS '개인별 매매 내역';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0460.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0460.inv_sec_code IS '증권사코드 - ebest: 이베스트';
COMMENT ON COLUMN public.t_ki_ki0460.inv_sec_id IS '증권사 아이디';
COMMENT ON COLUMN public.t_ki_ki0460.shcode IS '종목코드';
COMMENT ON COLUMN public.t_ki_ki0460.data_no IS '현황번호';
COMMENT ON COLUMN public.t_ki_ki0460.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0460.jangb IS '잔고구분';
COMMENT ON COLUMN public.t_ki_ki0460.janqty IS '잔고수량';
COMMENT ON COLUMN public.t_ki_ki0460.mdposqt IS '매도가능수량';
COMMENT ON COLUMN public.t_ki_ki0460.pamt IS '평균단가';
COMMENT ON COLUMN public.t_ki_ki0460.mamt IS '매입금액';
COMMENT ON COLUMN public.t_ki_ki0460.sinamt IS '대출금액';
COMMENT ON COLUMN public.t_ki_ki0460.lastdt IS '만기일자';
COMMENT ON COLUMN public.t_ki_ki0460.msat IS '당일매수금액';
COMMENT ON COLUMN public.t_ki_ki0460.mpms IS '당일매수단가';
COMMENT ON COLUMN public.t_ki_ki0460.mdat IS '당일매도금액';
COMMENT ON COLUMN public.t_ki_ki0460.mpmd IS '당일매도단가';
COMMENT ON COLUMN public.t_ki_ki0460.jsat IS '전일매수금액';
COMMENT ON COLUMN public.t_ki_ki0460.jpms IS '전일매수단가';
COMMENT ON COLUMN public.t_ki_ki0460.jdat IS '전일매도금액';
COMMENT ON COLUMN public.t_ki_ki0460.jpmd IS '전일매도단가';
COMMENT ON COLUMN public.t_ki_ki0460.sysprocseq IS '처리순번';
COMMENT ON COLUMN public.t_ki_ki0460.loandt IS '대출일자';
COMMENT ON COLUMN public.t_ki_ki0460.hname IS '종목명';
COMMENT ON COLUMN public.t_ki_ki0460.marketgb IS '시장구분';
COMMENT ON COLUMN public.t_ki_ki0460.jonggb IS '종목구분';
COMMENT ON COLUMN public.t_ki_ki0460.janrt IS '보유비중';
COMMENT ON COLUMN public.t_ki_ki0460.price IS '현재가';
COMMENT ON COLUMN public.t_ki_ki0460.appamt IS '평가금액';
COMMENT ON COLUMN public.t_ki_ki0460.dtsunik IS '평가손익';
COMMENT ON COLUMN public.t_ki_ki0460.sunikrt IS '수익율';
COMMENT ON COLUMN public.t_ki_ki0460.fee IS '수수료';
COMMENT ON COLUMN public.t_ki_ki0460.tax IS '제세금';
COMMENT ON COLUMN public.t_ki_ki0460.sininter IS '신용이자';
