USE [master]
GO
/****** Object:  Database [BookStore]    Script Date: 8/16/2021 9:06:35 PM ******/
CREATE DATABASE [BookStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BookStore.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BookStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BookStore_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BookStore] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookStore] SET  MULTI_USER 
GO
ALTER DATABASE [BookStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BookStore] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BookStore]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[ImageLink] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[Author] [varchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[DateImport] [datetime] NOT NULL,
	[Quantity] [int] NOT NULL,
	[StatusId] [int] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[BookingDate] [datetime] NOT NULL,
	[TotalMoney] [float] NOT NULL,
	[StatusId] [int] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[DiscountId] [varchar](50) NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BookingDetail]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetail](
	[BookingDetailId] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[BookingId] [int] NOT NULL,
 CONSTRAINT [PK_BookingDetail] PRIMARY KEY CLUSTERED 
(
	[BookingDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DiscountCode]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DiscountCode](
	[DiscountId] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[PercentDiscount] [int] NOT NULL,
	[ExpiryDate] [date] NOT NULL,
 CONSTRAINT [PK_DiscountCode] PRIMARY KEY CLUSTERED 
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Status]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserHaveDiscount]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserHaveDiscount](
	[DiscountAcceptID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[DiscountId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserHaveDiscount] PRIMARY KEY CLUSTERED 
(
	[DiscountAcceptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/16/2021 9:06:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[StatusId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (5, N'book', N'images/chiecthiabienmat.jpg', N'Book Description', 2, N'LocNT', 1, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 21, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1002, N'book', N'images/chiecthiabienmat.jpg', N'Book Description', 1, N'LocNT', 1, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 20, 3)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1003, N'Book 1', N'images/chiecthiabienmat.jpg', N'Book Description', 2, N'LocNT', 1, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 20, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1004, N'Tieu Thuyet 1', N'images/chiecthiabienmat.jpg', N'Book Description', 2, N'Mr Thanh Tam A', 2, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 0, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1005, N'Tieu Thuyet 2', N'images/chiecthiabienmat.jpg', N'Book Description', 3, N'LocNT', 3, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 14, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1006, N'Tieu Thuyet 3', N'images/chiecthiabienmat.jpg', N'Book Description', 2, N'LocNT', 2, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 13, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1007, N'Tieu Thuyet 4', N'images/chiecthiabienmat.jpg', N'Book Description', 1, N'LocNT', 1, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 23, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1008, N'Tieu Thuyet 5', N'images/chiecthiabienmat.jpg', N'Book Description', 2, N'LocNT', 2, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 17, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1009, N'Tieu Thuyet 6', N'images/chiecthiabienmat.jpg', N'Book Description', 2, N'LocNT', 3, CAST(N'2021-08-12 00:00:00.000' AS DateTime), 4, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1010, N'Book 1', N'images\dacnhantam.jpg', N'Create by Mr Bean', 2, N'Mr Bean', 2, CAST(N'2021-08-13 00:00:00.000' AS DateTime), 12, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1011, N'Tieu Thuyet', N'images\toanhoc.jpg', N'Create by Mr Bean', 1, N'Mr Bean', 3, CAST(N'2021-08-13 00:00:00.000' AS DateTime), 17, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1012, N'Tieu Thuyet 8', N'images\28271160.jpg', N'Create by Mr Bean', 2, N'Mr Bean', 2, CAST(N'2021-08-14 00:00:00.000' AS DateTime), 0, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (1013, N'Tieu Thuyet 10', N'images\nhagiakim.jpg', N'Tien Luan Create', 2, N'Tien Luan', 3, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 0, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (2012, N'Thai Ha Book', N'images\chiecthiabienmat.jpg', N'Create by Thai Ha Book', 1, N'Thai Ha Book Author', 1, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 12, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (2013, N'Tieu Thuyet 11', N'images\thaihabook.jpg', N'Create by Thai Ha Book', 4, N'Thai Ha Book Author', 2, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (2014, N'Thai Ha Book 2', N'images\thaihabook.jpg', N'Create by Thai Ha Book', 2, N'Thai Ha Book Author', 2, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 12, 2)
INSERT [dbo].[Book] ([BookId], [Title], [ImageLink], [Description], [Price], [Author], [CategoryId], [DateImport], [Quantity], [StatusId]) VALUES (2015, N'Yeu Thuong Va Tu Do', N'images\yeuthuongvatudo.jpg', N'Create by Thai Ha Book', 4, N'LocNT', 1, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 19, 2)
SET IDENTITY_INSERT [dbo].[Book] OFF
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (8, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 14000, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (9, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 52000, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (10, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 50000, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (11, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 3600, 1, N'user', N'HAPPY1')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (12, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 9450, 1, N'user', N'HAPPY1')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (13, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 13050, 1, N'user', N'HAPPY1')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (14, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 2100, 1, N'user', N'HAPPY101')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (15, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1.3999999761581421, 1, N'user', N'HAPPY102')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (16, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 14, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (19, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 2, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (20, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 2, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (21, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 2, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (22, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (23, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (24, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (25, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 6, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (26, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 4.8000001907348633, 1, N'user', N'HAPPY103')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (27, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 5, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (28, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (29, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (30, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 6.4000000953674316, 1, N'user', N'HAPPY104')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (31, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (32, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (33, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 3.2000000476837158, 1, N'user', N'HAPPY103')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (34, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 1.6000000238418579, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (35, CAST(N'2021-08-15 00:00:00.000' AS DateTime), 4, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (36, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 5, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (37, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 6, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (38, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 7.1999998092651367, 1, N'user', N'HAPPY104')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (39, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 16, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (40, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 4.8000001907348633, 1, N'user', N'HAPPY104')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (41, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 3.2000000476837158, 1, N'user', N'HAPPY104')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (42, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 3.2000000476837158, 1, N'user', N'HAPPY105')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (43, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 0, 1, N'user', N'HAPPY120')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (44, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 4, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (45, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 2, 1, N'user', NULL)
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (46, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 1.7999999523162842, 1, N'user', N'HAPPY120')
INSERT [dbo].[Booking] ([BookingId], [BookingDate], [TotalMoney], [StatusId], [UserID], [DiscountId]) VALUES (47, CAST(N'2021-08-16 00:00:00.000' AS DateTime), 2.75, 1, N'user', N'HAPPY121')
SET IDENTITY_INSERT [dbo].[Booking] OFF
SET IDENTITY_INSERT [dbo].[BookingDetail] ON 

INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (1, 1013, 5, 8)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (2, 1004, 2, 8)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (3, 1013, 5, 9)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (4, 1013, 1, 11)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (5, 1004, 1, 11)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (6, 1004, 5, 12)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (7, 1013, 2, 13)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (8, 1004, 5, 13)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (9, 1004, 2, 14)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (10, 1013, 1, 15)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (11, 1013, 7, 16)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (12, 1013, 1, 19)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (13, 1013, 1, 20)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (14, 1013, 1, 21)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (15, 1007, 1, 22)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (16, 1007, 1, 23)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (17, 1007, 1, 24)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (18, 1005, 2, 25)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (19, 1011, 2, 26)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (20, 1004, 2, 26)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (21, 1005, 1, 27)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (22, 1006, 1, 27)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (23, 1007, 1, 28)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (24, 1007, 1, 29)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (25, 1008, 2, 30)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (26, 1012, 2, 30)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (27, 1007, 1, 31)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (28, 1007, 1, 32)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (29, 1009, 1, 33)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (30, 1006, 1, 33)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (31, 1008, 1, 34)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (32, 1013, 2, 35)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (33, 1005, 1, 36)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (34, 1006, 1, 36)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (35, 1009, 2, 37)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (36, 1006, 1, 37)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (37, 1004, 3, 38)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (38, 1005, 1, 38)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (39, 1009, 7, 39)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (40, 1004, 1, 39)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (41, 1009, 1, 40)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (42, 1004, 2, 40)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (43, 1009, 1, 41)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (44, 1004, 1, 41)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (45, 1009, 1, 42)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (46, 1004, 1, 42)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (47, 1009, 1, 43)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (48, 1006, 1, 43)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (49, 1009, 2, 44)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (50, 1006, 1, 45)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (51, 1005, 1, 46)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (52, 1006, 1, 46)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (53, 1011, 1, 47)
INSERT [dbo].[BookingDetail] ([BookingDetailId], [BookId], [Quantity], [BookingId]) VALUES (54, 2015, 1, 47)
SET IDENTITY_INSERT [dbo].[BookingDetail] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (1, N'cartoon')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (2, N'math')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (3, N'english')
SET IDENTITY_INSERT [dbo].[Category] OFF
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY1', N'Happy New Year 2020', 10, CAST(N'2021-08-27' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY100', N'Happy New Year 2021', 20, CAST(N'2021-08-13' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY101', N'Super sale', 50, CAST(N'2021-08-27' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY102', N'Super sale', 30, CAST(N'2021-08-27' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY103', N'Come Back', 20, CAST(N'2021-08-30' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY104', N'4', 20, CAST(N'2021-08-30' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY105', N'Super sale', 20, CAST(N'2021-08-27' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY106', N'Super sale', 30, CAST(N'2021-08-27' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY120', N'Happy', 40, CAST(N'2021-08-30' AS Date))
INSERT [dbo].[DiscountCode] ([DiscountId], [Name], [PercentDiscount], [ExpiryDate]) VALUES (N'HAPPY121', N'Test', 45, CAST(N'2021-08-30' AS Date))
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (1, N'admin     ')
INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (2, N'user      ')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (1, N'new       ')
INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (2, N'active    ')
INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (3, N'inactive  ')
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[UserHaveDiscount] ON 

INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (2, N'user', N'HAPPY1')
INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (4, N'user', N'HAPPY101')
INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (5, N'user', N'HAPPY102')
INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (11, N'user', N'HAPPY103')
INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (16, N'user', N'HAPPY104')
INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (17, N'user', N'HAPPY104')
INSERT [dbo].[UserHaveDiscount] ([DiscountAcceptID], [UserID], [DiscountId]) VALUES (18, N'user', N'HAPPY105')
SET IDENTITY_INSERT [dbo].[UserHaveDiscount] OFF
INSERT [dbo].[Users] ([UserID], [Password], [Name], [StatusId], [RoleId]) VALUES (N'admin', N'123123', N'Admin', 2, 1)
INSERT [dbo].[Users] ([UserID], [Password], [Name], [StatusId], [RoleId]) VALUES (N'user', N'123123', N'Thanh Loc', 2, 2)
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Category]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Status]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_DiscountCode] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[DiscountCode] ([DiscountId])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_DiscountCode]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Status]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Users]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([BookId])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Book]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([BookingId])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Booking]
GO
ALTER TABLE [dbo].[UserHaveDiscount]  WITH CHECK ADD  CONSTRAINT [FK_UserHaveDiscount_DiscountCode] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[DiscountCode] ([DiscountId])
GO
ALTER TABLE [dbo].[UserHaveDiscount] CHECK CONSTRAINT [FK_UserHaveDiscount_DiscountCode]
GO
ALTER TABLE [dbo].[UserHaveDiscount]  WITH CHECK ADD  CONSTRAINT [FK_UserHaveDiscount_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserHaveDiscount] CHECK CONSTRAINT [FK_UserHaveDiscount_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Role]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Status]
GO
USE [master]
GO
ALTER DATABASE [BookStore] SET  READ_WRITE 
GO
