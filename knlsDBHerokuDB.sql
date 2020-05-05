-- 유저테이블 
create table tbl_user(
id varchar(45) primary key,
pw varchar(45) not null,
phone varchar(45) not null,
name varchar(20) not null,
address varchar(100) not null,
manager int default '1' not null);
-- 자유게시판 게시판 테이블 
create table tbl_board(
b_no int primary key auto_increment,
b_title varchar(20) not null,
b_content varchar(500) not null,
id varchar(10) not null,
b_regtime datetime default current_timestamp,
b_updatetime datetime on update current_timestamp,
replycnt int default '0' not null,
foreign key (id) references tbl_user(id) 
on delete cascade
);
-- 자유게시판 리플 테이블
create table tbl_board_reply(
br_no int primary key auto_increment,
br_content varchar(500) not null,
id varchar(10) not null,
b_no int(10),
br_regtime datetime default current_timestamp,
br_updatetime datetime on update current_timestamp,
foreign key (id) references tbl_user(id)
on delete cascade,
foreign key (b_no) references tbl_board(b_no)
on delete cascade
);
-- 견적 테이블 
create table tbl_estimate(
e_no int primary key auto_increment,
e_area varchar(20) not null,
e_address varchar(100) not null,
e_content varchar(500) not null,
id varchar(10) not null,
e_price int,
e_construction varchar(50) not null,
e_regtime datetime default current_timestamp,
e_updatetime datetime on update current_timestamp,
foreign key (id) references tbl_user(id) 
on delete cascade
);
-- 공지사항 테이블 
create table tbl_notice(
n_no int primary key auto_increment,
n_title varchar(20) not null,
n_content varchar(500) not null,
id varchar(10) not null,
n_regtime datetime default current_timestamp,
n_updatetime datetime on update current_timestamp,
foreign key (id) references tbl_user(id) 
on delete cascade
);

-- qna 게시판 
create table tbl_qna(
q_no int primary key auto_increment,
q_title varchar(20) not null,
q_content varchar(500) not null,
id varchar(10) not null,
q_regtime datetime default current_timestamp,
q_updatetime datetime on update current_timestamp,
replycnt int default '0' not null,
foreign key (id) references tbl_user(id) 
on delete cascade
);
-- qna 리플 게시판 
create table tbl_qna_reply(
qr_no int primary key auto_increment,
qr_content varchar(500) not null,
id varchar(10) not null,
q_no int(10),
qr_regtime datetime default current_timestamp,
qr_updatetime datetime on update current_timestamp,
foreign key (id) references tbl_user(id)
on delete cascade,
foreign key (q_no) references tbl_qna(q_no)
on delete cascade
);
-- review 게시판 테이블 
create table tbl_review(
r_no int primary key auto_increment,
r_title varchar(20) not null,
r_content varchar(500) not null,
id varchar(10) not null,
r_regtime datetime default current_timestamp,
r_updatetime datetime on update current_timestamp,
replycnt int default '0' not null,
foreign key (id) references tbl_user(id) 
on delete cascade
);
-- review 리플 게시판 테이블 
create table tbl_review_reply(
rr_no int primary key auto_increment,
rr_content varchar(500) not null,
id varchar(10) not null,
r_no int(10),
rr_regtime datetime default current_timestamp,
rr_updatetime datetime on update current_timestamp,
foreign key (id) references tbl_user(id)
on delete cascade,
foreign key (r_no) references tbl_review(r_no)
on delete cascade
);
-- 팁 게시판 테이블
create table tbl_tip(
t_no int primary key auto_increment,
t_title varchar(20) not null,
t_content varchar(500) not null,
id varchar(10) not null,
t_regtime datetime default current_timestamp,
t_updatetime datetime on update current_timestamp,
replycnt int default '0' not null,
foreign key (id) references tbl_user(id) 
on delete cascade
);
-- tip reply 게시판
create table tbl_tip_reply(
tr_no int primary key auto_increment,
tr_content varchar(500) not null,
id varchar(10) not null,
t_no int(10),
tr_regtime datetime default current_timestamp,
tr_updatetime datetime on update current_timestamp,
foreign key (id) references tbl_user(id)
on delete cascade,
foreign key (t_no) references tbl_tip(t_no)
on delete cascade
);

 