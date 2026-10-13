-- Pega esto en Supabase > SQL Editor > Run
-- ANTES DE EJECUTAR: cambia CAMBIA-ESTE-CODIGO por el código secreto de tu familia (aparece 1 vez).

create table public.perfiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nombre text not null check (char_length(nombre) <= 80),
  rama text, trabajo text not null check (char_length(trabajo) <= 80),
  cat text, ciudad text, web text, descr text,
  ofrezco text, busco text, tel text, email text,
  updated_at timestamptz default now()
);
alter table public.perfiles enable row level security;

-- Solo cuenta como familia quien se registró con el código correcto
create function public.es_familia() returns boolean
language sql stable as $$
  select coalesce(auth.jwt() -> 'user_metadata' ->> 'codigo','') = 'CALZADO26'
$$;

-- Ver el directorio: solo familia
create policy "ver" on public.perfiles for select to authenticated
  using (public.es_familia());
-- Crear, editar y borrar: solo tu propia ficha
create policy "crear la mia" on public.perfiles for insert to authenticated
  with check (public.es_familia() and auth.uid() = id);
create policy "editar la mia" on public.perfiles for update to authenticated
  using (public.es_familia() and auth.uid() = id) with check (public.es_familia() and auth.uid() = id);
create policy "borrar la mia" on public.perfiles for delete to authenticated
  using (public.es_familia() and auth.uid() = id);
