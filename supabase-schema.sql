-- Eseguire nel SQL Editor del proprio progetto Supabase.
create table if not exists public.tracker_clients (
  id text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.tracker_clients enable row level security;
drop policy if exists "Users can read own tracker clients" on public.tracker_clients;
create policy "Users can read own tracker clients" on public.tracker_clients for select using (auth.uid() = user_id);
drop policy if exists "Users can insert own tracker clients" on public.tracker_clients;
create policy "Users can insert own tracker clients" on public.tracker_clients for insert with check (auth.uid() = user_id);
drop policy if exists "Users can update own tracker clients" on public.tracker_clients;
create policy "Users can update own tracker clients" on public.tracker_clients for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "Users can delete own tracker clients" on public.tracker_clients;
create policy "Users can delete own tracker clients" on public.tracker_clients for delete using (auth.uid() = user_id);
