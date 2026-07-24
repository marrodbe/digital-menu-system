SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict oKFAdubgPMUP7gcaMfqjUFk8jt3sO4Hu1LqaKHgXvzPnwSAD1wYdNT9LLTpu8TC

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."categories" ("id", "name", "code", "sort_order", "active", "created_at", "updated_at") VALUES
	('2f96d2db-5de4-4344-874b-df4acfc4e887', 'Signature-cocktails', 'signature-cocktails', 1, true, '2026-07-23 03:34:16.722855+00', '2026-07-23 03:34:16.722855+00'),
	('ecbf0cc2-83a0-4a6b-90c9-32d44516f75c', 'Cocina', 'cocina', 2, true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00');


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."venues" ("id", "name", "code", "active", "created_at", "updated_at") VALUES
	('b54d0206-81d2-4bfb-9532-b7393e1a4494', 'Pub Felix', 'pub-felix', true, '2026-07-23 03:25:39.43993+00', '2026-07-23 03:25:39.43993+00');


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."menu_items" ("id", "venue_id", "category_id", "name", "description", "price", "image_path", "video_path", "tags", "active", "created_at", "updated_at") VALUES
	('9454f8b1-fe59-48d7-9294-406194557668', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Moscow Mule', 'Vodka, Ginger Beer, Limón, Angostura', 3000.00, 'pub-felix/cocktails/moscow-mule.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('ab445439-2f44-4085-b536-cd7858362255', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Margarita Mora', 'Tequila, Mora, Limón', 3000.00, 'pub-felix/cocktails/margarita-mora.jpg', NULL, '{}', true, '2026-07-23 20:52:51.235311+00', '2026-07-23 20:52:51.235311+00'),
	('85dae2fb-6950-46f9-b112-8832c214498b', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Gin Tonic', 'Ginebra, Agua Tónica', 3000.00, 'pub-felix/cocktails/gin-tonic.jpg', NULL, '{}', true, '2026-07-23 20:52:51.235311+00', '2026-07-23 20:52:51.235311+00'),
	('86ef57e2-e0e6-4e27-83c3-ea0b1802f113', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Aperol Spritz', 'Aperol, Prosecco, Soda', 4000.00, 'pub-felix/cocktails/aperol-spritz.jpg', NULL, '{}', true, '2026-07-23 20:52:51.235311+00', '2026-07-23 20:52:51.235311+00'),
	('fd0bb17f-a82b-472b-a34b-d9717bb2a8a7', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Old Fashioned', 'Bourbon, Angostura, Azúcar', 3500.00, 'pub-felix/cocktails/old-fashioned.jpg', NULL, '{}', true, '2026-07-23 19:49:23.57561+00', '2026-07-23 19:49:23.57561+00'),
	('85094326-e07e-4dfe-93e5-56f71cc26c59', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Casgarita', 'Tequila, Cas, Limón, Agave', 4500.00, 'pub-felix/cocktails/casgarita.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('95fd264c-13a3-4efa-bf76-32ce20962ea8', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'ecbf0cc2-83a0-4a6b-90c9-32d44516f75c', 'Papas Supremas', NULL, 3000.00, NULL, NULL, '{}', true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('24ffc63e-57fb-45f8-bdce-591bb1738ddf', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'ecbf0cc2-83a0-4a6b-90c9-32d44516f75c', 'Papas fritas', NULL, 2000.00, NULL, NULL, '{}', true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('81e33ab1-654b-44d2-bd21-db01a0644ecd', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'ecbf0cc2-83a0-4a6b-90c9-32d44516f75c', 'Hamburguesa individual', NULL, 2000.00, NULL, NULL, '{}', true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('51e9f140-1c10-4064-91b1-874ab495f9f3', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'ecbf0cc2-83a0-4a6b-90c9-32d44516f75c', 'Promoción de 3 hamburguesas', NULL, 5000.00, NULL, NULL, '{}', true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('7b10bf45-51de-480c-bce1-9a605620b77a', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'ecbf0cc2-83a0-4a6b-90c9-32d44516f75c', 'Hamburguesa con papas', NULL, 3500.00, NULL, NULL, '{}', true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('1d1fba77-f960-4ad3-91b4-00d033cd1554', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Mojito', 'Ron, Limón, Hierbabuena, Azúcar, Soda', 3000.00, 'pub-felix/cocktails/mojito.jpg', NULL, '{}', true, '2026-07-23 20:52:51.235311+00', '2026-07-23 20:52:51.235311+00'),
	('11b3f65a-efc2-47be-8bce-c4232c078e66', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Sexo en el Río', 'Vodka, Licor de melocotón, Arándanos, Naranja, Limón, Almíbar', 3000.00, 'pub-felix/cocktails/sexo-en-rio.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('efac798a-ce5d-4838-8470-66382c01b8f2', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Negroni', 'Ginebra, Campari, Vermouth Rosso', 4000.00, 'pub-felix/cocktails/negroni.jpg', NULL, '{}', true, '2026-07-23 03:43:17.641891+00', '2026-07-23 03:43:17.641891+00'),
	('232fe761-7815-4459-9a9b-49302f084b21', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Deikel Teresita', 'Guaro, Licor de coco, Piña, Naranja, Limón, Sirope', 3000.00, 'pub-felix/cocktails/deikel.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('cc95d0f3-4d0d-4aa7-86ba-a21a9509975d', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Fernandito', 'Fernet, Cola', 3000.00, 'pub-felix/cocktails/fernet.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('c4022e47-a2fd-445e-b759-db1869f59476', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Sangria', 'Vino, Frutas, Cítricos', 3500.00, 'pub-felix/cocktails/sangria.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('28248ece-bf65-4d49-a455-afbe94bc1971', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Mezcalita', 'Mezcal, Cítricos, Agave', 4500.00, 'pub-felix/cocktails/mezcalita.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('313f9d93-a23a-4afd-9fad-103d9459e91a', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Inbetwin', 'Guaro, Maracuyá, Vainilla, Limón, Redbull', 5000.00, 'pub-felix/cocktails/promo-red-bull.jpg', NULL, '{}', true, '2026-07-23 21:02:58.082017+00', '2026-07-23 21:02:58.082017+00'),
	('721e1a7e-e312-4bc0-b2ca-c39af83aeec6', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Paloma de la Casa', 'Tequila, Toronja, Limón, Agave, Soda', 4000.00, 'pub-felix/cocktails/paloma.jpg', NULL, '{}', true, '2026-07-23 20:52:51.235311+00', '2026-07-23 20:52:51.235311+00'),
	('8010ab52-997f-49a7-a89f-da1418364c7a', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', '2f96d2db-5de4-4344-874b-df4acfc4e887', 'Margarita Clásica', 'Tequila, Licor de naranja, Limón', 3000.00, 'pub-felix/cocktails/margarita.jpg', NULL, '{}', true, '2026-07-23 20:52:51.235311+00', '2026-07-23 20:52:51.235311+00');


--
-- Data for Name: menu_item_media; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: screens; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."screens" ("id", "venue_id", "name", "code", "layout", "active", "created_at", "updated_at") VALUES
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'Barra Principal', 'pub-felix-main-bar', 'hero', true, '2026-07-23 03:27:55.94388+00', '2026-07-23 03:27:55.94388+00'),
	('bf1c23f3-d613-480f-bb68-6e3db6a88640', 'b54d0206-81d2-4bfb-9532-b7393e1a4494', 'Cocina', 'cocina-main', 'grid', true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00');


--
-- Data for Name: screen_menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."screen_menu_items" ("screen_id", "menu_item_id", "display_order", "visible", "created_at", "updated_at") VALUES
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', 'efac798a-ce5d-4838-8470-66382c01b8f2', 1, true, '2026-07-23 03:53:09.08373+00', '2026-07-23 03:53:09.08373+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', 'fd0bb17f-a82b-472b-a34b-d9717bb2a8a7', 2, true, '2026-07-23 19:57:39.100291+00', '2026-07-23 19:57:39.100291+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '8010ab52-997f-49a7-a89f-da1418364c7a', 7, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '85dae2fb-6950-46f9-b112-8832c214498b', 8, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '28248ece-bf65-4d49-a455-afbe94bc1971', 9, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '11b3f65a-efc2-47be-8bce-c4232c078e66', 14, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '313f9d93-a23a-4afd-9fad-103d9459e91a', 16, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '9454f8b1-fe59-48d7-9294-406194557668', 12, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '86ef57e2-e0e6-4e27-83c3-ea0b1802f113', 5, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '85094326-e07e-4dfe-93e5-56f71cc26c59', 10, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '232fe761-7815-4459-9a9b-49302f084b21', 13, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', 'c4022e47-a2fd-445e-b759-db1869f59476', 15, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', 'ab445439-2f44-4085-b536-cd7858362255', 6, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', 'cc95d0f3-4d0d-4aa7-86ba-a21a9509975d', 11, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '721e1a7e-e312-4bc0-b2ca-c39af83aeec6', 4, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('755c3b57-3da4-454f-b877-8f9d9f4e4ddb', '1d1fba77-f960-4ad3-91b4-00d033cd1554', 3, true, '2026-07-23 21:06:37.748096+00', '2026-07-23 21:06:37.748096+00'),
	('bf1c23f3-d613-480f-bb68-6e3db6a88640', '95fd264c-13a3-4efa-bf76-32ce20962ea8', 1, true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('bf1c23f3-d613-480f-bb68-6e3db6a88640', '24ffc63e-57fb-45f8-bdce-591bb1738ddf', 2, true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('bf1c23f3-d613-480f-bb68-6e3db6a88640', '81e33ab1-654b-44d2-bd21-db01a0644ecd', 3, true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('bf1c23f3-d613-480f-bb68-6e3db6a88640', '51e9f140-1c10-4064-91b1-874ab495f9f3', 4, true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00'),
	('bf1c23f3-d613-480f-bb68-6e3db6a88640', '7b10bf45-51de-480c-bce1-9a605620b77a', 5, true, '2026-07-24 00:21:18.584853+00', '2026-07-24 00:21:18.584853+00');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") VALUES
	('menu-assets', 'menu-assets', NULL, '2026-07-23 19:26:22.807704+00', '2026-07-23 19:26:22.807704+00', true, false, NULL, NULL, NULL, 'STANDARD');


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('7cd8c9a3-0af0-4972-b7e3-3ed8d32c9fdb', 'menu-assets', 'pub-felix/cocktails/negroni.jpg', NULL, '2026-07-23 19:32:21.638095+00', '2026-07-23 19:32:50.292523+00', '2026-07-23 19:32:21.638095+00', '{"eTag": "\"d5a57798302db18cb4c570f2d11e36fd\"", "size": 2795662, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T19:32:51.000Z", "contentLength": 2795662, "httpStatusCode": 200}', '0895d1a2-abc7-49fd-a9a3-5f3a1bfa7ed7', NULL, NULL),
	('b04a21cc-e792-4498-b920-d83628d9475a', 'menu-assets', 'pub-felix/cocktails/old-fashioned.jpg', NULL, '2026-07-23 19:59:55.900516+00', '2026-07-23 20:00:09.203574+00', '2026-07-23 19:59:55.900516+00', '{"eTag": "\"7bf0d7dca941720bbc73ef2851efa516\"", "size": 4024324, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T20:00:09.000Z", "contentLength": 4024324, "httpStatusCode": 200}', '5e950ff9-c85b-40b4-a142-4442fa994746', NULL, NULL),
	('e5d6f46f-857e-4430-8b0a-998502d15c00', 'menu-assets', 'pub-felix/cocktails/mojito.jpg', NULL, '2026-07-23 21:13:02.039743+00', '2026-07-23 21:13:10.605652+00', '2026-07-23 21:13:02.039743+00', '{"eTag": "\"1b1b23a0c408699a4f3ceddcba9cdac4\"", "size": 1905568, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:13:11.000Z", "contentLength": 1905568, "httpStatusCode": 200}', '23e5ece9-2f94-413c-bc60-5a7c0a4d85f1', NULL, NULL),
	('1d6bfd57-6229-4ef8-ae42-fa7c0f717956', 'menu-assets', 'pub-felix/cocktails/paloma.jpg', NULL, '2026-07-23 21:16:01.739681+00', '2026-07-23 21:16:08.857736+00', '2026-07-23 21:16:01.739681+00', '{"eTag": "\"671d41aebea08246d166cef46fdc1de7\"", "size": 1305431, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:16:09.000Z", "contentLength": 1305431, "httpStatusCode": 200}', '79dbe653-7b9e-4926-8d5d-3efbb6af421f', NULL, NULL),
	('5a9d56ac-c277-41d2-bc0c-d4d9e7997c28', 'menu-assets', 'pub-felix/cocktails/aperol-spritz.jpg', NULL, '2026-07-23 21:16:48.639686+00', '2026-07-23 21:17:01.735979+00', '2026-07-23 21:16:48.639686+00', '{"eTag": "\"ac301b45d79cba1dd82e7df48d4679de\"", "size": 4509601, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:17:02.000Z", "contentLength": 4509601, "httpStatusCode": 200}', 'b521d6c1-632c-49ff-beff-ca3c1178bf1a', NULL, NULL),
	('ac06f4ea-933d-4b36-a30c-8d33cbbb0a9a', 'menu-assets', 'pub-felix/cocktails/margarita-mora.jpg', NULL, '2026-07-23 21:17:17.775089+00', '2026-07-23 21:17:30.750274+00', '2026-07-23 21:17:17.775089+00', '{"eTag": "\"ecbaff9ef1e352c4926629ee8ec476a2\"", "size": 3312326, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:17:31.000Z", "contentLength": 3312326, "httpStatusCode": 200}', '5121fcee-6c38-4a72-a305-3a0cfa7c649f', NULL, NULL),
	('69e131cb-b542-4f6f-8612-9ecf07d97748', 'menu-assets', 'pub-felix/cocktails/margarita.jpg', NULL, '2026-07-23 21:17:46.407979+00', '2026-07-23 21:17:54.585814+00', '2026-07-23 21:17:46.407979+00', '{"eTag": "\"734c9c024e5985cbc5f4642bc4ecfad7\"", "size": 3358800, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:17:55.000Z", "contentLength": 3358800, "httpStatusCode": 200}', '76651715-ef48-47fd-a549-99bac71038ce', NULL, NULL),
	('8a4749dc-ff23-436a-8a5d-f48f88f0bf0a', 'menu-assets', 'pub-felix/cocktails/gin-tonic.jpg', NULL, '2026-07-23 21:18:09.894652+00', '2026-07-23 21:18:20.38172+00', '2026-07-23 21:18:09.894652+00', '{"eTag": "\"74a60ef8529bf676a38aa7c02f383ea2\"", "size": 2385856, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:18:21.000Z", "contentLength": 2385856, "httpStatusCode": 200}', 'addd193f-27a7-469b-b211-740d3a510ca0', NULL, NULL),
	('26ac7b31-6429-479f-a7bc-4cdf6bdc0b03', 'menu-assets', 'pub-felix/cocktails/mezcalita.jpg', NULL, '2026-07-23 21:18:38.034896+00', '2026-07-23 21:18:48.850628+00', '2026-07-23 21:18:38.034896+00', '{"eTag": "\"b03e6e569f0b2bfcdb60e0cd68e9515e\"", "size": 1424731, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:18:49.000Z", "contentLength": 1424731, "httpStatusCode": 200}', 'f38370c6-0aff-49fa-beb9-00e0f0e1865c', NULL, NULL),
	('a27206ce-3e3f-4c36-bb75-5a60d853ae6b', 'menu-assets', 'pub-felix/cocktails/casgarita.jpg', NULL, '2026-07-23 21:19:46.099599+00', '2026-07-23 21:19:56.37062+00', '2026-07-23 21:19:46.099599+00', '{"eTag": "\"268029193634cb8b1778e85c0385d0ea\"", "size": 1306733, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:19:57.000Z", "contentLength": 1306733, "httpStatusCode": 200}', '30c1a855-f17d-4cb3-8eec-5685bf03bb28', NULL, NULL),
	('b795acc6-fd27-4c60-b728-a9a8c10c0574', 'menu-assets', 'pub-felix/cocktails/fernet.jpg', NULL, '2026-07-23 21:20:04.710361+00', '2026-07-23 21:20:21.025373+00', '2026-07-23 21:20:04.710361+00', '{"eTag": "\"ab7eda82e1496d36d78eefa64289d1dc\"", "size": 4408903, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:20:21.000Z", "contentLength": 4408903, "httpStatusCode": 200}', '5499facc-e687-4d3c-970c-fdeaa0ac7189', NULL, NULL),
	('3bd90358-f695-4bc4-b88a-8e2d1b77362e', 'menu-assets', 'pub-felix/cocktails/moscow-mule.jpg', NULL, '2026-07-23 21:20:33.46274+00', '2026-07-23 21:20:48.219923+00', '2026-07-23 21:20:33.46274+00', '{"eTag": "\"40c8415aae380254e1a85212c429a69a\"", "size": 1649920, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:20:49.000Z", "contentLength": 1649920, "httpStatusCode": 200}', '8ff5bf84-6d3e-424c-ae64-3ba78322f4d6', NULL, NULL),
	('a959271f-1e47-4fcd-908f-4c1095a16853', 'menu-assets', 'pub-felix/cocktails/deikel.jpg', NULL, '2026-07-23 21:20:59.726981+00', '2026-07-23 21:21:07.149139+00', '2026-07-23 21:20:59.726981+00', '{"eTag": "\"3e02192dfb8504798ac847cc5f44c388\"", "size": 4379618, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:21:08.000Z", "contentLength": 4379618, "httpStatusCode": 200}', '4d0c49d6-aa76-4f61-afce-0b728c46f338', NULL, NULL),
	('66787c02-7ebd-4342-96b4-333014c5228c', 'menu-assets', 'pub-felix/cocktails/sexo-en-rio.jpg', NULL, '2026-07-23 21:21:22.343767+00', '2026-07-23 21:21:33.052006+00', '2026-07-23 21:21:22.343767+00', '{"eTag": "\"29dbd07fe47ddb844c29b62f402188d3\"", "size": 3700358, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:21:33.000Z", "contentLength": 3700358, "httpStatusCode": 200}', '9c0a6350-3fac-4578-9163-8949d26fbec6', NULL, NULL),
	('3a9bd582-830b-4e50-8ce0-7dcf575a6b7d', 'menu-assets', 'pub-felix/cocktails/sangria.jpg', NULL, '2026-07-23 21:21:45.930028+00', '2026-07-23 21:21:54.336477+00', '2026-07-23 21:21:45.930028+00', '{"eTag": "\"c03b87f6aa9f7e99db5b28c801e7a1f3\"", "size": 2156576, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:21:55.000Z", "contentLength": 2156576, "httpStatusCode": 200}', '61eddfdc-53ea-470f-b3f0-af0720bd858e', NULL, NULL),
	('4b07d5be-cfe1-427b-9eaf-0179df548327', 'menu-assets', 'pub-felix/cocktails/promo-red-bull.jpg', NULL, '2026-07-23 21:22:05.557338+00', '2026-07-23 21:22:17.513037+00', '2026-07-23 21:22:05.557338+00', '{"eTag": "\"61be78491fe752e450253fa18df62d19\"", "size": 3473942, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-23T21:22:18.000Z", "contentLength": 3473942, "httpStatusCode": 200}', 'e432bdc2-f0c7-4e71-b2a5-171192210135', NULL, NULL);


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict oKFAdubgPMUP7gcaMfqjUFk8jt3sO4Hu1LqaKHgXvzPnwSAD1wYdNT9LLTpu8TC

RESET ALL;
