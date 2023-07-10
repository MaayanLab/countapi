-- migrate:up
create role guest nologin;
grant guest to countapi;
create schema if not exists "api";
grant all privileges on schema "api" to countapi;
grant usage on schema "api" to guest;

create table "count" (
  "key" varchar primary key,
  "value" bigint not null default 0
);

-- usage: curl -XGET http://localhost:3000/rpc/get?key=somekey => 1
create function "api"."get"("key" varchar) returns bigint as
$$
  select "value"
  from "count"
  where "count"."key" = $1;
$$
language 'sql' immutable security definer;
grant all privileges on function "api"."get"(varchar) to countapi;
grant execute on function "api"."get"(varchar) to guest;

-- usage: curl -XPOST http://localhost:3000/rpc/hit -d '{"key": "somekey"}'
create function "api"."hit"("key" varchar) returns void as
$$
#variable_conflict use_column
<<fn>>
begin
  insert into "count" ("key", "value")
  values ($1, 1)
  on conflict ("key")
  do update
  set "value" = "count"."value" + 1;
end
$$ language 'plpgsql' security definer;
grant all privileges on function "api"."hit"(varchar) to countapi;
grant execute on function "api"."hit"(varchar) to guest;

-- migrate:down
drop schema "api" cascade;
drop table "count";
drop role guest;
