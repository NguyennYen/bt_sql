USE [master]
GO
/****** Object:  Database [NguyenYen]    Script Date: 19/07/2021 11:58:14 CH ******/
CREATE DATABASE [NguyenYen]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NguyenYen', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\NguyenYen.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NguyenYen_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\NguyenYen_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NguyenYen] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NguyenYen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NguyenYen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NguyenYen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NguyenYen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NguyenYen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NguyenYen] SET ARITHABORT OFF 
GO
ALTER DATABASE [NguyenYen] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NguyenYen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NguyenYen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NguyenYen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NguyenYen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NguyenYen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NguyenYen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NguyenYen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NguyenYen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NguyenYen] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NguyenYen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NguyenYen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NguyenYen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NguyenYen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NguyenYen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NguyenYen] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NguyenYen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NguyenYen] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NguyenYen] SET  MULTI_USER 
GO
ALTER DATABASE [NguyenYen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NguyenYen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NguyenYen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NguyenYen] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NguyenYen] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NguyenYen] SET QUERY_STORE = OFF
GO
USE [NguyenYen]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 19/07/2021 11:58:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] NOT NULL,
	[DepartmentName] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 19/07/2021 11:58:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpId] [nvarchar](50) NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[HIRE_DATE] [date] NULL,
	[salary] [float] NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Sex] [bit] NULL,
	[Status] [bit] NULL,
	[DepartmentId] [int] NULL,
	[EmpTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeType]    Script Date: 19/07/2021 11:58:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeType](
	[EmpTypeId] [int] NOT NULL,
	[EmpTypeName] [nvarchar](50) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([EmpTypeId])
REFERENCES [dbo].[EmployeeType] ([EmpTypeId])
GO
USE [master]
GO
ALTER DATABASE [NguyenYen] SET  READ_WRITE 
GO
select *from employee
select *from employeetype
select *from department
 
--5.
Select EmpId as MaNV, EmpName as TenNV, Sex as GioiTinh,Salary as Luong,DepartmentName as TenPhong
from department, employee where department.departmentid= employee.departmentid
----
select * from employee where EmpName like '%g'
----
select e.EmpId , e.EmpName,d.DepartmentId,d.DepartmentName
from Employee e , Department d
where e.DepartmentId=d.DepartmentId
---6.
update employee set status=null where status ='false'
select * from employee
----
delete from employee where status=null
select * from employee
---
CREATE INDEX IndexName ON employee(EmpName);
select * from employee where empId='E002'

--9
Create View vvEmployee as
select e.EmpName as TenNhanVien, d.DepartmentName as TenPhongBan,
 d.Location as NoiLamViec, et.EmpTypeName as LoaiNhanVien
from Employee e, Department d, EmployeeType et
where d.departmentId=e.Departmentid and e.EmpTypeId= et.EmpTypeId

select * from vvEmployee
--10
create proc p_TTNhanvien
@x float, @y float
as
begin
	select * from employee where Salary>@x and salary <@y
end

exec p_TTNhanvien @x=6000000, @y=9500000

------
create proc p_Update
	@EmpId nvarchar(50),
	@EmpName nvarchar(50),
	@Hiredate date,
	@salary float,
	@email nvarchar(50),
	@phone nvarchar(50),
	@sex bit,
	@Status bit,
	@departmentid int,
	@emptypeid int
as
Begin
if(@Hiredate> getdate())
	Begin
		PRINT N'HireDate lớn hơn ngày hiện tại'
		RETURN -1
	End
	else
	begin
		update employee set
		empName=@EmpName,
		hire_date=@Hiredate,
		salary=@salary,
		email=@email,
		phone=@phone,
		sex=@sex,
		status=@Status,
		departmentid=@departmentid,
		emptypeid=@emptypeid
		where @Hiredate< GETDATE() and @EmpId=Empid
		PRINT N'Cập nhật thành công'
		return 1
	end	
end
drop proc p_Update

exec p_Update @EmpId='E005', @EmpName=N'Lê Thanh Thủy',@Hiredate= '2012-02-01',@salary=7500000,@email= 'thuylt@gmail.com',@phone='0365252120',@sex='false',@Status='false',@departmentid=1,@emptypeid=3
select * from employee

----
Create proc p_Luong
as
begin
	select * from employee where salary>7000000
end
drop proc p_Luong
exec p_Luong 
--11
alter trigger t_insert
on Employee
for Insert
as 
begin
	Declare @hiredate date;
	select @hiredate=employee.hire_date from employee, inserted where inserted.hire_date= employee.Hire_date
	if(@hiredate>GETDATE())
	Begin
		Print 'Khong duoc phep them nhan vien lon hon ngay hien tai'
		RollBack Tran
	End
end

insert into employee values('E008','Yen','2021-07-07',6000000,'yennguyen@gmail.com','0365268210','true', 'false', 1,2)
------
create trigger t_update
on Department
for Update
as 
begin
	Declare @tenpb int
	Select @tenpb = Count(d.DepartmentName) From Department d, DELETED x, INSERTED i
	Where d.DepartmentId = x.DepartmentId
		  And d.DepartmentId = i.DepartmentId 
		  And d.DepartmentName = 'Phòng CMLT'
	If (@tenpb > 0 )
	Begin
	   Print N'Không cho phép cập nhật thông tin của các phòng ban CMLT'
	   RollBack Tran
	   Return
	 End
end
drop trigger t_update
update department set Location =304 where departmentName='Phòng CMLT'
select * from department
 --------
 alter trigger t_delete
 on dbo.EmployeeType 
 for delete
 as
 begin
	declare @count int=0;
	select @count= COUNT(*) from deleted 
	where status =1
	if(@count>0)
		 begin
			print N'Khong duoc xoa nguoi co trang thai = 1'
			RollBack Tran
		 end
 end
 drop trigger t_delete
delete dbo.EmployeeType  where Status=1
------12
Drop database NguyenYen

