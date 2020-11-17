DROP TABLE IF EXISTS `user_likes`;
create table user_likes(
user_id bigint unsigned not null,
from_user_id bigint unsigned not null,
status boolean comment "true - like, false - dislike",
updated_at datetime default current_timestamp ON UPDATE current_timestamp(),,
primary key(user_id,from_user_id),
foreign key (user_id) references users(id),
foreign key (from_user_id) references users(id)
);

DROP TABLE IF EXISTS `photo_likes`;
create table photo_likes(
photo_id bigint unsigned not null,
from_user_id bigint unsigned not null,
status boolean comment "true - like, false - dislike",
updated_at datetime default current_timestamp ON UPDATE current_timestamp(),,
primary key(photo_id,from_user_id),
foreign key (photo_id) references photos(id),
foreign key (from_user_id) references users(id)
);

DROP TABLE IF EXISTS `post_likes`;
create table post_likes(
post_id bigint unsigned not null,
from_user_id bigint unsigned not null,
status boolean comment "true - like, false - dislike",
updated_at datetime default current_timestamp ON UPDATE current_timestamp(),,
primary key(post_id,from_user_id),
foreign key (post_id) references posts(id),
foreign key (from_user_id) references users(id)
);
