set serveroutput on;

drop table Event_Order_relation;
drop table Menu_Event_relation;
drop table Expenditure;
drop table IOrder;
drop table IUser;
drop table IEvent;
drop table IMenu;

create table IUser(
    userId int not null,
    Ipassword varchar(20) not null,
    fName varchar(20) not null,
    lName varchar(20) not null,
    Iaddress varchar(50) not null,
    dob date not null,
    city varchar(20) not null,
    Istate varchar(20) not null,
    mobile_no varchar(20) not null,
    Email_id varchar(20) not null,
    PRIMARY KEY(UserId)
);

create table IOrder(
    orderId int not null,
    orderDate date not null,
    userId int,
    primary key(orderId),
    foreign key(userId) REFERENCES IUser(userId) on delete CASCADE
);

create table IEvent(
    eventId int not null,
    eventName varchar(20) not null,
    primary key(eventId)
);


create table Event_Order_relation(
    orderId int not null,
    eventId int not null,
    primary key(orderId,eventId),
    foreign key(orderId) REFERENCES IOrder(orderId) on delete CASCADE,
    foreign key(eventId) REFERENCES IEvent(eventId) on delete CASCADE
);


create table IMenu(
    menuId int not null,
    category varchar(20) not null,
    quantity int not null,
    Idescription varchar(100),
    price int not null,
    primary key(menuId)
);

create table Menu_Event_relation(
    eventId int not null,
    menuId int not null,
    primary key(eventId,menuId),
    foreign key(eventId) REFERENCES IEvent(eventId) on delete CASCADE,
    foreign key(menuId) REFERENCES IMenu(menuId) on delete CASCADE
);

create table Expenditure(
    expenditureId int not null,
    transportationCost int not null,
    decorationCost int not null,
    vatCost int not null,
    eventId int not null,
    foreign key(eventId) REFERENCES IEvent(eventId) on delete CASCADE
);

create or replace procedure add_IUser(
    userId_ IUser.userId%type,
    Ipassword_ IUser.Ipassword%type,
    fName_ IUser.fName%type,
    lName_ IUser.lName%type,
    Iaddress_ IUser.Iaddress%type,
    dob_ IUser.dob%type,
    city_ IUser.city%type,
    Istate_ IUser.Istate%type,
    mobile_no_ IUser.mobile_no%type,
    Email_id_ IUser.Email_id%type
) is 
BEGIN
insert into Iuser(userId,Ipassword,fName,lName,Iaddress,dob,city,Istate,mobile_no,Email_id)
values(userId_,Ipassword_,fName_,lName_,Iaddress_,dob_,city_,Istate_,mobile_no_,Email_id_);
END;
/

BEGIN
add_IUser(1,'abc','Ahsan','Habib','Khulna',TO_DATE('12/10/15','DD/MM/YYYY'),'Khulna','Dhaka','01723322344','abc@gmail.com');
add_IUser(2,'abcd','Tasin','Ahmed','Kustia',TO_DATE('12/10/10','DD/MM/YYYY'),'Khulna','Jessore','01723322312','abcd@gmail.com');
add_IUser(3,'abcde','Apon','Ahmed','Dhaka',TO_DATE('11/08/10','DD/MM/YYYY'),'Khulna','Bogura','01723322300','abcde@gmail.com');
add_IUser(4,'abcdef','Nur','Mehedi','Dhaka',TO_DATE('10/09/11','DD/MM/YYYY'),'Khulna','Dhaka','01723322377','abcde@gmail.com');
add_IUser(5,'abcd','Soriful','Isalam','Bogura',TO_DATE('01/01/09','DD/MM/YYYY'),'Khulna','Bogura','01723322002','abcde@gmail.com');
END;
/
SELECT * from IUser;

create or replace procedure add_IOrder(
    orderId_ IOrder.orderId%type,
    orderDate_ Iorder.orderDate%type,
    userId_ IOrder.userId%type
) IS
BEGIN
insert into IOrder(orderId,orderDate,userId)
VALUES(orderId_,orderDate_,userId_);
END;
/

