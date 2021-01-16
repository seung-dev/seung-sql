-- Drop table

-- DROP TABLE public.t_ki_ki0500;

CREATE TABLE public.t_ki_ki0500 (
	rebal_code numeric(18, 0) NOT NULL
	, rebal_type numeric(1, 0) NOT NULL
	, memb_code varchar(32) NOT NULL
	, error_code varchar(4) NOT NULL
	, date_inst timestamp NULL DEFAULT now()
	, date_updt timestamp NULL DEFAULT now()
	, item_data text
	, error_message varchar(2048)
);

CREATE UNIQUE INDEX pk_t_ki_ki0500 ON public.t_ki_ki0500 USING btree (rebal_code);
CREATE INDEX idx_i_t_ki_ki0500 ON public.t_ki_ki0500 USING btree (error_code);

COMMENT ON TABLE public.t_ki_ki0500 IS 'Kinsight 리밸런싱 요청내역';

-- Column comments

COMMENT ON COLUMN public.t_ki_ki0500.rebal_code IS '리밸런싱 코드';
COMMENT ON COLUMN public.t_ki_ki0500.rebal_type IS '리밸런싱 구분 - 1: 매도, 2: 매수';
COMMENT ON COLUMN public.t_ki_ki0500.memb_code IS '회원코드';
COMMENT ON COLUMN public.t_ki_ki0500.error_code IS '오류코드';
COMMENT ON COLUMN public.t_ki_ki0500.date_inst IS '등록일시';
COMMENT ON COLUMN public.t_ki_ki0500.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0500.item_data IS '요청정보';
COMMENT ON COLUMN public.t_ki_ki0500.error_message IS '오류메시지';
