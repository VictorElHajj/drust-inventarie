

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



ALTER TABLE public.borrowers ENABLE TRIGGER ALL;


ALTER TABLE public.tools DISABLE TRIGGER ALL;

INSERT INTO public.tools (id, category, name, description, status) VALUES ('d26032c5-5513-41cd-992c-e698ff773321', 'Test2', 'Test3', 'ASdasd', 'available');


ALTER TABLE public.tools ENABLE TRIGGER ALL;


ALTER TABLE public.loans DISABLE TRIGGER ALL;

INSERT INTO public.loans (id, tool_id, date_borrowed, date_returned, borrower_id) VALUES ('e5ef01a3-6e5a-4bd4-84a8-83e7ee9c4e80', 'd26032c5-5513-41cd-992c-e698ff773321', '2020-11-09', '2020-11-10', 'd62ea240-6218-4b97-adab-4fed6e2e9efa');
INSERT INTO public.loans (id, tool_id, date_borrowed, date_returned, borrower_id) VALUES ('cbf6a53d-981b-4006-8070-eabb49419ea2', 'd26032c5-5513-41cd-992c-e698ff773321', '2020-11-09', NULL, 'd62ea240-6218-4b97-adab-4fed6e2e9efa');
INSERT INTO public.loans (id, tool_id, date_borrowed, date_returned, borrower_id) VALUES ('69423609-e1ba-4dc3-ae43-c431d0735063', 'd26032c5-5513-41cd-992c-e698ff773321', '2020-11-09', '2020-11-10', 'd62ea240-6218-4b97-adab-4fed6e2e9efa');
INSERT INTO public.loans (id, tool_id, date_borrowed, date_returned, borrower_id) VALUES ('a3b643db-4f95-410b-8717-3fd529fd5c58', 'd26032c5-5513-41cd-992c-e698ff773321', '2020-11-10', '2020-11-10', '48f135d4-b41b-493e-93a7-e8917d41f5c6');


ALTER TABLE public.loans ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts) VALUES ('3586538a-20ed-4e91-a2fe-7a9a285e74c4', 'drust@dtek.se', 'sha256|17|iGJ0oW3A5ughu//AIi2UaA==|ahDg1jD1AGeMybrX6/0zQokqqSBURMdsswf1IfA2mz0=', NULL, 0);


ALTER TABLE public.users ENABLE TRIGGER ALL;


