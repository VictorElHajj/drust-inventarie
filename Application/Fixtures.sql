

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

INSERT INTO public.tools (id, category, name, description, status) VALUES ('2115c51b-1307-48c2-9879-a378f8e60d55', 'Heligt', 'Gud', 'Behöver målas om', 'Tillgänglig');
INSERT INTO public.tools (id, category, name, description, status) VALUES ('42cc97f3-91a9-408d-955e-ba32ee83c2eb', 'Äckligt', 'Playboyfilten', 'usch', 'Tillgänglig');
INSERT INTO public.tools (id, category, name, description, status) VALUES ('9ff4738a-ffb7-4770-a23a-ddfb40646107', 'Delta', 'Sjöcrona', '', 'Tillgänglig');
INSERT INTO public.tools (id, category, name, description, status) VALUES ('a85f5bed-b5bc-406e-b1b1-fa63478342f2', 'Delta', 'Herman', '', 'Tillgänglig');


ALTER TABLE public.tools ENABLE TRIGGER ALL;


ALTER TABLE public.loans DISABLE TRIGGER ALL;

INSERT INTO public.loans (id, tool_id, borrower, date_borrowed, date_returned) VALUES ('6c817e19-e1a1-4735-b1d6-bc18bafd2439', '9ff4738a-ffb7-4770-a23a-ddfb40646107', 'Hajjen', '2020-09-04', NULL);
INSERT INTO public.loans (id, tool_id, borrower, date_borrowed, date_returned) VALUES ('85e53401-e847-4874-8104-b78c9c141e4f', 'a85f5bed-b5bc-406e-b1b1-fa63478342f2', 'Riddle', '2020-09-04', NULL);


ALTER TABLE public.loans ENABLE TRIGGER ALL;


