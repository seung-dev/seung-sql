-- Drop table

-- DROP TABLE public.t_ki_ki0001;

-- CREATE SEQUENCE q_ki_ki0001;

CREATE TABLE public.t_ki_ki0001 (
	request_no numeric(16, 0) NOT NULL DEFAULT NEXTVAL('q_ki_ki0001')
	, request_month numeric(2, 0) NOT NULL
	, send_date numeric(12, 0) NOT NULL
	, error_code varchar(4) DEFAULT 'R000'
	, date_updt timestamp NOT NULL DEFAULT now()
	, sender varchar(64) NOT NULL
	, sender_name varchar(64)
	, receiver varchar(128) NOT NULL
	, receiver_name varchar(64) NOT NULL
	, cc varchar(8000)
	, title varchar(256) DEFAULT ''
	, msg text
	, error_message varchar(2048) DEFAULT ''
);

CREATE UNIQUE INDEX t_ki_ki0001_pk ON public.t_ki_ki0001 USING btree (request_no DESC);

COMMENT ON TABLE public.t_ki_ki0001 IS '이메일 발송 내역';

COMMENT ON COLUMN public.t_ki_ki0001.request_no IS '요청번호';
COMMENT ON COLUMN public.t_ki_ki0001.request_month IS '요청월';
COMMENT ON COLUMN public.t_ki_ki0001.send_date IS '발송일시';
COMMENT ON COLUMN public.t_ki_ki0001.error_code IS '오류코드';
COMMENT ON COLUMN public.t_ki_ki0001.date_updt IS '수정일시';
COMMENT ON COLUMN public.t_ki_ki0001.sender IS '발송주소 - 이름 <주소>';
COMMENT ON COLUMN public.t_ki_ki0001.receiver IS '수신주소 - 이름 <주소>';
COMMENT ON COLUMN public.t_ki_ki0001.cc IS '참조목록 - 이름 <주소>, 이름 <주소>, 이름 <주소>';
COMMENT ON COLUMN public.t_ki_ki0001.title IS '제목';
COMMENT ON COLUMN public.t_ki_ki0001.msg IS '내용';
COMMENT ON COLUMN public.t_ki_ki0001.error_message IS '오류메시지';
