DROP TABLE IF EXISTS users CASCADE;
CREATE SEQUENCE q_users;
CREATE TABLE users (
	id numeric(20, 0) DEFAULT NEXTVAL('q_users')
	, email varchar(191)
	, created_at timestamp DEFAULT NOW()
	, updated_at timestamp DEFAULT NOW()
	, name varchar(191)
	, email_verified_at varchar(100)
	, password varchar(191)
	, remember_token varchar(100)
);

ALTER SEQUENCE q_users OWNED BY users.id;

CREATE UNIQUE INDEX uni_users ON users (email);

COMMENT ON TABLE users IS 'KINSIGHT 회원정보';

COMMENT ON COLUMN users.id IS '회원번호';
COMMENT ON COLUMN users.email IS '이메일';
COMMENT ON COLUMN users.created_at IS '등록일시';
COMMENT ON COLUMN users.updated_at IS '수정일시';
COMMENT ON COLUMN users.name IS '성명';
COMMENT ON COLUMN users.email_verified_at IS '';
COMMENT ON COLUMN users.password IS '비밀번호';
COMMENT ON COLUMN users.remember_token IS '';

COMMIT;

/*
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
*/

INSERT INTO users (
	email
	, name
	, password
	, remember_token
)
VALUES
(
	'pridecho@gmail.com'
	, 'dexter'
	, '$2y$10$9zvG8MNEqSATigJZh2tOyOFbBPJWftwbuJ9xFxS.JMM7Gvbg3I.3u'
	, 'RaGAaILw8Zpf3f8f7ffDltUoi5uxwEiw5s2EjnUDvSFOBryGPix09vIW22Y4'
)
, (
	'seung.dev@gmail.com'
	, 'seung'
	, '$2y$10$nwLYUoIfTw989XdAb/89gu.EoUAadvxtDT73025lQu0FZB5FYMzo.'
	, 'NyOCN7KY4fZKHWMSQogOlbpa3At38ciKgdWtKdJc4sbv6pJozadeHy9n5Ply'
)
, (
	'matt.cho@gmx.com'
	, 'Matt Cho'
	, '$2y$10$2aRh./P6jpSbzF9NiwL6a.kMkDBd9ZQTjHzVRS/vLF.yp8.whvyMe'
	, '1xlzyQZFLMFcjtYfQcAHCBrxcmeXDFirDRqBlwGictSE2nlKbcPoNJYhJlqx'
)
;