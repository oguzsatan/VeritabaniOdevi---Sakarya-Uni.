--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8
-- Dumped by pg_dump version 12rc1

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

--
-- Name: basarili_yetenek(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.basarili_yetenek() RETURNS void
    LANGUAGE sql
    AS $$
  SELECT * FROM paketprogrambilgisi_yeteneklerim WHERE paketprogrambilgisi_yuzde > 50;
$$;


ALTER FUNCTION public.basarili_yetenek() OWNER TO postgres;

--
-- Name: beceri_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.beceri_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM "sosyalbeceri_yeteneklerim";
   RETURN total;
END;
$$;


ALTER FUNCTION public.beceri_sayisi() OWNER TO postgres;

--
-- Name: birlestir(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.birlestir() RETURNS TABLE(bolumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT * FROM "projelerim" inner join "islerim" on "projelerim"."kullanici_id" = "islerim"."kullanici_adi";
END;
$$;


ALTER FUNCTION public.birlestir() OWNER TO postgres;

--
-- Name: bosluk_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bosluk_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."is_aciklama" = LTRIM(NEW."is_aciklama");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.bosluk_sil() OWNER TO postgres;

--
-- Name: karakteri_buyult(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.karakteri_buyult() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."okul_adi" = UPPER(NEW."okul_adi"); -- büyük harfe dönüştürdükten sonra ekle
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.karakteri_buyult() OWNER TO postgres;

--
-- Name: yeni_tarih(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yeni_tarih() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE

BEGIN

    UPDATE "yabancidil_yeteneklerim" SET yetenek_tarih = CURRENT_DATE WHERE "yabancidil_id" = NEW."yabancidil_id";

    RETURN NEW;
END;

$$;


ALTER FUNCTION public.yeni_tarih() OWNER TO postgres;

--
-- Name: yetenek_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yetenek_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM "paketprogrambilgisi_yeteneklerim";
   RETURN total;
END;
$$;


ALTER FUNCTION public.yetenek_sayisi() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: bilgilerim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bilgilerim (
    bilgi_id integer NOT NULL,
    bilgi_isim character varying(2044) NOT NULL,
    "bilgi_hakkında" character varying(2044) NOT NULL,
    kullanici_id integer NOT NULL
);


ALTER TABLE public.bilgilerim OWNER TO postgres;

--
-- Name: bilgilerim_bilgi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bilgilerim_bilgi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bilgilerim_bilgi_id_seq OWNER TO postgres;

--
-- Name: bilgilerim_bilgi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bilgilerim_bilgi_id_seq OWNED BY public.bilgilerim.bilgi_id;


--
-- Name: genel_ayarlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genel_ayarlar (
    site_id integer NOT NULL,
    site_yazi character varying(2044) NOT NULL,
    site_altkisim character varying(2044) NOT NULL,
    site_adres character varying(2044) NOT NULL,
    kullanici_id integer NOT NULL
);


ALTER TABLE public.genel_ayarlar OWNER TO postgres;

--
-- Name: genel_ayarlar_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genel_ayarlar_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genel_ayarlar_site_id_seq OWNER TO postgres;

--
-- Name: genel_ayarlar_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genel_ayarlar_site_id_seq OWNED BY public.genel_ayarlar.site_id;


--
-- Name: islerim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.islerim (
    is_id integer NOT NULL,
    is_adi character varying(2044) NOT NULL,
    is_link character varying(2044) NOT NULL,
    is_aciklama character varying(2044) NOT NULL,
    is_tarih date NOT NULL,
    kullanici_id integer NOT NULL
);


ALTER TABLE public.islerim OWNER TO postgres;

--
-- Name: islerim_is_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.islerim_is_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.islerim_is_id_seq OWNER TO postgres;

--
-- Name: islerim_is_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.islerim_is_id_seq OWNED BY public.islerim.is_id;


--
-- Name: okullarim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.okullarim (
    okul_id integer NOT NULL,
    okul_adi character varying(2044) NOT NULL,
    okul_aciklama character varying(2044) NOT NULL,
    kullanici_adi integer NOT NULL
);


ALTER TABLE public.okullarim OWNER TO postgres;

--
-- Name: okullarim_okul_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.okullarim_okul_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.okullarim_okul_id_seq OWNER TO postgres;

--
-- Name: okullarim_okul_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.okullarim_okul_id_seq OWNED BY public.okullarim.okul_id;


--
-- Name: paketprogram_gecmis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paketprogram_gecmis (
    id integer NOT NULL,
    adi character varying(2044) NOT NULL,
    yuzde integer NOT NULL,
    paket_id integer NOT NULL
);


ALTER TABLE public.paketprogram_gecmis OWNER TO postgres;

--
-- Name: paketprogram_gecmis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paketprogram_gecmis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paketprogram_gecmis_id_seq OWNER TO postgres;

--
-- Name: paketprogram_gecmis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paketprogram_gecmis_id_seq OWNED BY public.paketprogram_gecmis.id;


--
-- Name: paketprogrambilgisi_yeteneklerim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paketprogrambilgisi_yeteneklerim (
    paketprobrambilgisi_id integer NOT NULL,
    paketprorambilgisi_adi character varying(2044) NOT NULL,
    paketprogrambilgisi_yuzde integer NOT NULL,
    kullanici_id integer NOT NULL,
    yetenek_tarih character varying(2044) NOT NULL
);


ALTER TABLE public.paketprogrambilgisi_yeteneklerim OWNER TO postgres;

--
-- Name: paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq OWNER TO postgres;

--
-- Name: paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq OWNED BY public.paketprogrambilgisi_yeteneklerim.paketprobrambilgisi_id;


--
-- Name: projelerim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projelerim (
    proje_id integer NOT NULL,
    proje_adi character varying(2044) NOT NULL,
    proje_link character varying(2044) NOT NULL,
    proje_aciklama character varying(2044) NOT NULL,
    proje_tarih character varying(2044) NOT NULL,
    kullanici_i integer
);


ALTER TABLE public.projelerim OWNER TO postgres;

--
-- Name: projelerim_proje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projelerim_proje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projelerim_proje_id_seq OWNER TO postgres;

--
-- Name: projelerim_proje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projelerim_proje_id_seq OWNED BY public.projelerim.proje_id;


--
-- Name: rozetler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rozetler (
    rozet_id integer NOT NULL,
    rozet_adi character varying(2044) NOT NULL,
    rozet_aciklama character varying(2044) NOT NULL,
    kullanici_id integer NOT NULL
);


ALTER TABLE public.rozetler OWNER TO postgres;

--
-- Name: rozetler_rozet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rozetler_rozet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rozetler_rozet_id_seq OWNER TO postgres;

--
-- Name: rozetler_rozet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rozetler_rozet_id_seq OWNED BY public.rozetler.rozet_id;


--
-- Name: sosyal_medya; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sosyal_medya (
    sosyal_github character varying(2044) NOT NULL,
    sosyal_linkedin character varying(2044) NOT NULL,
    sosyal_facebook character varying(2044) NOT NULL,
    sosyal_instagram character varying(2044) NOT NULL,
    sosyal_twitter character varying(2044) NOT NULL,
    kullanici_id integer NOT NULL,
    sosyal_i integer NOT NULL
);


ALTER TABLE public.sosyal_medya OWNER TO postgres;

--
-- Name: sosyal_medya_sosyal_i_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sosyal_medya_sosyal_i_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sosyal_medya_sosyal_i_seq OWNER TO postgres;

--
-- Name: sosyal_medya_sosyal_i_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sosyal_medya_sosyal_i_seq OWNED BY public.sosyal_medya.sosyal_i;


--
-- Name: sosyalbeceri_gecmis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sosyalbeceri_gecmis (
    id integer NOT NULL,
    adi character varying(2044) NOT NULL,
    yuzde integer NOT NULL,
    sosyal_id integer NOT NULL
);


ALTER TABLE public.sosyalbeceri_gecmis OWNER TO postgres;

--
-- Name: sosyalbeceri_gecmis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sosyalbeceri_gecmis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sosyalbeceri_gecmis_id_seq OWNER TO postgres;

--
-- Name: sosyalbeceri_gecmis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sosyalbeceri_gecmis_id_seq OWNED BY public.sosyalbeceri_gecmis.id;


--
-- Name: sosyalbeceri_yeteneklerim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sosyalbeceri_yeteneklerim (
    sosyalbeceri_id integer NOT NULL,
    sosyalbeceri_adi character varying(2044) NOT NULL,
    sosyalbeceri_yuzde integer NOT NULL,
    kullanici_id integer NOT NULL,
    yetenek_tarih character varying(2044) NOT NULL
);


ALTER TABLE public.sosyalbeceri_yeteneklerim OWNER TO postgres;

--
-- Name: sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq OWNER TO postgres;

--
-- Name: sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq OWNED BY public.sosyalbeceri_yeteneklerim.sosyalbeceri_id;


--
-- Name: uye_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uye_admin (
    admin_id integer NOT NULL,
    admin_adi character varying(2044) NOT NULL,
    admin_sifre character varying(2044) NOT NULL
);


ALTER TABLE public.uye_admin OWNER TO postgres;

--
-- Name: uye_admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uye_admin_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uye_admin_admin_id_seq OWNER TO postgres;

--
-- Name: uye_admin_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uye_admin_admin_id_seq OWNED BY public.uye_admin.admin_id;


--
-- Name: yabancidil_gecmis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yabancidil_gecmis (
    id integer NOT NULL,
    adi character varying(2044) NOT NULL,
    yuzde integer NOT NULL,
    yabancidil_id integer NOT NULL
);


ALTER TABLE public.yabancidil_gecmis OWNER TO postgres;

--
-- Name: yabancidil_gecmis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yabancidil_gecmis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.yabancidil_gecmis_id_seq OWNER TO postgres;

--
-- Name: yabancidil_gecmis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yabancidil_gecmis_id_seq OWNED BY public.yabancidil_gecmis.id;


--
-- Name: yabancidil_yeteneklerim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yabancidil_yeteneklerim (
    yabancidil_id integer NOT NULL,
    yabancidil_adi character varying(2044) NOT NULL,
    yabancidil_yuzde integer NOT NULL,
    kullanici_id integer NOT NULL,
    yetenek_tarih character varying(2044) NOT NULL
);


ALTER TABLE public.yabancidil_yeteneklerim OWNER TO postgres;

--
-- Name: yetenek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yetenek (
    yetenek_tarih character varying(2044) NOT NULL
);


ALTER TABLE public.yetenek OWNER TO postgres;

--
-- Name: bilgilerim bilgi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilgilerim ALTER COLUMN bilgi_id SET DEFAULT nextval('public.bilgilerim_bilgi_id_seq'::regclass);


--
-- Name: genel_ayarlar site_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genel_ayarlar ALTER COLUMN site_id SET DEFAULT nextval('public.genel_ayarlar_site_id_seq'::regclass);


--
-- Name: islerim is_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.islerim ALTER COLUMN is_id SET DEFAULT nextval('public.islerim_is_id_seq'::regclass);


--
-- Name: okullarim okul_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.okullarim ALTER COLUMN okul_id SET DEFAULT nextval('public.okullarim_okul_id_seq'::regclass);


--
-- Name: paketprogram_gecmis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogram_gecmis ALTER COLUMN id SET DEFAULT nextval('public.paketprogram_gecmis_id_seq'::regclass);


--
-- Name: paketprogrambilgisi_yeteneklerim paketprobrambilgisi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogrambilgisi_yeteneklerim ALTER COLUMN paketprobrambilgisi_id SET DEFAULT nextval('public.paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq'::regclass);


--
-- Name: projelerim proje_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projelerim ALTER COLUMN proje_id SET DEFAULT nextval('public.projelerim_proje_id_seq'::regclass);


--
-- Name: rozetler rozet_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rozetler ALTER COLUMN rozet_id SET DEFAULT nextval('public.rozetler_rozet_id_seq'::regclass);


--
-- Name: sosyal_medya sosyal_i; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyal_medya ALTER COLUMN sosyal_i SET DEFAULT nextval('public.sosyal_medya_sosyal_i_seq'::regclass);


--
-- Name: sosyalbeceri_gecmis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyalbeceri_gecmis ALTER COLUMN id SET DEFAULT nextval('public.sosyalbeceri_gecmis_id_seq'::regclass);


--
-- Name: sosyalbeceri_yeteneklerim sosyalbeceri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyalbeceri_yeteneklerim ALTER COLUMN sosyalbeceri_id SET DEFAULT nextval('public.sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq'::regclass);


--
-- Name: uye_admin admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uye_admin ALTER COLUMN admin_id SET DEFAULT nextval('public.uye_admin_admin_id_seq'::regclass);


--
-- Name: yabancidil_gecmis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yabancidil_gecmis ALTER COLUMN id SET DEFAULT nextval('public.yabancidil_gecmis_id_seq'::regclass);


--
-- Data for Name: bilgilerim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bilgilerim VALUES
	(1, 'Yetenhack Kullanıcısı', 'Hakkında bölümünü kendinizi en iyi özetleyecek şekilde doldurmanız öne çıkmanızı sağlayacaktır', 1);


--
-- Data for Name: genel_ayarlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genel_ayarlar VALUES
	(1, 'YetenHack', 'Tüm Hakları Saklıdır', 'http://localhost/yetenhack/', 1);


--
-- Data for Name: islerim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.islerim VALUES
	(1, 'Yazılım Geliştiricisi', 'twitter.com', 'Düşünce Paylaşma Platformu', '2015-05-05', 1),
	(2, 'Yazılım Geliştiricisi', 'facebook.com', 'Lise ARkadaşlarını bulma', '2016-06-06', 1),
	(3, 'Yazılım Geliştiricisi', 'youtube.com', 'Video İzleme Platformu', '2017-07-07', 1);


--
-- Data for Name: okullarim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.okullarim VALUES
	(1, 'a ilkokulu', 'En güzel okul', 1),
	(2, 'B Ortaokulu', 'EN güzel OrtaOkul', 1),
	(3, 'C Lisesi', 'En güzel  Lise', 1),
	(4, 'Sakarya Üniversitesi', 'Kelimelerle anlatılmaz..', 1);


--
-- Data for Name: paketprogram_gecmis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paketprogram_gecmis VALUES
	(1, 'Proteus', 66, 5);


--
-- Data for Name: paketprogrambilgisi_yeteneklerim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paketprogrambilgisi_yeteneklerim VALUES
	(1, 'Matlak', 50, 1, '2010-10-10'),
	(2, 'AdobeXD', 80, 1, '2010-10-10'),
	(3, '3DS Max', 40, 1, '2010-10-10'),
	(4, 'CAD', 40, 1, '2010-10-10'),
	(5, 'Proteus', 74, 1, '2010-10-10'),
	(6, 'Mer', 75, 1, '2010-10-10'),
	(7, 'deneme2', 89, 1, '2010-10-10'),
	(8, 'denem', 78, 1, '2010-10-10'),
	(11, 'Işınlanma', 61, 1, '2010-10-10'),
	(10, 'Hızlı Koşma', 61, 1, '2010-10-10');


--
-- Data for Name: projelerim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.projelerim VALUES
	(1, 'Admin Panelli Blog Sitesi', 'http://localhost/yetenhack/', 'Güzel Proje', '10.10.2010', NULL),
	(2, 'MVC Yapısında E Ticaret Sitesi', 'http://localhost/yetenhack/', 'Sağlam Proje', '10.10.2010', NULL);


--
-- Data for Name: rozetler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rozetler VALUES
	(1, 'sosyalKullanici', '5den fazla sosyal medya hesabı eklemişse bu rozet eklenir', 1),
	(2, 'merakli', '10dan fazla yabancı dil eklemişse bu rozet eklenir', 1);


--
-- Data for Name: sosyal_medya; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sosyal_medya VALUES
	('https://www.github.com/', 'https://www.linkedin.com/', 'https://www.facebook.com/', 'https://www.instagram.com/', 'https://www.twitter.com/', 1, 1);


--
-- Data for Name: sosyalbeceri_gecmis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sosyalbeceri_gecmis VALUES
	(1, 'Liderlik', 50, 3),
	(2, 'Geçlik', 100, 7);


--
-- Data for Name: sosyalbeceri_yeteneklerim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sosyalbeceri_yeteneklerim VALUES
	(1, 'Empati', 75, 1, '10.10.2010'),
	(2, 'Hitabet', 65, 1, '10.10.2010'),
	(3, 'Liderlik', 80, 1, '10.10.2010'),
	(5, 'Cesaret', 60, 1, '10.10.2010'),
	(7, 'Uyum', 75, 1, '10.10.2010');


--
-- Data for Name: uye_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uye_admin VALUES
	(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e');


--
-- Data for Name: yabancidil_gecmis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yabancidil_gecmis VALUES
	(1, 'Rusça', 100, 6);


--
-- Data for Name: yabancidil_yeteneklerim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yabancidil_yeteneklerim VALUES
	(6, 'Almanca', 75, 1, '10.10.2010'),
	(8, 'Rusça', 74, 1, '10.10.2010');


--
-- Data for Name: yetenek; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yetenek VALUES
	('10.10.2010'),
	('2010.10.10'),
	('2010-10-10');


--
-- Name: bilgilerim_bilgi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bilgilerim_bilgi_id_seq', 1, false);


--
-- Name: genel_ayarlar_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genel_ayarlar_site_id_seq', 1, false);


--
-- Name: islerim_is_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.islerim_is_id_seq', 2, true);


--
-- Name: okullarim_okul_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.okullarim_okul_id_seq', 4, true);


--
-- Name: paketprogram_gecmis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paketprogram_gecmis_id_seq', 1, true);


--
-- Name: paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paketprogrambilgisi_yeteneklerim_paketprobrambilgisi_id_seq', 12, true);


--
-- Name: projelerim_proje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projelerim_proje_id_seq', 2, true);


--
-- Name: rozetler_rozet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rozetler_rozet_id_seq', 1, false);


--
-- Name: sosyal_medya_sosyal_i_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sosyal_medya_sosyal_i_seq', 1, false);


--
-- Name: sosyalbeceri_gecmis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sosyalbeceri_gecmis_id_seq', 1, true);


--
-- Name: sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sosyalbeceri_yeteneklerim_sosyalbeceri_id_seq', 5, true);


--
-- Name: uye_admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uye_admin_admin_id_seq', 1, false);


--
-- Name: yabancidil_gecmis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yabancidil_gecmis_id_seq', 1, false);


--
-- Name: bilgilerim bilgilerim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilgilerim
    ADD CONSTRAINT bilgilerim_pkey PRIMARY KEY (bilgi_id);


--
-- Name: genel_ayarlar genel_ayarlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genel_ayarlar
    ADD CONSTRAINT genel_ayarlar_pkey PRIMARY KEY (site_id);


--
-- Name: islerim islerim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.islerim
    ADD CONSTRAINT islerim_pkey PRIMARY KEY (is_id);


--
-- Name: okullarim okullarim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.okullarim
    ADD CONSTRAINT okullarim_pkey PRIMARY KEY (okul_id);


--
-- Name: paketprogram_gecmis paketprogram_gecmis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogram_gecmis
    ADD CONSTRAINT paketprogram_gecmis_pkey PRIMARY KEY (id);


--
-- Name: paketprogrambilgisi_yeteneklerim paketprogrambilgisi_yeteneklerim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogrambilgisi_yeteneklerim
    ADD CONSTRAINT paketprogrambilgisi_yeteneklerim_pkey PRIMARY KEY (paketprobrambilgisi_id);


--
-- Name: projelerim projelerim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projelerim
    ADD CONSTRAINT projelerim_pkey PRIMARY KEY (proje_id);


--
-- Name: rozetler rozetler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rozetler
    ADD CONSTRAINT rozetler_pkey PRIMARY KEY (rozet_id);


--
-- Name: sosyal_medya sosyal_medya_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyal_medya
    ADD CONSTRAINT sosyal_medya_pkey PRIMARY KEY (sosyal_i);


--
-- Name: sosyalbeceri_gecmis sosyalbeceri_gecmis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyalbeceri_gecmis
    ADD CONSTRAINT sosyalbeceri_gecmis_pkey PRIMARY KEY (id);


--
-- Name: sosyalbeceri_yeteneklerim sosyalbeceri_yeteneklerim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyalbeceri_yeteneklerim
    ADD CONSTRAINT sosyalbeceri_yeteneklerim_pkey PRIMARY KEY (sosyalbeceri_id);


--
-- Name: uye_admin uye_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uye_admin
    ADD CONSTRAINT uye_admin_pkey PRIMARY KEY (admin_id);


--
-- Name: yabancidil_gecmis yabancidil_gecmis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yabancidil_gecmis
    ADD CONSTRAINT yabancidil_gecmis_pkey PRIMARY KEY (id);


--
-- Name: yabancidil_yeteneklerim yabancidil_yeteneklerim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yabancidil_yeteneklerim
    ADD CONSTRAINT yabancidil_yeteneklerim_pkey PRIMARY KEY (yabancidil_id);


--
-- Name: yetenek yetenek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yetenek
    ADD CONSTRAINT yetenek_pkey PRIMARY KEY (yetenek_tarih);


--
-- Name: paketprogram_gecmis lnk_paketprogrambilgisi_yeteneklerim_paketprogram_gecmis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogram_gecmis
    ADD CONSTRAINT lnk_paketprogrambilgisi_yeteneklerim_paketprogram_gecmis FOREIGN KEY (paket_id) REFERENCES public.paketprogrambilgisi_yeteneklerim(paketprobrambilgisi_id) MATCH FULL;


--
-- Name: paketprogram_gecmis lnk_sosyalbeceri_yeteneklerim_paketprogram_gecmis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogram_gecmis
    ADD CONSTRAINT lnk_sosyalbeceri_yeteneklerim_paketprogram_gecmis FOREIGN KEY (paket_id) REFERENCES public.sosyalbeceri_yeteneklerim(sosyalbeceri_id) MATCH FULL;


--
-- Name: bilgilerim lnk_uye_admin_bilgilerim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilgilerim
    ADD CONSTRAINT lnk_uye_admin_bilgilerim FOREIGN KEY (kullanici_id) REFERENCES public.uye_admin(admin_id) MATCH FULL;


--
-- Name: genel_ayarlar lnk_uye_admin_genel_ayarlar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genel_ayarlar
    ADD CONSTRAINT lnk_uye_admin_genel_ayarlar FOREIGN KEY (kullanici_id) REFERENCES public.uye_admin(admin_id) MATCH FULL;


--
-- Name: islerim lnk_uye_admin_islerim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.islerim
    ADD CONSTRAINT lnk_uye_admin_islerim FOREIGN KEY (kullanici_id) REFERENCES public.uye_admin(admin_id) MATCH FULL;


--
-- Name: okullarim lnk_uye_admin_okullarim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.okullarim
    ADD CONSTRAINT lnk_uye_admin_okullarim FOREIGN KEY (kullanici_adi) REFERENCES public.uye_admin(admin_id) MATCH FULL ON UPDATE RESTRICT;


--
-- Name: projelerim lnk_uye_admin_projelerim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projelerim
    ADD CONSTRAINT lnk_uye_admin_projelerim FOREIGN KEY (kullanici_i) REFERENCES public.uye_admin(admin_id) MATCH FULL;


--
-- Name: rozetler lnk_uye_admin_rozetler; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rozetler
    ADD CONSTRAINT lnk_uye_admin_rozetler FOREIGN KEY (kullanici_id) REFERENCES public.uye_admin(admin_id) MATCH FULL;


--
-- Name: sosyal_medya lnk_uye_admin_sosyal_medya; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyal_medya
    ADD CONSTRAINT lnk_uye_admin_sosyal_medya FOREIGN KEY (kullanici_id) REFERENCES public.uye_admin(admin_id) MATCH FULL;


--
-- Name: yabancidil_gecmis lnk_yabancidil_yeteneklerim_yabancidil_gecmis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yabancidil_gecmis
    ADD CONSTRAINT lnk_yabancidil_yeteneklerim_yabancidil_gecmis FOREIGN KEY (yabancidil_id) REFERENCES public.yabancidil_yeteneklerim(yabancidil_id) MATCH FULL;


--
-- Name: paketprogrambilgisi_yeteneklerim lnk_yetenek_paketprogrambilgisi_yeteneklerim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paketprogrambilgisi_yeteneklerim
    ADD CONSTRAINT lnk_yetenek_paketprogrambilgisi_yeteneklerim FOREIGN KEY (yetenek_tarih) REFERENCES public.yetenek(yetenek_tarih) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sosyalbeceri_yeteneklerim lnk_yetenek_sosyalbeceri_yeteneklerim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sosyalbeceri_yeteneklerim
    ADD CONSTRAINT lnk_yetenek_sosyalbeceri_yeteneklerim FOREIGN KEY (yetenek_tarih) REFERENCES public.yetenek(yetenek_tarih) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yabancidil_yeteneklerim lnk_yetenek_yabancidil_yeteneklerim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yabancidil_yeteneklerim
    ADD CONSTRAINT lnk_yetenek_yabancidil_yeteneklerim FOREIGN KEY (yetenek_tarih) REFERENCES public.yetenek(yetenek_tarih) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

