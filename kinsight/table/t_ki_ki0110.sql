-- Drop table

-- DROP TABLE public.t_ki_ki0110;

CREATE TABLE public.t_ki_ki0110 (
	trdd varchar(8) NOT NULL, -- 주식거래일(trading day)
	trdd_no int4 NULL, -- 주식거래일 회차 - 기준일: 20021014=1
	date_inst timestamp NULL DEFAULT now() -- 등록일시
);
CREATE UNIQUE INDEX pk_t_ki_ki0110 ON public.t_ki_ki0110 USING btree (trdd DESC, trdd_no DESC);
COMMENT ON TABLE public.t_ki_ki0110 IS '주식거래일 회차';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0110.trdd IS '주식거래일(trading day)';
COMMENT ON COLUMN public.t_ki_ki0110.trdd_no IS '주식거래일 회차 - 기준일: 20021014=1';
COMMENT ON COLUMN public.t_ki_ki0110.date_inst IS '등록일시';
