use vk;
alter table friend_requests alter status set default 'requested';
alter table users rename column create_at to created_at;