BEGIN
add_IOrder(1,TO_DATE('12/10/15','DD/MM/YYYY'),1);
add_IOrder(2,TO_DATE('01/09/14','DD/MM/YYYY'),1);
add_IOrder(3,TO_DATE('02/03/16','DD/MM/YYYY'),2);
add_IOrder(4,TO_DATE('13/10/17','DD/MM/YYYY'),2);
add_IOrder(5,TO_DATE('15/01/18','DD/MM/YYYY'),3);
END;
/

select * from IOrder;


create or replace PROCEDURE add_IEvent(
    eventId_ IEvent.eventId%type,
    eventName_ IEvent.eventName%type
) is 
BEGIN
insert into IEvent(eventId,eventName)
VALUES (eventId_,eventName_);
END;
/

BEGIN
add_IEvent(1,'Marriage');
add_IEvent(2,'BirthDay');
add_IEvent(3,'PohelaBoishak');
add_IEvent(4,'MiladMahfil');
add_IEvent(5,'Others');
END;
/
select * from IEvent;

create or replace PROCEDURE add_Event_Order_relation(
    orderId_ Event_Order_relation.orderId%type,
    eventId_ Event_Order_relation.eventId%type
) is 
BEGIN
insert into Event_Order_relation(orderId,eventId)
VALUES (orderId_,eventId_);
END;
/

BEGIN
add_Event_Order_relation(1,2);
add_Event_Order_relation(1,3);
add_Event_Order_relation(1,4);
add_Event_Order_relation(2,3);
add_Event_Order_relation(2,4);
add_Event_Order_relation(3,3);
add_Event_Order_relation(3,5);
END;
/

select * from Event_Order_relation;


create or replace procedure add_IMenu(
    menuId_ IMenu.menuId%type,
    category_ IMenu.category%type,
    quantity_ IMenu.quantity%type,
    Idescription_ IMenu.Idescription%type,
    price_ IMenu.price%type
) IS
BEGIN
insert into IMenu(menuId,category,quantity,Idescription,price)
VALUES(menuId_,category_,quantity_,Idescription_,price_);
END;
/

BEGIN
add_IMenu(1,'Bangali',10,'This is Bangali food',500);
add_IMenu(2,'Indian',8,'This is Indian food',1000);
add_IMenu(3,'French',20,'This is French food',1500);
add_IMenu(4,'appetizer',15,'This is appetizer',1000);
add_IMenu(5,'Drinks',50,'This is Drinks',2000);
END;
/

select * from IMenu;

create or replace PROCEDURE add_Menu_Event_relation(
    eventId_ Menu_Event_relation.eventId%type,
    menuId_ Menu_Event_relation.menuId%type
) is 
BEGIN
insert into Menu_Event_relation(eventId,menuId)
VALUES (eventId_,menuId_);
END;
/

BEGIN
add_Menu_Event_relation(1,1);
add_Menu_Event_relation(1,2);
add_Menu_Event_relation(1,3);
add_Menu_Event_relation(2,3);
add_Menu_Event_relation(2,4);
add_Menu_Event_relation(3,3);
add_Menu_Event_relation(4,1);
add_Menu_Event_relation(5,5);
END;
/
select * from Menu_Event_relation;


create or replace procedure add_Expenditure(
    expenditureId_ Expenditure.expenditureId%type,
    transportationCost_ Expenditure.transportationCost%type,
    decorationCost_ Expenditure.decorationCost%type,
    vatCost_ Expenditure.vatCost%type,
    eventId_ Expenditure.eventId%type
) IS
BEGIN
insert into Expenditure(expenditureId,transportationCost,decorationCost,vatCost,eventId)
VALUES(expenditureId_,transportationCost_,decorationCost_,vatCost_,eventId_);
END;
/


BEGIN
add_Expenditure(1,100,200,30,1);
add_Expenditure(2,200,300,40,2);
add_Expenditure(3,300,400,50,3);
add_Expenditure(4,400,500,60,4);
add_Expenditure(5,500,600,70,5);
END;
/
SELECT * from Expenditure;

BEGIN
dbms_output.put_line('Search a keyword inside a string using like');
end;
/
select Idescription from IMenu where Idescription like '%food%';

