


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


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."categories" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."menu_item_media" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "menu_item_id" "uuid" NOT NULL,
    "file_path" "text" NOT NULL,
    "media_type" "text" DEFAULT 'image'::"text" NOT NULL,
    "display_order" integer DEFAULT 0 NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "menu_item_media_media_type_check" CHECK (("media_type" = ANY (ARRAY['image'::"text", 'video'::"text"])))
);


ALTER TABLE "public"."menu_item_media" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."menu_items" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "category_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "price" numeric(10,2) NOT NULL,
    "image_path" "text",
    "video_path" "text",
    "tags" "text"[] DEFAULT '{}'::"text"[],
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."menu_items" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."screen_menu_items" (
    "screen_id" "uuid" NOT NULL,
    "menu_item_id" "uuid" NOT NULL,
    "display_order" integer DEFAULT 0 NOT NULL,
    "visible" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."screen_menu_items" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."screens" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "layout" "text" NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."screens" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venues" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."venues" OWNER TO "postgres";


ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."menu_item_media"
    ADD CONSTRAINT "menu_item_media_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."menu_items"
    ADD CONSTRAINT "menu_items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."screen_menu_items"
    ADD CONSTRAINT "screen_menu_items_pkey" PRIMARY KEY ("screen_id", "menu_item_id");



ALTER TABLE ONLY "public"."screens"
    ADD CONSTRAINT "screens_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."screens"
    ADD CONSTRAINT "screens_unique_code_per_venue" UNIQUE ("venue_id", "code");



ALTER TABLE ONLY "public"."venues"
    ADD CONSTRAINT "venues_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."venues"
    ADD CONSTRAINT "venues_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."menu_item_media"
    ADD CONSTRAINT "menu_item_media_menu_item_id_fkey" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."menu_items"
    ADD CONSTRAINT "menu_items_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."categories"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."menu_items"
    ADD CONSTRAINT "menu_items_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."screen_menu_items"
    ADD CONSTRAINT "screen_menu_items_menu_item_id_fkey" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."screen_menu_items"
    ADD CONSTRAINT "screen_menu_items_screen_id_fkey" FOREIGN KEY ("screen_id") REFERENCES "public"."screens"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."screens"
    ADD CONSTRAINT "screens_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



CREATE POLICY "Public read access" ON "public"."categories" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read access" ON "public"."menu_item_media" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read access" ON "public"."menu_items" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read access" ON "public"."screen_menu_items" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read access" ON "public"."screens" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read access" ON "public"."venues" FOR SELECT TO "authenticated", "anon" USING (true);



ALTER TABLE "public"."categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."menu_item_media" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."menu_items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."screen_menu_items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."screens" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venues" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";





































































































































































GRANT ALL ON TABLE "public"."categories" TO "anon";
GRANT ALL ON TABLE "public"."categories" TO "authenticated";
GRANT ALL ON TABLE "public"."categories" TO "service_role";



GRANT ALL ON TABLE "public"."menu_item_media" TO "anon";
GRANT ALL ON TABLE "public"."menu_item_media" TO "authenticated";
GRANT ALL ON TABLE "public"."menu_item_media" TO "service_role";



GRANT ALL ON TABLE "public"."menu_items" TO "anon";
GRANT ALL ON TABLE "public"."menu_items" TO "authenticated";
GRANT ALL ON TABLE "public"."menu_items" TO "service_role";



GRANT ALL ON TABLE "public"."screen_menu_items" TO "anon";
GRANT ALL ON TABLE "public"."screen_menu_items" TO "authenticated";
GRANT ALL ON TABLE "public"."screen_menu_items" TO "service_role";



GRANT ALL ON TABLE "public"."screens" TO "anon";
GRANT ALL ON TABLE "public"."screens" TO "authenticated";
GRANT ALL ON TABLE "public"."screens" TO "service_role";



GRANT ALL ON TABLE "public"."venues" TO "anon";
GRANT ALL ON TABLE "public"."venues" TO "authenticated";
GRANT ALL ON TABLE "public"."venues" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































