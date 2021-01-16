-- Drop table

-- DROP TABLE public.t_ki_ki0440;
DROP TABLE IF EXISTS public.t_ki_ki0440;
CREATE TABLE public.t_ki_ki0440 (
	memb_code varchar(32) NOT NULL
	, inv_sec_code varchar(8) NOT NULL
	, inv_sec_id varchar(32) NOT NULL
	, accno varchar(16) NOT NULL
	, date_no varchar(16) NOT NULL
	, shcode varchar(6) NOT NULL
	, date_updt timestamp NULL DEFAULT now()
	, jangb varchar(10)
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
	, hname varchar(20)
	, marketgb varchar(1)
	, jonggb varchar(1)
	, janrt numeric(10, 2)
	, price numeric(8, 0)
	, appamt numeric(18, 0)
	, dtsunik numeric(18, 0)
	, sunikrt numeric(10, 2)
	, fee numeric(10, 0)
	, tax numeric(10, 0)
	, sininter numeric(10, 0)
);

CREATE UNIQUE INDEX uni_t_ki_ki0440 ON public.t_ki_ki0440 USING btree (memb_code, inv_sec_code, inv_sec_id, accno, date_no DESC, shcode);

COMMENT ON TABLE public.t_ki_ki0440 IS '종목 보유 내역';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0440.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0440.inv_sec_code IS '증권사코드 - ebest: 이베스트';
COMMENT ON COLUMN public.t_ki_ki0440.inv_sec_id IS '증권사 아이디';
COMMENT ON COLUMN public.t_ki_ki0440.accno IS '계좌번호';
COMMENT ON COLUMN public.t_ki_ki0440.date_no IS '현황번호';
COMMENT ON COLUMN public.t_ki_ki0440.shcode IS '종목코드';
COMMENT ON COLUMN public.t_ki_ki0440.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0440.jangb IS '잔고구분';
COMMENT ON COLUMN public.t_ki_ki0440.janqty IS '잔고수량';
COMMENT ON COLUMN public.t_ki_ki0440.mdposqt IS '매도가능수량';
COMMENT ON COLUMN public.t_ki_ki0440.pamt IS '평균단가';
COMMENT ON COLUMN public.t_ki_ki0440.mamt IS '매입금액';
COMMENT ON COLUMN public.t_ki_ki0440.sinamt IS '대출금액';
COMMENT ON COLUMN public.t_ki_ki0440.lastdt IS '만기일자';
COMMENT ON COLUMN public.t_ki_ki0440.msat IS '당일매수금액';
COMMENT ON COLUMN public.t_ki_ki0440.mpms IS '당일매수단가';
COMMENT ON COLUMN public.t_ki_ki0440.mdat IS '당일매도금액';
COMMENT ON COLUMN public.t_ki_ki0440.mpmd IS '당일매도단가';
COMMENT ON COLUMN public.t_ki_ki0440.jsat IS '전일매수금액';
COMMENT ON COLUMN public.t_ki_ki0440.jpms IS '전일매수단가';
COMMENT ON COLUMN public.t_ki_ki0440.jdat IS '전일매도금액';
COMMENT ON COLUMN public.t_ki_ki0440.jpmd IS '전일매도단가';
COMMENT ON COLUMN public.t_ki_ki0440.sysprocseq IS '처리순번';
COMMENT ON COLUMN public.t_ki_ki0440.loandt IS '대출일자';
COMMENT ON COLUMN public.t_ki_ki0440.hname IS '종목명';
COMMENT ON COLUMN public.t_ki_ki0440.marketgb IS '시장구분';
COMMENT ON COLUMN public.t_ki_ki0440.jonggb IS '종목구분';
COMMENT ON COLUMN public.t_ki_ki0440.janrt IS '보유비중';
COMMENT ON COLUMN public.t_ki_ki0440.price IS '현재가';
COMMENT ON COLUMN public.t_ki_ki0440.appamt IS '평가금액';
COMMENT ON COLUMN public.t_ki_ki0440.dtsunik IS '평가손익';
COMMENT ON COLUMN public.t_ki_ki0440.sunikrt IS '수익율';
COMMENT ON COLUMN public.t_ki_ki0440.fee IS '수수료';
COMMENT ON COLUMN public.t_ki_ki0440.tax IS '제세금';
COMMENT ON COLUMN public.t_ki_ki0440.sininter IS '신용이자';
