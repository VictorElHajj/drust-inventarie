

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

ALTER TABLE public.tools DISABLE TRIGGER ALL;

INSERT INTO public.tools (id, category, name, description, status) VALUES ('805cb0af-5089-4b8f-9bd4-020b4bdf8310', 'Tasd', 'asdad', 'asdasd', 'available');


ALTER TABLE public.tools ENABLE TRIGGER ALL;


ALTER TABLE public.loans DISABLE TRIGGER ALL;



ALTER TABLE public.loans ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;



ALTER TABLE public.users ENABLE TRIGGER ALL;


