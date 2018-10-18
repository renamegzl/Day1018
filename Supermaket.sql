--用户登录表
--drop table sup_userLogin
--delete from sup_userLogin
create table sup_userLogin(
       userid varchar2(32) primary key,
       userpwd varchar2(20) not null
);

select * from sup_userLogin;
delete from sup_userlogin where userid='333';
delete from sup_userlogin where userid='444';
delete from sup_userlogin where userid='555';
insert into sup_userLogin values('111','111');
commit;
--这块是测试
select count(*)from sup_userLogin where userid='111' and userpwd='111';
select count(*)from sup_userlogin where userid='111';
select username from sup_userinfo where userid=(select userid from sup_userLogin where userid='111');
update  sup_userlogin set userPwd ='222' where userid='222';
select * from sup_goods;
select count(*)from sup_goods where gname='方便面';
select s.gnumber from sup_goods s where s.gname='方便面';
update sup_goods set gnumber =(100-10) where gname='方便面';
select gprice from sup_goods where gname='方便面';
select rdegree from sup_role where rid in
(select rid from userAndRole where userid='111');
insert into sup_goods values(sys_guid(),'香肠',50,5);
delete from sup_goods where gname='方便面';
select * from sup_goods where gname like '%方%';
select count(*) from sup_goods where gname='';
update sup_goods set gprice =4 where gname='方便面';
insert into sup_goods values(sys_guid(),'方便袋',100,'0.5');
insert into sup_goods values(sys_guid(),'便利贴',100,'1');

--用户信息表
--drop table sup_userInfo
--delete from sup_userInfo
create table sup_userInfo(
       userid varchar2(32) primary key,
       username varchar2(20) not null,
       usertel varchar2(11) not null
);

select * from sup_userInfo;
delete from sup_userInfo where userid='333';
delete from sup_userInfo where userid='444';
delete from sup_userInfo where userid='555';
insert into sup_userInfo values('111','张三','110');
commit;
--物品表
--drop table sup_goods
--delete from sup_goods
create table sup_goods(
       gid varchar2(32) primary key,
       gname varchar2(1000)not null,
       gnumber number(10)not null,
       gprice number(7,2)not null
);

select * from sup_goods;

delete from sup_goods where gname='方便';
insert into sup_goods values(sys_guid(),'方便面',100,5);
insert into sup_goods values(sys_guid(),'方便',100,5);
commit;

--角色表
--drop table sup_role
--delete from sup_role
create table sup_role(
       rid varchar2(32) primary key,
       rdegree int not null--0代表普通用户，1代表超市管理员
);

select * from sup_role;

insert into sup_role values ('00001',0);
insert into sup_role values ('00002',1);
commit;
--用户和角色
--drop table userAndRole
--delete from userAndRole
create table userAndRole(
       uirid varchar2(32) primary key,
       userid varchar2(32) not null,
       rid varchar2(32) not null
);

select * from userAndRole;
delete from Userandrole where userid='333';
delete from Userandrole where userid='444';
delete from Userandrole where userid='555';
insert into userAndRole values(sys_guid(),'111','00001');
insert into userAndRole values(sys_guid(),'222','00002');
commit;


--触发器
create or replace trigger addUserLogin_Trigger
after insert
on sup_userInfo
for each row
declare 
  v_uid sup_userLogin.userid%type;
begin
  v_uid:= :new.userid;

  insert into  sup_userLogin values (v_uid,'111');
  insert into userAndRole values (sys_guid,v_uid,'00001');
exception
  when others then
  DBMS_OUTPUT.PUT_LINE(SQLERRM);  
end addUserLogin_Trigger;
/

select * from user_triggers;
--存储结构

create or replace procedure LoginUser(puserid in varchar2,puserpwd in varchar2,pcount out int)
is
begin
  select count(*) into pcount from sup_userLogin where userid = puserid and userpwd = puserpwd;
end LoginUser;
/
