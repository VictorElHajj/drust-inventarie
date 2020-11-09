

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.borrowers DISABLE TRIGGER ALL;

INSERT INTO public.borrowers (id, name, email, phone, last_active) VALUES ('48f135d4-b41b-493e-93a7-e8917d41f5c6', 'Hacke Hackspett', 'hacke@dtek.se', '123456789', '1858-11-17');
INSERT INTO public.borrowers (id, name, email, phone, last_active) VALUES ('d62ea240-6218-4b97-adab-4fed6e2e9efa', 'Kalle Anka', 'kalleutanbyxor@elektroteknolog.se', '1239019090', '2020-11-09');
INSERT INTO public.borrowers (id, name, email, phone, last_active) VALUES ('619c5cb1-3e37-4896-9c34-6ae2dcf686dc', 'Fantomen', 'fantomen@ftek.se', '123423461356', '1858-11-17');


ALTER TABLE public.borrowers ENABLE TRIGGER ALL;


ALTER TABLE public.tools DISABLE TRIGGER ALL;

INSERT INTO public.tools (id, category, name, description, status) VALUES ('d26032c5-5513-41cd-992c-e698ff773321', 'Test2', 'Test3', 'ASdasd', 'available');


ALTER TABLE public.tools ENABLE TRIGGER ALL;


ALTER TABLE public.loans DISABLE TRIGGER ALL;



ALTER TABLE public.loans ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts) VALUES ('3586538a-20ed-4e91-a2fe-7a9a285e74c4', 'drust@dtek.se', 'sha256|17|iGJ0oW3A5ughu//AIi2UaA==|ahDg1jD1AGeMybrX6/0zQokqqSBURMdsswf1IfA2mz0=', NULL, 0);


ALTER TABLE public.users ENABLE TRIGGER ALL;


