#1. Брой на потребители.

select count(id)
from users;

#2. Най-стария потребител.

select username, birthdate from users
order by birthDate asc;

#3. Най-младия потребител.

select username, birthdate from users
order by birthDate desc;

#4. Колко юзъра са регистрирани с мейли от abv и колко от gmail и колко с различни от двата.

select count(email) from users
where email  like '%abv%' 
union
select count(email) from users
where email  like '%gmail%'
union 
select count(email) from users
where email not like '%abv%' or '%gmail%';

#5. Кои юзъри са banned.

select username, isbanned from users
where isBanned = 1;

#6. Изкарайте всички потребители от базата като ги наредите по име в азбучен ред и дата на раждане(от най-младия към най-възрастния).

Select username, birthdate from users
order by username asc, birthdate desc;

#7. Изкарайте всички потребители от базата, на които потребителското име започва с a.
select username from users
where username like 'a%';

#8. Изкарайте всички потребители от базата, които съдържат а username името си.
select username from users
where username like '%a%';

#9. Изкарайте всички потребители от базата, чието име се състои от 2 имена.

select username from users
where username like '% %';

#10. Регистрирайте 1 юзър през UI-а и го забранете след това от базата.

UPDATE users
SET isbanned = 1
WHERE username = 'Tatyana4';

#11. Брой на всички постове.

select count(id) from posts

#12. Брой на всички постове групирани по статуса на post-a.

select count(id) from posts
group by poststatus;

#13. Намерете поста/овете с най-къс caption.

select caption from posts
order by length(caption) asc

#14. Покажете поста с най-дълъг caption.

select caption from posts
order by length(caption) desc

#15. Кой потребител има най-много постове. Използвайте join заявка.

SELECT users.id, users.username, COUNT(*) as NumberofPosts
FROM users
LEFT JOIN posts
ON users.id = posts.userid
GROUP BY users.id, users.username
order by NumberofPosts desc

#16. Кои потребители имат най-малко постове. Използвайте join заявка.

SELECT users.id, users.username, COUNT(*) as NumberofPosts
FROM users
LEFT JOIN posts
ON users.id = posts.userid
GROUP BY users.id, users.username
order by NumberofPosts asc

#17. Колко потребителя с по 1 пост имаме. Използвайте join заявка, having clause и вложени заявки.

SELECT users.id, users.username, Count(*) as NumberofPosts
FROM users
LEFT JOIN posts
ON users.id = posts.userid
GROUP BY users.id, users.username 
having count(NumberofPosts) <2;

#18. Колко потребителя с по малко от 5 поста имаме. Използвайте join заявка, having clause и вложени заявки.

SELECT users.id, users.username, Count(*) as NumberofPosts
FROM users
LEFT JOIN posts
ON users.id = posts.userid
GROUP BY users.id, users.username 
having count(NumberofPosts) <5;

#19. Кои са постовете с най-много коментари. Използвайте вложена заявка и where clause.

SELECT posts.id, posts.caption, posts.commentscount
from posts
inner join comments
on posts.id = comments.postid
order by commentscount desc

#20. Покажете най-стария пост. Може да използвате order или с aggregate function.

SELECT * FROM posts
ORDER BY createdat ASC LIMIT 1

OR
 
select * from posts
where createdat IN (select min(createdat) from posts);

#21. Покажете най-новия пост. Може с order или с aggregate function.

SELECT * FROM posts
ORDER BY createdat desc LIMIT 1

#или

select * from posts
where createdat IN (select max(createdat) from posts);

#22. Покажете всички постове с празен caption.

select * from posts where caption like '';

#23. Създайте потребител през UI-а, добавете му public пост през базата и проверете дали се е създал през UI-а.

#Blagoi Gergiev – user registered via UI UserId – 332

INSERT INTO `iskillo`.`posts` (`id`, `caption`, `coverUrl`, `postStatus`, `createdAt`, `isDeleted`, `commentsCount`, `userId`) VALUES ('3003', 'Good', 'https://i.imgur.com/tbEvsh3.png', 'public', '2020-10-10 14:39:14.292665', '0', '0', '332');

#24. Покажете всички постове и коментарите им ако имат такива.

select posts.id, posts.commentsCount, comments.content
from posts
join comments
on posts.id = comments.postId

#25. Покажете само постове с коментари и самите коментари.

select posts.id, posts.commentsCount, comments.content
from posts
join comments
on posts.id = comments.postId
where comments.content != ""

#26. Покажете името на потребителя с най-много коментари. Използвайте join клауза.

SELECT users.username, posts.commentsCount
from users
left join posts
on users.id = posts.userId
order by posts.commentsCount desc limit 1;

#27. Покажете всички коментари, към кой пост принадлежат и кой ги е направил. Използвайте join клауза.

select users.username, posts.id, posts.caption, comments.content
from users
inner join comments on users.id = comments.userId
left join posts on posts.userId = users.id;

#28. Кои потребители са like-нали най-много постове.

select users.username, count(users_liked_posts.postsid) as PostsLiked
from users, users_liked_posts
where users.id = users_liked_posts.usersId
group by users.username
order by PostsLiked desc

#29. Кои потребители не са like-вали постове.

select users.username, users_liked_posts.postsId
from users 
left join users_liked_posts
on users.id = users_liked_posts.usersId
where postsId is null 

#30. Кои постове имат like-ове. Покажете id на поста и caption.

Select posts.id, posts.caption, users_liked_posts.usersId
from users_liked_posts, posts
where posts.id = users_liked_posts.postsId
order by posts.id asc

#31. Кои постове имат най-много like-ове. Покажете id на поста и caption

select posts.id, posts.caption, count(users_liked_posts.postsId) as Likes
from posts, users_liked_posts
where posts.id = users_liked_posts.postsId
group by posts.id
order by Likes desc

#32. Покажете всички потребители, които не follow-ват никого.

select users.username, users.id, users_followers_users.usersId_2
from users
left join users_followers_users 
on users.id = users_followers_users.usersId_2
where usersId_2 is null
order by users.username

#33. Покажете всички потребители, които не са follow-нати от никого.

select users.username, users.id, users_followers_users.usersId_1
from users
left join users_followers_users 
on users.id = users_followers_users.usersId_1
where usersId_1 is null
order by users.username

#34. Регистрирайте потребител през UI. Follow-нете някой съществуващ потребител и проверете дали записа го има в базата.

Blagoi Georgiev followed userId = 332
Quinn Guevara userId = 6

select users_followers_users.usersId_1, users_followers_users.usersId_2 
from users_followers_users
where usersId_2 = '332'