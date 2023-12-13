create database Assesment05Db

use Assesment05Db

create schema bank

create table bank.Customer
(CId int primary key identity(1000,1),
Cname nvarchar(50) not null,
CEmail nvarchar(50) not null unique,
Contact nvarchar(50) not null unique,
CPwd as (right(Cname, 2)+ convert(nvarchar, CId) + left(Contact,2)) persisted )

create table bank.MailInfo
(MailTo nvarchar(50) not null unique,
MailDate date default GetDate(),
MailMessage nvarchar(100))

create trigger bank.trgMailToCust
on bank.Customer
after insert
as
declare @CustEmail nvarchar(50), @CustPwd nvarchar(50)
select @CustEmail = CEmail from inserted
select @CustPwd = CPwd from inserted
insert into bank.MailInfo(MailTo, MailDate, MailMessage)
values (@CustEmail, GETDATE(), 'Your netbanking password is: '+@CustPwd+'.It is valid upto 2 days only. Update it.')
print 'Record Inserted & Mail message updated with pwd.'

 
insert into bank.Customer values ('naveen','naveen@gmail.com','9876543210')
insert into bank.Customer values ('Arar','arar@gmail.com','9888888765')
insert into bank.Customer values ('Aziz','aziz@gmail.com','91234544445')
insert into bank.Customer values ('balveer','balveer@gail.com','122987654')

select * from bank.Customer
select * from bank.MailInfo






