insert into users(
  uuid,
  name,
  encrypted_password,
  permissions,
  requests_count)
values
  ('af2ba6b0-88d9-11ec-8683-d7a850d73638', 'aleksey', 'fakeuser', '{"create_requests": true, "play_requests": false}'::jsonb, 3),
  ('af2baa20-88d9-11ec-8684-275c1c46bef4', 'dima', 'fakeuser', '{"create_requests": true, "play_requests": false}'::jsonb, 2),
  ('af2baa52-88d9-11ec-8685-47c3c6d6e3a2', 'dmitriy', 'fakeuser', '{"create_requests": true, "play_requests": true}'::jsonb, 0),
  ('af2baa7a-88d9-11ec-8686-bf2f74771574', 'vadim', 'fakeuser', '{"create_requests": true, "play_requests": false}'::jsonb, 1),
  ('af2baaac-88d9-11ec-8687-e311aff7a11d', 'tolya', 'fakeuser', '{"create_requests": true, "play_requests": false}'::jsonb, 2);

update users
set          banned = true
where        uuid = 'af2baa7a-88d9-11ec-8686-bf2f74771574';

insert into requests(
  uuid,
  user_uuid,
  song_artist,
  song_name,
  created_at,
  skipped
)
values
  ('61e3a4d8-88da-11ec-8c65-f31660403032', 'af2baa7a-88d9-11ec-8686-bf2f74771574', 'bad', 'song', '2021-02-08 15:29:25-07', true),
  ('61e3a5c8-88da-11ec-8c66-3fbbd018f8b8', 'af2baaac-88d9-11ec-8687-e311aff7a11d', 'БРАВО', 'Чудесная страна', '2021-02-08 15:31:14-07', false),
  ('61e3a5f0-88da-11ec-8c67-1b52878f7f56', 'af2baaac-88d9-11ec-8687-e311aff7a11d', 'Clairo', 'Pretty Girl', '2021-02-08 15:32:15-07', false),
  ('61e3a60e-88da-11ec-8c68-7ff0042a20fd', 'af2ba6b0-88d9-11ec-8683-d7a850d73638', 'Morandi', 'Angels','2021-02-08 15:43:12-07', false),
  ('61e3a62c-88da-11ec-8c69-fb153e44133e', 'af2ba6b0-88d9-11ec-8683-d7a850d73638', 'Air', 'Playground Love','2021-02-08 15:45:31-07', false),
  ('61e3a64a-88da-11ec-8c6a-4b95919023e4', 'af2ba6b0-88d9-11ec-8683-d7a850d73638', 'Ray Charles', 'Hit the Road Jack', '2021-02-08 15:47:33-07' ,false),
  ('61e3a668-88da-11ec-8c6b-c7b8b46a3de4', 'af2baa20-88d9-11ec-8684-275c1c46bef4', 'Versake', 'Outside','2021-02-08 15:55:01-07', false),
  ('61e3a686-88da-11ec-8c6c-1f72cb0e1e64', 'af2baa20-88d9-11ec-8684-275c1c46bef4', 'Rodriguez', 'Sugar Man','2021-02-08 15:56:19-07', false);
