-- Drop table

-- DROP TABLE public.t_ki_ki0510;

CREATE TABLE public.t_ki_ki0510 (
	rebal_no numeric(18, 0) NOT NULL
	, rebal_code numeric(18, 0) NOT NULL
	, date_updt timestamp NULL DEFAULT now()
	, rebal_data text
);

CREATE UNIQUE INDEX pk_t_ki_ki0510 ON public.t_ki_ki0510 USING btree (rebal_no);
CREATE INDEX idx_i_t_ki_ki0510 ON public.t_ki_ki0510 USING btree (rebal_no DESC, rebal_code);

COMMENT ON TABLE public.t_ki_ki0510 IS 'Kinsight 리밸런싱 진행내역';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0510.rebal_no IS '진행번호';
COMMENT ON COLUMN public.t_ki_ki0510.rebal_code IS '리밸런싱 코드';
COMMENT ON COLUMN public.t_ki_ki0510.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0510.rebal_data IS '리밸런싱 내역';
