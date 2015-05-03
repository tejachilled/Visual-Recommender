create table questions(
codeData varchar(5),
questionid int,
month varchar(15),
activeflag varchar(50) default 'No',
votes int,
views int,
title VARCHAR(200),
link varchar(200),
content text
);

create table answers(
month varchar(15),
questionid int,
answerid int,
votes int,
acceptedanswer varchar(15),
reputation int,
content text
);