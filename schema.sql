-- MeydanGSM Yönetim paneli — veritabanı kurulumu
-- Supabase > SQL Editor'e yapıştırıp bir kez çalıştırın.
-- ÖNCE en alttaki e-posta adresini panele girecek kişinin e-postasıyla değiştirin.

create table if not exists public.kayitlar (
  koleksiyon text not null,
  id text not null,
  veri jsonb not null,
  guncelleme timestamptz not null default now(),
  primary key (koleksiyon, id)
);

create table if not exists public.yetkili (
  email text primary key
);

alter table public.kayitlar enable row level security;
alter table public.yetkili enable row level security;

create or replace function public.yetkili_mi() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.yetkili where lower(email) = lower(auth.jwt() ->> 'email'));
$$;

drop policy if exists "yetkili okur ve yazar" on public.kayitlar;
create policy "yetkili okur ve yazar" on public.kayitlar
  for all to authenticated
  using (public.yetkili_mi()) with check (public.yetkili_mi());

drop policy if exists "kendi kaydini gorur" on public.yetkili;
create policy "kendi kaydini gorur" on public.yetkili
  for select to authenticated
  using (lower(email) = lower(auth.jwt() ->> 'email'));

-- Başka cihazdaki değişikliklerin anında görünmesi için:
alter publication supabase_realtime add table public.kayitlar;

-- Panele girebilecek e-postalar (her satıra bir kişi ekleyebilirsiniz):
insert into public.yetkili (email) values ('Rmtbttr.oo4@gmail.com')
on conflict do nothing;
