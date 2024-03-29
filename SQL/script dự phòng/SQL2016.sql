CREATE DATABASE [BOOKSTORE]
GO
USE [BOOKSTORE]
GO
/****** Object:  UserDefinedFunction [dbo].[fChuyenCoDauThanhKhongDau]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fChuyenCoDauThanhKhongDau](@inputVar NVARCHAR(MAX) )
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CustomerID] [bigint] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartDetail]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartDetail](
	[ProductID] [bigint] NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](100) NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SirName] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Status] [bit] NULL,
	[GroupID] [bigint] NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerGroup]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerGroup](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_ManagerGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MappingRole]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MappingRole](
	[ManagerGroupID] [bigint] NOT NULL,
	[RoleID] [bigint] NOT NULL,
	[Note] [ntext] NULL,
 CONSTRAINT [PK_MappingRole] PRIMARY KEY CLUSTERED 
(
	[ManagerGroupID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Description] [ntext] NULL,
	[Image] [nvarchar](250) NULL,
	[MoreImages] [xml] NULL,
	[Authors] [nvarchar](250) NULL,
	[Price] [decimal](18, 0) NULL,
	[PromotionPrice] [decimal](18, 0) NULL,
	[Quantity] [int] NOT NULL,
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
	[TopHot] [datetime] NULL,
	[ViewCout] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Image] [nvarchar](500) NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slide]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[Link] [nvarchar](250) NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Slide] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/15/2022 8:29:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (17, CAST(N'2022-01-03T08:55:03.320' AS DateTime), 12, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (19, CAST(N'2022-01-03T17:45:58.923' AS DateTime), 2, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10021, CAST(N'2022-01-04T17:48:22.073' AS DateTime), 12, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10022, CAST(N'2022-01-06T18:31:07.370' AS DateTime), 12, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10024, CAST(N'2022-01-06T13:37:30.493' AS DateTime), 17, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10032, CAST(N'2022-01-07T23:50:29.233' AS DateTime), 17, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10035, CAST(N'2022-01-13T20:42:19.637' AS DateTime), 12, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10036, CAST(N'2022-01-14T00:45:46.957' AS DateTime), 1, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10037, CAST(N'2022-01-14T23:53:17.977' AS DateTime), 39, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10040, CAST(N'2022-01-14T05:33:39.367' AS DateTime), 16, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10042, CAST(N'2022-01-13T05:34:27.557' AS DateTime), 16, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10043, CAST(N'2022-01-13T05:34:49.897' AS DateTime), 16, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10044, CAST(N'2022-01-12T05:35:49.087' AS DateTime), 18, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10045, CAST(N'2022-01-12T05:36:43.683' AS DateTime), 19, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10046, CAST(N'2022-01-12T05:37:03.767' AS DateTime), 19, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10047, CAST(N'2022-01-11T05:37:21.183' AS DateTime), 19, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10048, CAST(N'2022-01-10T05:38:26.943' AS DateTime), 20, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10049, CAST(N'2022-01-10T05:41:31.253' AS DateTime), 20, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10050, CAST(N'2022-01-10T05:42:20.857' AS DateTime), 20, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10051, CAST(N'2022-01-10T05:48:17.347' AS DateTime), 20, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10052, CAST(N'2022-01-09T05:50:45.807' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10053, CAST(N'2022-01-09T05:51:19.187' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10054, CAST(N'2022-01-08T05:51:37.587' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10055, CAST(N'2022-01-08T05:52:02.810' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10056, CAST(N'2022-01-08T05:52:13.753' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10057, CAST(N'2022-01-15T05:52:48.490' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10058, CAST(N'2022-01-15T05:53:06.603' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10059, CAST(N'2022-01-15T05:53:18.790' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10060, CAST(N'2022-01-15T05:53:29.263' AS DateTime), 21, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10061, CAST(N'2022-01-15T05:54:24.787' AS DateTime), 23, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10062, CAST(N'2022-01-15T05:55:57.743' AS DateTime), 2, 0)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10064, CAST(N'2022-01-15T06:01:55.237' AS DateTime), 12, 1)
INSERT [dbo].[Cart] ([ID], [CreatedDate], [CustomerID], [Status]) VALUES (10065, CAST(N'2022-01-15T06:13:10.357' AS DateTime), 17, 0)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 19, 13)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 10021, 17)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 10022, 10)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 10040, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 10044, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 10045, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (9, 10065, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 19, 17)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10021, 12)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10032, 9)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10035, 10)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10037, 8)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10044, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10052, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10, 10062, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 19, 7)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10022, 9)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10043, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10044, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10049, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10052, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10062, 4)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 10064, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (12, 19, 8)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (12, 10024, 7)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (12, 10044, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (12, 10059, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (12, 10062, 3)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (14, 10037, 12)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (15, 10042, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (15, 10060, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (16, 17, 15)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (18, 10024, 14)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (18, 10057, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (19, 19, 15)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (19, 10035, 12)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (20, 10054, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10025, 10058, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10026, 10048, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10026, 10061, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10028, 10047, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10028, 10056, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10030, 10055, 2)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10031, 10036, 15)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10031, 10046, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10031, 10053, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10032, 10036, 10)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10033, 10036, 12)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10034, 10050, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10035, 10051, 1)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10036, 10036, 14)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10037, 10036, 8)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10040, 10036, 17)
INSERT [dbo].[CartDetail] ([ProductID], [OrderID], [Quantity]) VALUES (10043, 10065, 5)
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([ID], [Name], [Address], [Email], [Phone]) VALUES (1, N'Nhà sách Phương Nam', N'17 Thái Nguyên, Phước Tân, Thành phố Nha Trang, Khánh Hòa 650000', N'pnbooknt@gmail.com', N'091 742 90 71')
SET IDENTITY_INSERT [dbo].[Contact] OFF
GO
SET IDENTITY_INSERT [dbo].[Manager] ON 

INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10004, N'Cao Minh', N'Tiến', N'cmtien', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10005, N'Đặng Nhật', N'Việt', N'dnviet', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10006, N'Nguyễn', N'Văn An', N'nvan', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10007, N'Lương Kiều', N'Trinh', N'lktrinh', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10008, N'Đặng Nguyễn Nhật', N'Hùng', N'dnnhung', N'1234567', 0, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10009, N'Lại Quốc', N'Đạt', N'lqdat', N'1234567', 1, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10010, N'Trần Đặng Sơn', N'Dương', N'tdsduong', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10011, N'Nguyễn Mai Thu', N'Thúy', N'nmtthuy', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10012, N'Nguyễn Đức Vĩnh', N'Thụy', N'ndvthuy', N'1234567', 0, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10013, N'Đặng Thi Mỹ', N'Thoại', N'dtmthoai', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10014, N'Ngo Hán', N'Lương', N'nhluong', N'1234567', 1, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10015, N'Trần Quốc', N'Toàn', N'tqtoan', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10016, N'Lương Thế', N'Vĩnh', N'ltvinh', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10017, N'Cao Mã', N'Ý', N'cmy', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10018, N'Lương Đình', N'Mộng', N'ldmong', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10019, N'Trịnh Ngọc Bảo', N'Hân', N'tnbhan', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10020, N'Tô Hồ Tố', N'Trinh', N'thttrinh', N'1234567', 0, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10021, N'Nguyễn Thị Thu', N'Thảo', N'nttthao', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10022, N'Mai Xuân', N'Huy', N'mxhuy', N'1234567', 0, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10023, N'Võ Văn', N'Hiếu', N'vvhieu', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10024, N'Lương Như', N'Huỳnh', N'lnhuynh', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10025, N'Võ Nguyễn Hoàng', N'Trâm', N'vnhtram', N'1234567', 0, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10026, N'Harry', N'Felton', N'harryfelton', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10027, N'Nguyễn Ngọc', N'Hội', N'nnhoi', N'1234567', 0, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10028, N'Lương Triều', N'Quang', N'ltquang', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10029, N'Nguyễn Hoàng Đăng', N'Quang', N'lhdquang', N'1234567', 1, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10030, N'Nguyễn Nhật', N'Quỳnh', N'nnquynh', N'1234567', 0, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10031, N'Nguyễn Thị Thanh', N'Tâm', N'ntttam', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10032, N'Nguyễn Bảo', N'Trân', N'nbtran', N'1234567', 1, 6)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10033, N'Đinh Mạnh', N'Quân', N'dmquan', N'1234567', 1, 7)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10034, N'Lý Liên', N'Hoàn', N'llhoan', N'1234567', 0, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10035, N'Nguyễn Thị Thanh', N'Hân', N'ntthan', N'1234567', 1, 5)
INSERT [dbo].[Manager] ([ID], [SirName], [FirstName], [UserName], [Password], [Status], [GroupID]) VALUES (10036, N'Lương Thế', N'Huy', N'lthuy', N'1234567', 1, 6)
SET IDENTITY_INSERT [dbo].[Manager] OFF
GO
SET IDENTITY_INSERT [dbo].[ManagerGroup] ON 

INSERT [dbo].[ManagerGroup] ([ID], [Name], [Note], [CreatedDate], [Status]) VALUES (5, N'ADMIN', N'Group dành cho quản trị viên, có toàn quyền đối với hệ thống', CAST(N'2021-12-27T15:28:10.000' AS DateTime), 1)
INSERT [dbo].[ManagerGroup] ([ID], [Name], [Note], [CreatedDate], [Status]) VALUES (6, N'MEMBER', N'Group này cho các nhân viên nội bộ, chỉ được xem', CAST(N'2021-12-27T15:28:38.193' AS DateTime), 1)
INSERT [dbo].[ManagerGroup] ([ID], [Name], [Note], [CreatedDate], [Status]) VALUES (7, N'MOD', N'Cập nhật, thêm, sửa', CAST(N'2021-12-27T15:28:47.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[ManagerGroup] OFF
GO
INSERT [dbo].[MappingRole] ([ManagerGroupID], [RoleID], [Note]) VALUES (6, 1, NULL)
INSERT [dbo].[MappingRole] ([ManagerGroupID], [RoleID], [Note]) VALUES (7, 1, NULL)
INSERT [dbo].[MappingRole] ([ManagerGroupID], [RoleID], [Note]) VALUES (7, 2, NULL)
INSERT [dbo].[MappingRole] ([ManagerGroupID], [RoleID], [Note]) VALUES (7, 5, NULL)
INSERT [dbo].[MappingRole] ([ManagerGroupID], [RoleID], [Note]) VALUES (7, 6, NULL)
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (9, N'7 Bước Đệm Dẫn Đến Thành Công', N'7_buoc_dem_dan_den_thanh_cong', N'Trên con đường tiến tới thành công, khó khăn, trục trặc thậm chí thất bại là điều khó tránh khỏi. Lúc đó nếu chỉ dựa vào nhiệt tình, hăng hái chủ quan thì không thể đạt tới thành công, bởi vì bạn đang gặp khó khăn, trục trặc vượt quá năng lực xử lý của mình. Chỉ có một con đường duy nhất là bạn phải dựa vào sức lực, tài năng, trí tuệ của người khác mới có thể khắc phục được khó khăn, giành thắng lợi một phần hoặc hoàn toàn.', N'7-buoc-dem-dan-den-thanh-cong-500x554-1.jpg', NULL, N'Nguyễn Duy Nguyên, Đức Minh', CAST(58000 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), 592, 1, N'<p style="text-align:justify">Rất nhiều người khi gặp kh&oacute; th&igrave; o&aacute;n trời tr&aacute;ch người, chờ đợi t&igrave;nh h&igrave;nh thay đổi. T&acirc;m l&yacute; chờ đợi ti&ecirc;u cực bị động n&agrave;y thường kh&ocirc;ng c&oacute; kết quả. Tốt nhất bạn phải t&igrave;m chỗ dựa m&agrave; bạn c&oacute; thể nhờ cậy được. C&oacute; nhiều người khi mới bắt đầu, vừa gặp kh&oacute; khăn hoặc thất bại đ&atilde; ng&atilde; l&ograve;ng. Họ kh&ocirc;ng hiểu rằng; kh&ocirc;ng c&oacute; đau khổ th&igrave; kh&ocirc;ng c&oacute; hạnh ph&uacute;c, kh&ocirc;ng c&oacute; thất bại th&igrave; kh&ocirc;ng c&oacute; th&agrave;nh c&ocirc;ng.</p><p style="text-align:justify">Tr&ecirc;n con đường tiến tới th&agrave;nh c&ocirc;ng, kh&oacute; khăn, trục trặc thậm ch&iacute; thất bại l&agrave; điều kh&oacute; tr&aacute;nh khỏi. L&uacute;c đ&oacute; nếu chỉ dựa v&agrave;o nhiệt t&igrave;nh, hăng h&aacute;i chủ quan th&igrave; kh&ocirc;ng thể đạt tới th&agrave;nh c&ocirc;ng, bởi v&igrave; bạn đang gặp kh&oacute; khăn, trục trặc vượt qu&aacute; năng lực xử l&yacute; của m&igrave;nh. Chỉ c&oacute; một con đường duy nhất l&agrave; bạn phải dựa v&agrave;o sức lực, t&agrave;i năng, tr&iacute; tuệ của người kh&aacute;c mới c&oacute; thể khắc phục được kh&oacute; khăn, gi&agrave;nh thắng lợi một phần hoặc ho&agrave;n to&agrave;n.</p><p style="text-align:justify">Rất nhiều người khi gặp kh&oacute; th&igrave; o&aacute;n trời tr&aacute;ch người, chờ đợi t&igrave;nh h&igrave;nh thay đổi. T&acirc;m l&yacute; chờ đợi ti&ecirc;u cực bị động n&agrave;y thường kh&ocirc;ng c&oacute; kết quả. Tốt nhất bạn phải t&igrave;m chỗ dựa m&agrave; bạn c&oacute; thể nhờ cậy được. C&oacute; nhiều người khi mới bắt đầu, vừa gặp kh&oacute; khăn hoặc thất bại đ&atilde; ng&atilde; l&ograve;ng. Họ kh&ocirc;ng hiểu rằng; kh&ocirc;ng c&oacute; đau khổ th&igrave; kh&ocirc;ng c&oacute; hạnh ph&uacute;c, kh&ocirc;ng c&oacute; thất bại th&igrave; kh&ocirc;ng c&oacute; th&agrave;nh c&ocirc;ng.</p>', CAST(N'2021-12-19T13:57:01.000' AS DateTime), 1, NULL, 28)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10, N'Khoảng Cách Từ Nói Đến Làm', N'khoang_cach_tu_noi_den_lam', N'Tại sao lại có quá nhiều khoảng cách giữa những điều mà các công ty biết là họ nên làm với những việc họ thực sự làm?

Tại sao lại có quá nhiều các công ty không thể áp dụng những kinh nghiệm và kiến thức mà họ đã phải rất nỗ lực mới tích lũy được?

Khoảng cách từ nói đến làm (The Knowing-Doing Gap) là cuốn sách đầu tiên đối mặt với thách thức biến kiến thức về cách nâng cao hiệu suất hoạt động thành hành động thực sự tạo ra những kết quả có thể định lượng được.', N'khoang-cach-tu-noi-den-lam-jeffrey-pfeffer-robert-i.-sutton-708x1024.jpg', NULL, N'Jeffrey Pfeffer & Robert I. Sutton', CAST(78000 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), 222, 1, N'<p style="text-align:justify">Trong cuốn s&aacute;ch n&agrave;y,&nbsp;<strong>Jeffrey Pfeffer&nbsp;v&agrave;&nbsp;Robert Sutton</strong>, những t&aacute;c giả v&agrave; giảng vi&ecirc;n nổi tiếng, đ&atilde; x&aacute;c định nguy&ecirc;n nh&acirc;n của khoảng c&aacute;ch từ biết tới l&agrave;m v&agrave; đưa ra c&aacute;ch lấp đầy khoảng c&aacute;ch đ&oacute;. Th&ocirc;ng điệp trong cuốn s&aacute;ch rất r&otilde; r&agrave;ng &ndash; c&aacute;c c&ocirc;ng ty muốn biến kiến thức th&agrave;nh h&agrave;nh động phải tr&aacute;nh xa &ldquo;bẫy n&oacute;i su&ocirc;ng&rdquo;(smart talk trap). Những kế hoạch, ph&acirc;n t&iacute;ch, cuộc họp, buổi tr&igrave;nh b&agrave;y của nh&agrave; điều h&agrave;nh để truyền cảm hứng cho c&ocirc;ng việc kh&ocirc;ng thể thay thế cho h&agrave;nh động.</p>

<p style="text-align:justify">Những c&ocirc;ng ty m&agrave; h&agrave;nh động dựa tr&ecirc;n kiến thức sẽ loại bỏ được nỗi sợ h&atilde;i, sự cạnh tranh nội bộ, biết được c&aacute;i g&igrave; quan trọng v&agrave; củng cố vai tr&ograve; người l&atilde;nh đạo, người vốn hiểu r&otilde; c&ocirc;ng việc của từng nh&acirc;n vi&ecirc;n trong c&ocirc;ng ty.</p>

<p style="text-align:justify"><br />
C&aacute;c t&aacute;c giả lấy v&iacute; dụ từ h&agrave;ng t&aacute; c&ocirc;ng ty để chỉ ra tại sao một số c&oacute; thể vượt qua khoảng c&aacute;ch từ biết đến l&agrave;m, một số d&ugrave; cố nhưng kh&ocirc;ng thể v&agrave; một số kh&aacute;c tr&aacute;nh được ngay từ đầu. Khoảng c&aacute;ch từ n&oacute;i đến l&agrave;m chắc chắn l&agrave; cuốn s&aacute;ch hữu &iacute;ch đối với những gi&aacute;m đốc điều h&agrave;nh ở mọi nơi tr&ecirc;n thế giới h&agrave;ng ng&agrave;y đang phải đấu tranh để gi&uacute;p c&ocirc;ng ty của họ vừa biết lại vừa l&agrave;m được những g&igrave; họ biết. Đ&acirc;y l&agrave; một cẩm nang thực tế, hữu &iacute;ch trong vấn đề n&acirc;ng cao hiệu quả hoạt động trong doanh nghiệp ng&agrave;y nay.</p>
', CAST(N'2021-12-19T13:56:53.000' AS DateTime), 1, CAST(N'2022-01-01T00:00:00.000' AS DateTime), 38)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (11, N'Lối Mòn Của Tư Duy Cảm Tính', N'loi_mon_cua_tu_duy_cam_tinh', N'Dựa trên những nghiên cứu sâu sắc về các lĩnh vực tâm lý xã hội, kinh tế học hành vi và hành vi tổ chức, nhà lý luận xã hội học nổi tiếng Ori Brafman đã khám phá ra nhiều tác động tâm lý có sức ảnh hưởng đến đời sống cá nhân và công việc của mỗi người', N'loi-mon-cua-tu-duy-cam-tinh.jpg', NULL, N'Ori Brafman, Rom Brafman ', CAST(100000 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), 987, 1, N'<p style="text-align:justify">Dựa tr&ecirc;n những nghi&ecirc;n cứu s&acirc;u sắc về c&aacute;c lĩnh vực t&acirc;m l&yacute; x&atilde; hội, kinh tế học h&agrave;nh vi v&agrave; h&agrave;nh vi tổ chức, nh&agrave; l&yacute; luận x&atilde; hội học nổi tiếng Ori Brafman đ&atilde; kh&aacute;m ph&aacute; ra nhiều t&aacute;c động t&acirc;m l&yacute; c&oacute; sức ảnh hưởng đến đời sống c&aacute; nh&acirc;n v&agrave; c&ocirc;ng việc của mỗi người, bao gồm t&acirc;m l&yacute; lo sợ thiệt hại (xu hướng tho&aacute;i lui nhằm tr&aacute;nh thiệt hại, tổn thất c&oacute; thể xảy ra), hiện tượng sai lệch chẩn đo&aacute;n (t&igrave;nh trạng con người mất khả năng đ&aacute;nh gi&aacute; v&agrave; nhận định lại những x&eacute;t đo&aacute;n ban đầu về một người hay một sự việc n&agrave;o đ&oacute;) v&agrave; hiệu ứng tắc k&egrave; hoa (xu hướng chấp nhận cả những t&iacute;nh c&aacute;ch vốn bị người kh&aacute;c g&aacute;n gh&eacute;p t&ugrave;y tiện cho bản th&acirc;n m&igrave;nh).</p>

<p style="text-align:justify"><em><strong>Lối M&ograve;n Của Tư Duy Cảm T&iacute;nh</strong></em> kh&ocirc;ng chỉ gi&uacute;p bạn thay đổi quan hệ về thế giới xung quanh m&agrave; c&ograve;n gi&uacute;p bạn thay đổi c&aacute;ch tư duy của ch&iacute;nh m&igrave;nh. Với lối m&ograve;n của tư duy cảm t&iacute;nh, hai t&aacute;c giả Ori v&agrave; Rom mang đến cho người đọc những nhận định kh&aacute;ch quan, giải th&iacute;ch cho h&agrave;ng loạt c&aacute;c h&agrave;nh vi cảm t&iacute;nh đồng thời giới thiệu về c&aacute;c phương ph&aacute;p c&oacute; thể gi&uacute;p ch&uacute;ng ta chế ngự v&agrave; vượt quan những t&aacute;c động ti&ecirc;u cực của lối tư duy n&agrave;y.</p>
', CAST(N'2021-12-19T13:57:07.000' AS DateTime), 1, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 24)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (12, N'Học Cách Tiêu Tiền', N'hoc_cach_tieu_tien', N'Mọi người vẫn cho rằng tiêu tiền là một việc hết sức tự nhiên và dễ nhất trần đời. Chúng ta chi tiền cho những nhu cầu cá nhân: thực phẩm, quần áo, giải trí,… Quan trọng là bạn có tiền hay không? Bạn kiếm tiền như thế nào? Và, làm thế nào để kiếm được thật nhiều tiền? Khi đã có tiền thì việc tiêu tiền thật đơn giản!!! Nếu bạn từng suy nghĩ như vậy thì việc bạn “vung tay quá trán” cũng là điều dễ hiểu', N'hoc-cach-tieu-tien-600x900-1.jpg', NULL, N'Larry Winget', CAST(89500 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)), 794, 1, N'<p><span style="color:#d35400"><strong>KIẾM ĐƯỢC TIỀN Đ&Atilde; KH&Oacute; &ndash; ĐỂ TI&Ecirc;U TIỀN C&Ograve;N KH&Oacute; HƠN</strong></span></p>

<p style="text-align:justify">Hẳn bạn sẽ ngạc nhi&ecirc;n với ti&ecirc;u đề n&agrave;y? Học c&aacute;ch ti&ecirc;u tiền, bạn từng nghe lần n&agrave;o chưa?</p>

<p style="text-align:justify">Mọi người vẫn cho rằng ti&ecirc;u tiền l&agrave; một việc hết sức tự nhi&ecirc;n v&agrave; dễ nhất trần đời. Ch&uacute;ng ta chi tiền cho những nhu cầu c&aacute; nh&acirc;n: thực phẩm, quần &aacute;o, giải tr&iacute;,&hellip; Quan trọng l&agrave; bạn c&oacute; tiền hay kh&ocirc;ng? Bạn kiếm tiền như thế n&agrave;o? V&agrave;, l&agrave;m thế n&agrave;o để kiếm được thật nhiều tiền? Khi đ&atilde; c&oacute; tiền th&igrave; việc ti&ecirc;u tiền thật đơn giản!!! Nếu bạn từng suy nghĩ như vậy th&igrave; việc bạn &ldquo;vung tay qu&aacute; tr&aacute;n&rdquo; cũng l&agrave; điều dễ hiểu.</p>

<p style="text-align:justify">Tiền bạc lu&ocirc;n l&agrave; một trong những vấn đề quan trọng của cuộc sống. C&oacute; thể, tiền kh&ocirc;ng l&agrave; mục ti&ecirc;u h&agrave;ng đầu đối với bạn, nhưng tiền lại c&oacute; t&aacute;c động đến hầu hết mọi kh&iacute;a cạnh trong cuộc sống, những ước mơ, dự định trong tương lai của bạn đều &iacute;t nhiều chịu sự chi phối của đồng tiền. Nghe c&oacute; vẻ to t&aacute;t qu&aacute; phải kh&ocirc;ng bạn? Vậy h&atilde;y nghĩ đến những việc đơn giản hơn như mua đồ ăn, quần &aacute;o, xăng xe; đi chơi, đi xem phim, đi ăn nh&agrave; h&agrave;ng; theo học bậc đại học, s&aacute;ch vở, dụng cụ học tập&hellip; tất cả đều cần c&oacute; tiền. Ti&ecirc;u tiền l&agrave; một h&agrave;nh động qu&aacute; đỗi b&igrave;nh thường, nhưng kh&ocirc;ng c&oacute; nghĩa l&agrave; mọi người đều đ&atilde; biết c&aacute;ch ti&ecirc;u tiền.</p>

<p style="text-align:justify">&Ocirc;ng chỉ ra rằng ch&iacute;nh c&aacute;ch chi ti&ecirc;u c&ugrave;ng lối suy nghĩ của mọi người về vấn đề tiền bạc, chứ kh&ocirc;ng phải nguy&ecirc;n nh&acirc;n n&agrave;o kh&aacute;c, đ&atilde; khiến họ l&acirc;m v&agrave;o t&igrave;nh cảnh &ldquo;ch&aacute;y t&uacute;i&rdquo; v&agrave; nợ nần chồng chất.</p>

<p style="text-align:justify">Trong cuốn s&aacute;ch n&agrave;y, Larry Winget đưa ra những phương ph&aacute;p r&otilde; r&agrave;ng, cụ thể v&agrave; dễ &aacute;p dụng để kiểm so&aacute;t chi ti&ecirc;u. Đ&oacute; l&agrave; những việc l&agrave;m hết sức đơn giản nhưng mang lại hiệu quả bất ngờ, như bỏ truyền h&igrave;nh c&aacute;p, hạn chế đi ăn nh&agrave; h&agrave;ng, dọn dẹp nh&agrave; cửa,&hellip; hay những việc l&agrave;m mang t&iacute;nh d&agrave;i hạn như l&ecirc;n kế hoạch chi ti&ecirc;u h&agrave;ng th&aacute;ng, chuyển sang một căn hộ mới, dạy dỗ con c&aacute;i về t&agrave;i ch&iacute;nh&hellip; Xen kẽ l&agrave; những b&agrave;i tập thực h&agrave;nh nho nhỏ, những c&acirc;u chuyện, v&iacute; dụ đơn giản v&agrave; gần gũi, gi&uacute;p người đọc hiểu r&otilde; hơn về thực trạng t&agrave;i ch&iacute;nh của bản th&acirc;n v&agrave; c&oacute; th&ecirc;m động lực để tho&aacute;t khỏi t&igrave;nh trạng kh&oacute; khăn.</p>

<p style="text-align:justify">Bạn đang c&oacute; một c&ocirc;ng việc kiếm sống nhưng bạn gặp kh&oacute; khăn trong việc vươn l&ecirc;n một tầm cao mới? Bạn mong muốn tự chủ về t&agrave;i ch&iacute;nh? Bạn đang ngập trong đống nợ nần v&agrave; loay hoay t&igrave;m c&aacute;ch tho&aacute;t ra? Bạn chi nhiều hơn thu v&agrave; kh&ocirc;ng thể t&igrave;m ra c&aacute;ch để chấm dứt? Học c&aacute;ch ti&ecirc;u tiền ch&iacute;nh l&agrave; giải ph&aacute;p cho những vấn đề đ&oacute;.</p>
', CAST(N'2021-12-19T13:57:20.000' AS DateTime), 1, CAST(N'2022-02-12T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (13, N'10 Điều Khác Biệt Nhất Giữa Kẻ Giàu & Người Nghèo', N'10_dieu_khac_biet_nhat_giua_ke_giau___nguoi_ngheo', N'<p><em><strong><span style="background-color:#ffff00">&ldquo;H&atilde;y lu&ocirc;n nhớ rằng th&agrave;nh c&ocirc;ng vừa l&agrave; một h&agrave;nh tr&igrave;nh, vừa l&agrave; đ&iacute;ch đến v&agrave; con đường để tới đ&oacute; cần lu&ocirc;n được x&acirc;y đắp mỗi ng&agrave;y.&rdquo;</span></strong></em> &ndash; <strong>K.C.Smith Keith Cameron</strong> <strong>Smith </strong>t&aacute;c giả của bộ s&aacute;ch &ldquo;<em>10 điều kh&aacute;c biệt nhất giữa kẻ thắng v&agrave; người thua</em>&rdquo;, &ldquo;<em>10 điều kh&aacute;c biệt nhất giữa kẻ l&agrave;m chủ v&agrave; người l&agrave;m thu&ecirc;</em>&rdquo;, v&agrave; với t&aacute;c phẩm n&agrave;y l&agrave; &ldquo;<strong><em>10 điều kh&aacute;c biệt nhất giữa kẻ gi&agrave;u v&agrave; người ngh&egrave;o</em></strong>&rdquo;. Tại sao &ocirc;ng lại viết một cuốn s&aacute;ch về người gi&agrave;u v&agrave; người ngh&egrave;o trong khi đ&atilde; c&oacute; v&ocirc; v&agrave;n những cuốn s&aacute;ch kh&aacute;c cũng đề cập đến vấn đề n&agrave;y? &Ocirc;ng viết cuốn s&aacute;ch n&agrave;y với mong muốn chia sẻ cho mọi người những kinh nghiệm về sự thất bại m&agrave; &ocirc;ng đ&atilde; trải qua, cũng như những th&agrave;nh c&ocirc;ng m&agrave; &ocirc;ng đ&atilde; đạt được. Điều th&uacute; vị ở quyển s&aacute;ch l&agrave; c&aacute;ch sắp xếp đề mục theo thứ tự tầm quan trọng giảm dần nhưng điều đ&oacute; cũng kh&ocirc;ng l&agrave;m ảnh hưởng đến nội dung. S&aacute;ch kh&ocirc;ng hướng dẫn cho bạn c&aacute;ch l&agrave;m gi&agrave;u như thế n&agrave;o, nhưng n&oacute; chỉ ra như thế n&agrave;o l&agrave; tư duy của một người gi&agrave;u c&oacute;.</p>
', N'sach-10-dieu-khac-biet-nhat-giua-ke-giau-va-nguoi-ngheo-1.jpg', NULL, N'Keith Cameron Smith', CAST(120000 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), 600, 2, N'<p style="text-align:justify"><strong><span style="background-color:#f1c40f">1. Người gi&agrave;u nghĩ d&agrave;i, người ngh&egrave;o nghĩ ngắn</span></strong></p>

<p style="text-align:justify">&ldquo;X&atilde; hội c&oacute; thể được chia th&agrave;nh 5 lớp người: rất ngh&egrave;o, ngh&egrave;o, trung lưu, gi&agrave;u v&agrave; rất gi&agrave;u. Mỗi người nghĩ về tiền bạc theo một c&aacute;ch kh&aacute;c nhau. Người rất ngh&egrave;o nghĩ theo ng&agrave;y, người ngh&egrave;o nghĩ theo tuần, trung lưu nghĩ theo th&aacute;ng, người gi&agrave;u nghĩ theo năm v&agrave; những người rất gi&agrave;u nghĩ theo thập kỉ.</p>

<p style="text-align:justify">C&oacute; ba mục ti&ecirc;u cơ bản trong tư duy của 5 nh&oacute;m người tr&ecirc;n. Mục ti&ecirc;u ch&iacute;nh của nh&oacute;m người rất ngh&egrave;o v&agrave; ngh&egrave;o l&agrave; tồn tại. Mục ti&ecirc;u cơ bản của tầng lớp trung lưu l&agrave; sự tiện nghi, sung t&uacute;c, c&ograve;n mục ti&ecirc;u của lớp người gi&agrave;u v&agrave; rất gi&agrave;u l&agrave; tự do.&rdquo;</p>

<p style="text-align:justify">Th&oacute;i quen trong tư tưởng v&agrave; suy nghĩ của mỗi người quyết định n&ecirc;n sự gi&agrave;u c&oacute; chứ kh&ocirc;ng hẳn l&agrave; sự bất c&ocirc;ng của x&atilde; hội. Người gi&agrave;u lại c&agrave;ng th&ecirc;m gi&agrave;u nhờ những suy nghĩ s&acirc;u xa về tương lai của họ, &ldquo;c&agrave;ng suy nghĩ d&agrave;i hơi, bạn c&agrave;ng trở n&ecirc;n gi&agrave;u c&oacute;&rdquo;. Người ngh&egrave;o chỉ nghĩ đến cuộc sống hiện tại. Ngh&egrave;o ở đ&acirc;y kh&ocirc;ng hẳn l&agrave; ngh&egrave;o về vật chất, về tiền bạc m&agrave; l&agrave; ngh&egrave;o về tư duy, tư tưởng, lối suy nghĩ, ngh&egrave;o n&agrave;n trong c&aacute;c mối quan hệ v&agrave; trong mọi lĩnh vực của cuộc sống.</p>

<p style="text-align:justify">Để bắt đầu trước hết h&atilde;y lập kế hoạch, mục ti&ecirc;u cho bản th&acirc;n trong 5, 10, 20 năm nữa v&agrave; ki&ecirc;n nhẫn thực hiện. Chỉ c&oacute; ki&ecirc;n nhẫn mới h&igrave;nh th&agrave;nh th&oacute;i quen v&agrave; từ th&oacute;i quen mới quyết định sự th&agrave;nh c&ocirc;ng của bạn như K.C.Smith n&oacute;i: &ldquo;Ki&ecirc;n nhẫn l&agrave; t&agrave;i sản của người gi&agrave;u, n&oacute;ng vội l&agrave; khoản nợ của người ngh&egrave;o&rdquo;.</p>

<p style="text-align:justify">Một điều m&agrave; K.C.Smith muốn đề cập nữa l&agrave; việc x&acirc;y dựng c&aacute;c mối quan hệ. Gần đ&acirc;y, trường Đại học Harvard đ&atilde; c&ocirc;ng bố kết quả của một cuộc nghi&ecirc;n cứu được thực hiện trong 75 năm, trải qua 4 đời nghi&ecirc;n cứu để trả lời cho c&acirc;u điều g&igrave; khiến cho con người ta hạnh ph&uacute;c. Điều khiến cho con người ta hạnh ph&uacute;c ch&iacute;nh l&agrave; họ sở hữu những mối quan hệ bền vững, tốt đẹp. Đ&oacute; l&agrave; gia đ&igrave;nh, l&agrave; bạn b&egrave; th&acirc;n thiết, l&agrave; tri kỷ.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">2. Người gi&agrave;u b&agrave;n về &yacute; tưởng, người ngh&egrave;o bu&ocirc;n chuyện t&agrave;o lao</span></strong></p>

<p style="text-align:justify">&ldquo;Tr&ecirc;n đời c&oacute; ba loại người, những người l&agrave;m n&ecirc;n, những người chứng kiến v&agrave; những kẻ b&agrave;n luận về những g&igrave; đ&atilde; diễn ra.</p>

<p style="text-align:justify">Trong cuộc sống, ch&uacute;ng ta c&oacute; đ&ocirc;i l&uacute;c t&aacute;n ngẫu, b&agrave;n luận với bạn b&egrave;, người th&acirc;n về những chuyện của người kh&aacute;c theo chiều hướng t&iacute;ch cực v&agrave; ti&ecirc;u cực. Nhưng hầu hết ch&uacute;ng ta thường n&oacute;i v&agrave; bận l&ograve;ng về những điều m&agrave; người kh&aacute;c khiến ch&uacute;ng ta kh&ocirc;ng vừa l&ograve;ng. Thực tế l&agrave; &ldquo;nếu d&agrave;nh qu&aacute; nhiều thời gian b&agrave;n t&aacute;n chuyện của người kh&aacute;c, bạn sẽ trả gi&aacute; cả về vật chất lẫn tinh thần&rdquo;.</p>

<p style="text-align:justify">C&ograve;n những người gi&agrave;u th&igrave; sao? Người gi&agrave;u d&agrave;nh nhiều thời gian qu&yacute; b&aacute;u của m&igrave;nh để n&oacute;i về c&aacute;c &yacute; tưởng v&agrave; học hỏi từ quan điểm của những người th&agrave;nh đạt để l&agrave;m cho đời sống m&igrave;nh trở n&ecirc;n phong ph&uacute; v&agrave; c&oacute; &yacute; nghĩa hơn. Từ đ&oacute;, c&aacute;c &yacute; tưởng sinh s&ocirc;i nảy nở v&agrave; ch&uacute;ng sẽ gi&uacute;p cho ch&uacute;ng ta đạt được những điều m&agrave; ch&uacute;ng ta mong muốn. Bởi lẽ, &ldquo;tiền bạc c&oacute; sức mạnh lớn lao, nhưng &yacute; tưởng c&oacute; sức mạnh phi thường&rdquo;.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">3. Người gi&agrave;u cấp tiến, người ngh&egrave;o thủ cựu</span></strong></p>

<p style="text-align:justify">Trong khi thế giới, đặc biệt l&agrave; c&aacute;c nước ph&aacute;t triển đang tiến đến cuộc c&aacute;ch mạng 4.0 th&igrave; h&agrave;ng triệu người Việt Nam c&ugrave;ng với c&aacute;c quốc gia k&eacute;m ph&aacute;t triển v&agrave; đang ph&aacute;t triển phải đối diện với việc l&agrave;m sao để thay đổi v&agrave; bắt kịp theo xu hướng của thế giới. Nido Qubein n&oacute;i: &ldquo;Đối với những người hay e sợ, sự thay đổi thật l&agrave; kinh khủng. Với những người b&igrave;nh thường, sự thay đổi l&agrave; đe dọa. Nhưng với những người thật sự tự tin, thay đổi l&agrave; cơ hội&rdquo;.</p>

<p style="text-align:justify">Những người tự tin sẽ trở n&ecirc;n gi&agrave;u c&oacute; v&igrave; họ chấp nhận sự thay đổi v&agrave; cơ hội sẽ đến với họ. C&ograve;n những người lu&ocirc;n bất an, nghi ngờ về sự thay đổi sẽ đ&aacute;nh mất cơ hội v&agrave; đ&aacute;nh mất sự gi&agrave;u c&oacute;. Tất nhi&ecirc;n gi&agrave;u c&oacute; lu&ocirc;n đi k&egrave;m với sự đ&aacute;nh đổi, sợ h&atilde;i chỉ l&agrave;m ch&ugrave;n bước ch&acirc;n của bạn. Sự thay đổi sẽ cho thấy bạn l&agrave; người như thế n&agrave;o. N&oacute; bộc lộ bản chất con người bạn. &ldquo;Tương lai thuộc về những người thay đổi theo thời gian&rdquo;.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">4. Người gi&agrave;u d&aacute;m mạo hiểm, người ngh&egrave;o an phận thủ thường</span></strong></p>

<p style="text-align:justify">&ldquo;Người ngh&egrave;o bị mắc kẹt trong v&ograve;ng luẩn quẩn l&agrave;m thu&ecirc; v&igrave; họ kh&ocirc;ng d&aacute;m mạo hiểm.&rdquo;</p>

<p style="text-align:justify">&ldquo;Người gi&agrave;u mạo hiểm C&Oacute; T&Iacute;NH TO&Aacute;N.&rdquo;</p>

<p style="text-align:justify">C&oacute; thể nhận thấy một v&agrave;i điểm chung của những người kh&ocirc;ng d&aacute;m mạo hiểm l&agrave; họ sợ thất bại, sợ bị cự tuyệt v&agrave; sợ thua thiệt. Tất nhi&ecirc;n những người mạo hiểm l&agrave; những người lu&ocirc;n c&oacute; th&aacute;i độ t&iacute;ch cực. Họ tự tin, kh&ocirc;ng sợ bị người kh&aacute;c b&aacute;c bỏ những &yacute; tưởng của m&igrave;nh, sẵn s&agrave;ng cho mọi người thấy quan điểm của m&igrave;nh v&agrave; quan trọng l&agrave; họ kh&ocirc;ng sợ thất bại. Cũng giống như giữa việc chọn một c&ocirc;ng việc theo sở th&iacute;ch hay chọn một c&ocirc;ng việc đảm bảo mức sống, nhu cầu cho c&aacute; nh&acirc;n v&agrave; gia đ&igrave;nh. Tuổi trẻ l&uacute;c n&agrave;o cũng ph&acirc;n v&acirc;n giữa một quyết định an to&agrave;n v&agrave; một quyết định mạo hiểm. Thế n&ecirc;n trước mỗi lần quyết định việc g&igrave; đ&oacute;, ch&uacute;ng ta phải c&oacute; đủ c&aacute;c kiến thức, th&ocirc;ng tin cần thiết, dự đo&aacute;n trước những hậu quả sẽ xảy ra.</p>

<p style="text-align:justify">Nido Quebein cố vấn của K.C.Smith đ&atilde; dạy &ocirc;ng trả lời ba c&acirc;u hỏi trước khi quyết định để đưa ra những quyết định th&ocirc;ng minh nhất:</p>

<p style="text-align:justify">&ldquo;Điều tốt nhất c&oacute; thể xảy ra l&agrave; g&igrave;?</p>

<p style="text-align:justify">Điều tồi tệ c&oacute; thể xảy ra l&agrave; g&igrave;?</p>

<p style="text-align:justify">Điều g&igrave; c&oacute; khả năng xảy ra nhất?&rdquo;</p>

<p style="text-align:justify">Cho d&ugrave; kết quả c&oacute; thất bại hay th&agrave;nh c&ocirc;ng th&igrave; &iacute;t nhất bạn cũng đ&atilde; c&oacute; cho bản th&acirc;n m&igrave;nh một b&agrave;i học, một kinh nghiệm qu&yacute; gi&aacute;. Tỉnh giấc giữa giấc mơ, hoặc giấc mơ đ&oacute; l&agrave; c&oacute; thật. Đừng để đến cuối cuộc đời, bạn phải hối tiếc về những g&igrave; m&agrave; m&igrave;nh chưa l&agrave;m. Gửi tặng đến bạn một lời khuy&ecirc;n ch&acirc;n th&agrave;nh nhất h&atilde;y &ldquo;sống như thể mai l&agrave; ng&agrave;y tận thế&rdquo;.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">5. Người gi&agrave;u học cả đời, người ngh&egrave;o theo nửa đoạn</span></strong></p>

<p style="text-align:justify">&ldquo;Hầu hết c&aacute;c triệu ph&uacute; m&agrave; t&ocirc;i biết đều đọc mỗi tuần một cuốn s&aacute;ch&rdquo;. S&aacute;ch l&agrave; nguồn tri thức rộng lớn, l&agrave; cả một kho t&agrave;ng đồ sộ m&agrave; c&aacute;c t&aacute;c giả mất cả cuộc đời của m&igrave;nh để nghi&ecirc;n cứu, thu thập dữ liệu v&agrave; mất chất x&aacute;m để đầu tư v&agrave;o đứa con tinh thần của m&igrave;nh truyền đạt đến cho nh&acirc;n loại. Trong khi nh&acirc;n loại tiếp thu kiến thức đ&oacute; chỉ trong một v&agrave;i giờ đọc nghiềm ngẫm. Khi bạn bỏ tiền ra mua một cuốn s&aacute;ch c&oacute; nghĩa l&agrave; bạn đ&atilde; bỏ tiền ra để trả c&ocirc;ng cho những lời khuy&ecirc;n, những b&agrave;i học của những người từng trải.</p>

<p style="text-align:justify">&ldquo;Người gi&agrave;u đọc s&aacute;ch về tiền bạc v&agrave; c&aacute;ch tạo dựng quan hệ. Họ đọc về sức mạnh của tr&iacute; &oacute;c, về những b&agrave;i học th&agrave;nh c&ocirc;ng v&agrave; thất bại của những người kh&aacute;c&rdquo;.</p>

<p style="text-align:justify">Quan điểm &ldquo;người gi&agrave;u l&agrave; cậu học tr&ograve; t&iacute;ch cực trong cuộc đời chứ kh&ocirc;ng chỉ tr&ecirc;n phương diện tiền bạc&rdquo; của K.C.Smith cũng giống như lời Hồ Ch&iacute; Minh từng n&oacute;i &ldquo;Học hỏi l&agrave; một việc phải tiếp tục suốt đời&rdquo;. Ngo&agrave;i những kiến thức phổ th&ocirc;ng bạn c&ograve;n phải học th&ecirc;m những điều m&agrave; trường học kh&ocirc;ng dạy bạn. Bởi trường đời &aacute;c liệt v&agrave; t&agrave;n khốc hơn trường học rất nhiều. Ch&iacute;nh v&igrave; qu&aacute; khốc liệt n&ecirc;n n&oacute; sẽ dạy cho bạn rất nhiều kinh nghiệm v&agrave; b&agrave;i học nhớ đời. Để cho bạn kh&ocirc;ng phải sống với sự &aacute;p lực v&agrave; cạnh tranh đ&oacute; bạn cần phải bắt đầu học v&agrave; l&agrave;m những g&igrave; m&agrave; bạn y&ecirc;u th&iacute;ch, những g&igrave; tạo được cảm hứng cho bạn. C&oacute; thế bạn mới c&oacute; động lực, những &yacute; tưởng mới tu&ocirc;n tr&agrave;o. Ngo&agrave;i ra, bạn cũng cần phải biết ưu ti&ecirc;n học c&aacute;ch l&agrave;m h&agrave;i l&ograve;ng bản th&acirc;n, học c&aacute;ch quan t&acirc;m đến gia đ&igrave;nh v&agrave; sức khỏe của bản th&acirc;n. H&atilde;y lu&ocirc;n nhớ người gi&agrave;u học cả đời v&agrave; học hỏi những phương diện kh&aacute;c nhau của cuộc sống.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">6. Người gi&agrave;u nỗ lực v&igrave; lợi nhuận, người ngh&egrave;o l&agrave;m việc v&igrave; lương</span></strong></p>

<p style="text-align:justify">&ldquo;Nếu bạn coi lương l&agrave; nguồn thu nhập ch&iacute;nh, thu nhập của bạn sẽ lu&ocirc;n v&ocirc; c&ugrave;ng hạn chế. Nếu nỗ lực tạo lợi nhuận, khi đ&oacute; thu nhập của bạn sẽ l&agrave; v&ocirc; tận.&rdquo;</p>

<p style="text-align:justify">Lương l&agrave; khoản tiền bạn nhận được cho c&ocirc;ng việc bạn l&agrave;m. Lợi nhuận l&agrave; khoản ch&ecirc;nh lệch giữa gi&aacute; mua đầu v&agrave;o thấp v&agrave; gi&aacute; b&aacute;n cao. Tất nhi&ecirc;n qu&aacute; tr&igrave;nh l&agrave;m việc v&igrave; lợi nhuận phải trải qua giai đoạn đầu ti&ecirc;n l&agrave; l&agrave;m việc v&igrave; lương. Trong qu&aacute; tr&igrave;nh đ&oacute;, bạn c&oacute; thể học hỏi v&agrave; t&igrave;m cho m&igrave;nh cơ hội để sẵn s&agrave;ng kiếm được những nguồn lợi nhuận nhỏ cho đến khi c&oacute; cơ hội để kiếm được nguồn lợi nhuận lớn. Để l&agrave;m được điều đ&oacute;, bạn cần phải c&oacute; một ch&uacute;t mạo hiểm, một ch&uacute;t may mắn v&agrave; điều đặc biệt l&agrave; bạn cần phải biết tận dụng cơ hội trong những thời điểm th&iacute;ch hợp. Điều m&agrave; K.C.Smith r&uacute;t ra được trong kinh nghiệm của m&igrave;nh về kh&iacute;a cạnh lợi nhuận v&agrave; lương được chia sẻ trong quyển s&aacute;ch n&agrave;y l&agrave; &ldquo;Nếu muốn th&agrave;nh triệu ph&uacute;, bạn cần học c&aacute;ch l&agrave;m việc v&igrave; lợi nhuận&rdquo;.</p>

<p style="text-align:justify"><strong>7. Người gi&agrave;u rộng tay, người ngh&egrave;o đong đếm</strong></p>

<p style="text-align:justify">Một trong những c&acirc;u chuyện về sự h&agrave;o ph&oacute;ng của t&aacute;c giả:</p>

<p style="text-align:justify">Một h&ocirc;m, t&ocirc;i đến mua đồ ăn trưa tại một cửa h&agrave;ng b&aacute;nh sandwich. Một ch&agrave;ng trai khoảng 19 tuổi phục vụ t&ocirc;i. Tổng số tiền phải trả kh&ocirc;ng đến 5 đ&ocirc;-la, nhưng t&ocirc;i đ&atilde; đưa cậu ta 10 đ&ocirc;-la. Khi cậu ta trả lại t&ocirc;i 5 đ&ocirc;-la v&agrave; một &iacute;t xu lẻ, t&ocirc;i đ&uacute;t v&agrave;o t&uacute;i v&agrave; đưa cậu 5 đ&ocirc;-la. &ldquo;Đ&acirc;y l&agrave; tiền boa cho cậu&rdquo;, t&ocirc;i n&oacute;i.</p>

<p style="text-align:justify">Trong một tho&aacute;ng, cậu thanh ni&ecirc;n c&oacute; vẻ bối rối, rồi cậu ta n&oacute;i: &ldquo;&Ocirc;ng n&oacute;i thật &agrave;?&rdquo;</p>

<p style="text-align:justify">&ldquo;Ừ&rdquo;, t&ocirc;i đ&aacute;p.</p>

<p style="text-align:justify">&ldquo;Trời đất!&rdquo; Cậu ta reo l&ecirc;n, kh&ocirc;ng thể tin l&agrave; t&ocirc;i cho cậu ấy tận 5 đ&ocirc;-la.</p>

<p style="text-align:justify">Phản ứng của cậu trước 5 đ&ocirc;-la t&ocirc;i cho thật đ&aacute;ng ngạc nhi&ecirc;n.</p>

<p style="text-align:justify">Sự h&agrave;o ph&oacute;ng của bạn đem lại niềm vui v&agrave; hạnh ph&uacute;c cho người kh&aacute;c, khi bạn cho đi một c&aacute;ch thật l&ograve;ng bạn sẽ nhận lại một điều g&igrave; đ&oacute;. H&agrave;o ph&oacute;ng kh&ocirc;ng c&oacute; nghĩa l&agrave; cho ai đ&oacute; về mặt vật chất m&agrave; c&ograve;n c&oacute; sự h&agrave;o ph&oacute;ng về mặt tinh thần bao gồm những lời n&oacute;i, h&agrave;nh động xuất ph&aacute;t từ tấm l&ograve;ng. D&ugrave; bạn kh&ocirc;ng gi&agrave;u c&oacute; về mặt tiền bạc, bạn vẫn gi&agrave;u c&oacute; về t&acirc;m hồn. Đ&oacute; l&agrave; c&aacute;ch người gi&agrave;u đem lại cho m&igrave;nh niềm vui v&agrave; hạnh ph&uacute;c bằng c&aacute;ch mở rộng l&ograve;ng m&igrave;nh, mở rộng t&igrave;nh y&ecirc;u thương với người kh&aacute;c. H&atilde;y tin v&agrave;o luật nh&acirc;n quả, bạn cho đi v&agrave; bạn sẽ được nhận lại.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">8. Người gi&agrave;u c&oacute; nhiều nguồn thu nhập, người ngh&egrave;o chỉ c&oacute; một</span></strong></p>

<p style="text-align:justify">Nguồn thu nhập ch&iacute;nh của bạn l&agrave; lương. Tất nhi&ecirc;n ai cũng c&oacute; một c&ocirc;ng việc ch&iacute;nh v&agrave; mong chờ v&agrave;o đồng lương ch&iacute;nh n&agrave;y. Thực tế trong cuộc sống của mỗi người, thu nhập v&agrave; chi ti&ecirc;u l&agrave; hai th&aacute;i cực tr&aacute;i ngược nhau. Bạn biết đấy nhu cầu sống của con người l&agrave; v&ocirc; hạn trong khi thu nhập của bạn lại c&oacute; hạn. Bạn sẽ lựa chọn một nguồn thu nhập hay nhiều nguồn thu nhập cho khoản chi ti&ecirc;u kh&ocirc;ng giới hạn của bạn. Ng&agrave;y nay, một c&ocirc;ng việc cho một nguồn thu nhập ch&iacute;nh l&agrave; kh&ocirc;ng đủ đ&aacute;p ứng nhu cầu trong khi vật gi&aacute; ng&agrave;y c&agrave;ng tăng cao. Ch&iacute;nh v&igrave; thế người gi&agrave;u t&igrave;m cho m&igrave;nh những những nguồn thu nhập kh&aacute;c nhau.</p>

<p style="text-align:justify">Người gi&agrave;u biết x&acirc;y dựng một đội ngũ c&ugrave;ng nhau tạo ra c&aacute;c nguồn thu nhập thụ động. Nghĩa l&agrave; kh&ocirc;ng cần bỏ ra nhiều c&ocirc;ng sức vẫn thu được tiền. L&agrave;m việc ăn &yacute; với một nh&oacute;m sẽ tạo ra niềm tin. Mối quan hệ hợp t&aacute;c dựa tr&ecirc;n sự khen ngợi v&agrave; t&ocirc;n trọng lẫn nhau. Từ đ&oacute; h&igrave;nh th&agrave;nh nhiều &yacute; tưởng v&agrave; th&agrave;nh quả c&ocirc;ng việc l&agrave; kh&ocirc;ng giới hạn. Một b&iacute; mật tối cao nữa của người gi&agrave;u l&agrave; &ldquo;sự h&agrave;i h&ograve;a hữu &yacute;&rdquo; nghĩa l&agrave; sự kết nối. Người ngh&egrave;o l&agrave;m c&ugrave;ng một l&uacute;c hai việc nhưng họ kh&ocirc;ng kết nối c&ocirc;ng việc thứ hai với c&ocirc;ng việc thứ nhất. Người gi&agrave;u khiến cho mỗi nguồn thu nhập thụ động trợ gi&uacute;p nhau.</p>

<p style="text-align:justify">&ldquo;Thu nhập thụ động, c&aacute;c nh&oacute;m l&agrave;m việc v&agrave; sự h&agrave;i h&ograve;a hữu &yacute; l&agrave; mối quan hệ ba chiều kh&ocirc;ng dễ g&igrave; bị ph&aacute; vỡ. Ch&uacute;ng gi&uacute;p bạn x&acirc;y dựng một cuộc sống t&agrave;i ch&iacute;nh vững mạnh.&rdquo;</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">9. Người gi&agrave;u nỗ lực để tăng lợi nhuận, người ngh&egrave;o cặm cụi cố tăng lương</span></strong></p>

<p style="text-align:justify">&ldquo;Người gi&agrave;u biết sai khiến đồng tiền l&agrave;m việc cật lực cho họ. C&ograve;n người ngh&egrave;o l&agrave;m việc cật lực v&igrave; đồng tiền.&rdquo;</p>

<p style="text-align:justify">Bạn chăm chỉ l&agrave;m việc. Chưa chắc bạn đ&atilde; kiếm được nhiều tiền. Khi bạn kiếm được nhiều tiền v&igrave; l&agrave;m việc chăm chỉ. Chưa chắc đ&oacute; l&agrave; đồng tiền lớn nhất m&agrave; bạn c&oacute; thể nhận được. Đ&oacute; l&agrave; c&aacute;ch l&agrave;m việc của người ngh&egrave;o chỉ v&igrave; họ l&agrave;m việc chăm chỉ, hay n&oacute;i ch&iacute;nh x&aacute;c hơn họ bị đồng tiền sai khiến.</p>

<p style="text-align:justify">Bạn tập trung l&agrave;m việc v&igrave; muốn tạo ra lợi nhuận. Đ&oacute; l&agrave; c&aacute;ch l&agrave;m th&ocirc;ng minh v&igrave; khi lợi nhuận đạt đến một mức độ n&agrave;o đ&oacute;, bạn sẽ được tự do l&agrave;m những g&igrave; bạn th&iacute;ch.</p>

<p style="text-align:justify">L&agrave;m thế n&agrave;o để tạo ra lợi nhuận? Cuốn s&aacute;ch n&agrave;y kh&ocirc;ng hướng dẫn cho bạn từng bước tạo ra lợi nhuận nhưng n&oacute; gợi &yacute; cho bạn c&aacute;ch để tạo ra lợi nhuận:</p>

<p style="text-align:justify">&ndash; H&atilde;y biến lương th&agrave;nh thu nhập thụ động.</p>

<p style="text-align:justify">&ndash; H&atilde;y g&acirc;y dựng một doanh nghiệp nhỏ.</p>

<p style="text-align:justify">&ndash; Đầu tư v&agrave;o chứng kho&aacute;n, bất động sản.</p>

<p style="text-align:justify"><strong><span style="background-color:#f1c40f">10. Người gi&agrave;u tư duy t&iacute;ch cực, người ngh&egrave;o sống bi quan</span></strong></p>

<p style="text-align:justify">Người ngh&egrave;o sống bi quan về tư duy. Nghĩa l&agrave; bạn sẽ kh&ocirc;ng c&oacute; c&acirc;u trả lời cho một vấn đề n&agrave;o đ&oacute; m&agrave; bạn thắc mắc khi m&agrave; bạn kh&ocirc;ng hỏi v&agrave; thường l&agrave; bạn sẽ cho qua. Tr&ecirc;n thực tế, học sinh, sinh vi&ecirc;n Việt Nam &iacute;t hỏi v&agrave; kh&ocirc;ng d&aacute;m hỏi thầy c&ocirc; của m&igrave;nh. Kh&ocirc;ng phải c&aacute;c bạn đều sợ đặt c&acirc;u hỏi m&agrave; hầu hết c&aacute;c bạn kh&ocirc;ng c&oacute; th&oacute;i quen tư duy, đặt c&acirc;u hỏi cho những người c&oacute; kinh nghiệm trả lời.</p>

<p style="text-align:justify">Người gi&agrave;u tạo cho m&igrave;nh th&oacute;i quen tư duy t&iacute;ch cực bằng c&aacute;ch đặt c&acirc;u hỏi. Ch&iacute;nh v&igrave; thế m&agrave; cuộc sống của họ lu&ocirc;n mang &yacute; nghĩa v&agrave; điều đ&oacute; gi&uacute;p họ th&agrave;nh c&ocirc;ng trong cuộc sống. H&atilde;y học c&aacute;ch đặt c&acirc;u hỏi t&iacute;ch cực, đặt những c&acirc;u hỏi vượt ngo&agrave;i tầm hiểu biết v&agrave; kinh nghiệm của m&igrave;nh.</p>

<p style="text-align:justify">Ch&iacute;n c&acirc;u hỏi t&iacute;ch cực của t&aacute;c giả d&agrave;nh cho mọi người. Lưu &yacute;: H&atilde;y trả lời ch&uacute;ng một c&aacute;ch trung thực nhất c&oacute; thể:</p>

<p style="text-align:justify">&bull; T&ocirc;i muốn trở th&agrave;nh mẫu người như thế n&agrave;o?</p>

<p style="text-align:justify">&bull; Tại sao t&ocirc;i muốn trở th&agrave;nh mẫu người đ&oacute;?</p>

<p style="text-align:justify">&bull; T&ocirc;i phải l&agrave;m g&igrave; để trở th&agrave;nh mẫu người đ&oacute;?</p>

<p style="text-align:justify">&bull; T&ocirc;i muốn l&agrave;m g&igrave;?</p>

<p style="text-align:justify">&bull; Tại sao t&ocirc;i lại muốn l&agrave;m việc đ&oacute;?</p>

<p style="text-align:justify">&bull; T&ocirc;i l&agrave;m việc đ&oacute; bằng c&aacute;ch n&agrave;o?</p>

<p style="text-align:justify">&bull; T&ocirc;i muốn c&oacute; c&aacute;i g&igrave;?</p>

<p style="text-align:justify">&bull; Tại sao t&ocirc;i lại muốn c&oacute; n&oacute;?</p>

<p style="text-align:justify">&bull; T&ocirc;i tạo ra n&oacute; bằng c&aacute;ch n&agrave;o?</p>

<p style="text-align:justify">Bạn c&oacute; thấy m&igrave;nh đ&atilde; nghiệm ra được điều g&igrave; sau khi trả lời những c&acirc;u hỏi n&agrave;y kh&ocirc;ng? Lu&ocirc;n nhớ rằng c&acirc;u hỏi được đặt ra kh&ocirc;ng bao giờ l&agrave; v&ocirc; &iacute;ch cả. Những c&acirc;u hỏi gi&uacute;p bạn ph&aacute;t hiện ra bản th&acirc;n muốn trở th&agrave;nh người như thế n&agrave;o, muốn l&agrave;m g&igrave; v&agrave; muốn c&oacute; c&aacute;i g&igrave;. C&aacute;i bạn mong muốn v&agrave; c&aacute;i bạn l&agrave;m được phải xuất ph&aacute;t từ ch&iacute;nh bản th&acirc;n bạn. C&oacute; thế những việc m&agrave; bạn l&agrave;m mới l&agrave; những điều &yacute; nghĩa nhất trong cuộc đời của ch&iacute;nh bạn.</p>

<p style="text-align:justify">&ldquo;&Yacute; nghĩa cuộc đời ch&uacute;ng ta kh&ocirc;ng phải MUỐN ĐƯỢC th&agrave;nh c&ocirc;ng</p>

<p style="text-align:justify">m&agrave; l&agrave; TRỞ N&Ecirc;N th&agrave;nh c&ocirc;ng.&rdquo;</p>

<p style="text-align:justify"><span style="color:#ffffff"><strong><span style="background-color:#d35400">Kết luận</span></strong></span></p>

<p style="text-align:justify">Với ng&ocirc;n từ ngắn gọn, s&uacute;c t&iacute;ch, kh&ocirc;ng qu&aacute; trau chuốt, kh&ocirc;ng d&agrave;i d&ograve;ng, nội dung ch&acirc;n thực v&agrave; bổ &iacute;ch l&agrave; những g&igrave; t&ocirc;i cảm nhận được sau khi đọc quyển s&aacute;ch n&agrave;y. &ldquo;10 điều kh&aacute;c biệt nhất giữa kẻ gi&agrave;u v&agrave; người ngh&egrave;o&rdquo; kh&ocirc;ng chỉ l&agrave; sự so s&aacute;nh ch&acirc;n thực nhất về kẻ gi&agrave;u v&agrave; người ngh&egrave;o m&agrave; c&ograve;n l&agrave; những c&acirc;u chuyện đời thực, những b&agrave;i học bổ &iacute;ch, những lời khuy&ecirc;n ch&acirc;n th&agrave;nh của t&aacute;c giả đến với độc giả. D&ugrave; bạn c&oacute; l&agrave; người lười đọc đến mấy nhưng một khi bạn quan t&acirc;m đến chủ đề n&agrave;y, cuốn s&aacute;ch sẽ gi&uacute;p bạn với những lời khuy&ecirc;n ngắn gọn nhất v&agrave; s&acirc;u sắc nhất. Bạn sẽ dễ d&agrave;ng cảm nhận được những th&ocirc;ng điệp đầy &yacute; nghĩa của t&aacute;c giả th&ocirc;ng qua cuốn s&aacute;ch n&agrave;y. Qu&aacute; tr&igrave;nh tiến đến sự gi&agrave;u c&oacute; của bạn sẽ r&uacute;t ngắn đi l&agrave; nhờ v&agrave;o sự hữu &iacute;ch của việc đọc s&aacute;ch v&agrave; việc sau đ&oacute; l&agrave; r&egrave;n luyện mỗi ng&agrave;y những điều học được từ s&aacute;ch.</p>
', CAST(N'2021-12-19T17:04:16.000' AS DateTime), 1, CAST(N'2021-12-12T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (14, N'Giải Mã Dục Vọng', N'giai_ma_duc_vong', NULL, N'giai-ma-duc-vong.jpg', NULL, N'Pamela Druckerman', CAST(221000 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)), 1786, 2, N'<p>Tr&ecirc;n tay bạn l&agrave; cuốn s&aacute;ch lột tả nhiều kh&iacute;a cạnh về vấn đề ngoại t&igrave;nh. Nếu bạn l&agrave; người Mỹ v&agrave; kh&ocirc;ng muốn lật tiếp trang kế th&igrave; cũng dễ hiểu th&ocirc;i. V&igrave; theo thống k&ecirc; của t&ocirc;i,&nbsp; chuyện ngoại t&igrave;nh tại Mỹ&nbsp; dễ g&acirc;y&nbsp; phản ứng bực bội mạnh mẽ nhất so với c&aacute;c nước kh&aacute;c (trừ Ireland v&agrave; Philippines). Khi t&ocirc;i đề cập đến chuyện lăng nhăng của người Mỹ, họ thường nh&igrave;n chằm chằm t&ocirc;i một l&uacute;c l&acirc;u, dường như đang t&igrave;m hiểu xem họ c&oacute; đang mắc tội g&igrave; hay t&ocirc;i c&oacute; đang gạ gẫm họ l&ecirc;n giường kh&ocirc;ng vậy. Một v&agrave;i người sẽ hu&ecirc;nh&nbsp; hoang về tầm quan trọng của chế độ một vợ một chồng. C&ograve;n một số sẽ tự động&nbsp; ngấp&nbsp; ngh&eacute; phun&nbsp; ra những b&iacute; mật về chuyện ngoại t&igrave;nh của họ.</p>
', CAST(N'2021-12-19T17:15:22.383' AS DateTime), 1, CAST(N'2022-02-22T00:00:00.000' AS DateTime), 29)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (15, N'Sức Mạnh Của Người Hướng Nội', N'suc_manh_cua_nguoi_huong_noi', N'<p>Xin ch&agrave;o, t&ocirc;i l&agrave; Nguyễn Tiến Đạt. Bản dịch m&agrave; bạn đang đọc l&agrave; dự &aacute;n c&aacute; nh&acirc;n lớn đầu ti&ecirc;n sau năm 20 tuổi của t&ocirc;i. C&aacute;m ơn bạn v&igrave; đ&atilde; đọc, hoặc thậm ch&iacute; dẫu c&oacute; thể chỉ l&agrave; đang c&acirc;n nhắc đến việc sẽ đọc n&oacute;.</p>

<p style="text-align:right"><strong><em>Người dịch</em></strong></p>
', N'quiet-suc-manh-cua-nguoi-huong-noi.jpg', NULL, N'Susan Cain', CAST(90000 AS Decimal(18, 0)), NULL, 747, 2, N'<p style="text-align:justify"><em><strong>Review by Nguyễn Tiến Đạt</strong></em></p>

<p style="text-align:justify">T&ocirc;i c&oacute; may mắn được biết đến cuốn s&aacute;ch n&agrave;y từ kh&aacute; sớm, v&agrave;o cuối m&ugrave;a h&egrave; năm 2012, kh&ocirc;ng l&acirc;u sau thời điểm n&oacute; được ra mắt tại Mỹ. V&agrave; t&ocirc;i đ&atilde; lập tức bị h&uacute;t v&agrave;o n&oacute;. Đ&ocirc;i l&uacute;c trong đời bạn, sẽ c&oacute; những cuốn s&aacute;ch xuất hiện v&agrave; t&aacute;c động rất mạnh đến c&aacute;ch nh&igrave;n cuộc sống của bạn, cấy v&agrave;o trong đầu bạn một &yacute; tưởng, cho bạn một lăng k&iacute;nh ho&agrave;n to&agrave;n mới để nh&igrave;n nhận cuộc sống v&agrave; để nh&igrave;n nhận ch&iacute;nh bản th&acirc;n bạn. &ldquo;Quiet&rdquo; của Susan Cain đối với t&ocirc;i l&agrave; một cuốn s&aacute;ch như vậy. V&agrave; t&ocirc;i kh&ocirc;ng hề hối hận về việc m&igrave;nh đ&atilde; bỏ ra hơn 6 th&aacute;ng trời để dịch n&oacute;. N&oacute; đ&atilde; gi&uacute;p thay đổi cuộc sống của t&ocirc;i theo hướng tốt đẹp hơn nhiều, đến mức t&ocirc;i nhận ra việc những người kh&aacute;c cũng được đọc n&oacute; sẽ c&oacute; &yacute; nghĩa lớn đến thế n&agrave;o. V&agrave; t&ocirc;i nhảy v&agrave;o l&agrave;m, mặc d&ugrave; kh&ocirc;ng phải t&ocirc;i kh&ocirc;ng nhận được những lời khuy&ecirc;n kh&ocirc;ng n&ecirc;n. Một người anh t&ocirc;i rất k&iacute;nh trọng cũng đ&atilde; khuy&ecirc;n t&ocirc;i như vậy. Nhưng t&ocirc;i c&ograve;n trẻ, t&ocirc;i nghĩ m&igrave;nh c&oacute; quyền phạm sai lầm v&agrave; c&oacute; quyền l&agrave;m một thứ g&igrave; đ&oacute; đi&ecirc;n rồ một ch&uacute;t khi t&ocirc;i c&ograve;n đủ thời gian v&agrave; nhiệt huyết. Vậy n&ecirc;n t&ocirc;i l&agrave;m.</p>

<p style="text-align:justify">Cuốn s&aacute;ch n&agrave;y l&agrave; một dự &aacute;n c&aacute; nh&acirc;n của t&ocirc;i. T&ocirc;i nghĩ m&igrave;nh cần giải th&iacute;ch một ch&uacute;t cụm từ &ldquo;dự &aacute;n c&aacute; nh&acirc;n&rdquo;. Thứ nhất, n&oacute; c&oacute; nghĩa l&agrave;: Cuốn s&aacute;ch n&agrave;y l&agrave; của t&ocirc;i. Từ chữ c&aacute;i đầu ti&ecirc;n đến c&aacute;i dấu chấm cuối c&ugrave;ng, từ c&aacute;ch dịch, c&aacute;ch chọn từ, đến c&aacute;ch l&agrave;m ch&uacute; th&iacute;ch; từ c&aacute;ch tr&igrave;nh b&agrave;y b&igrave;a, đến m&agrave;u b&igrave;a, thậm ch&iacute; l&agrave; việc thiết kế b&igrave;a. Tất cả những thao t&aacute;c bạn c&oacute; thể nghĩ ra để c&oacute; thể l&agrave;m ra được bản dịch n&agrave;y, t&ocirc;i đ&atilde; tự tay l&agrave;m một m&igrave;nh ho&agrave;n to&agrave;n. Tất nhi&ecirc;n, việc dịch của t&ocirc;i đứng tr&ecirc;n đ&ocirc;i vai của rất nhiều kiến thức dịch v&agrave; ng&ocirc;n ngữ dịch của bao dịch giả t&ocirc;i đ&atilde; từng được đọc, được theo học, v&agrave; t&ocirc;i cũng đ&atilde; cầu viện đến sự trợ gi&uacute;p của rất nhiều c&aacute;c từ điển v&agrave; c&aacute;c nguồn th&ocirc;ng tin tham khảo kh&aacute;c nhau từ mạng Internet, nhưng người l&agrave;m nhiệm vụ sử dụng tất cả những thứ nguy&ecirc;n liệu nguồn đ&oacute; để tạo ra những d&ograve;ng văn bản n&agrave;y l&agrave; t&ocirc;i, v&agrave; chỉ m&igrave;nh t&ocirc;i. T&ocirc;i ch&iacute;nh l&agrave; người chịu tr&aacute;ch nhiệm, l&agrave; người bạn sẽ muốn nhắm đến để khen ngợi, hoặc để n&eacute;m đ&aacute;. Thứ hai, n&oacute; c&oacute; nghĩa l&agrave;: Dự &aacute;n n&agrave;y c&oacute; &yacute; nghĩa đặc biệt quan trọng với ri&ecirc;ng c&aacute; nh&acirc;n t&ocirc;i. Với t&ocirc;i, việc phải đưa được những kiến thức trong cuốn s&aacute;ch n&agrave;y đến với nhiều người hơn nữa gần như l&agrave; một sứ mệnh t&ocirc;i tự giao cho m&igrave;nh, n&oacute; l&agrave; một mục đ&iacute;ch t&ocirc;i ho&agrave;n to&agrave;n tin tưởng v&agrave;o, v&agrave; n&oacute; đ&atilde; l&agrave; động lực th&uacute;c đẩy t&ocirc;i theo đuổi c&ocirc;ng việc n&agrave;y trong suốt qu&atilde;ng thời gian hơn 6 th&aacute;ng vừa qua. T&ocirc;i kh&ocirc;ng dịch cuốn s&aacute;ch n&agrave;y v&igrave; muốn n&oacute; được một nh&agrave; xuất bản n&agrave;o để &yacute; đến v&agrave; trả t&ocirc;i tiền để mua</p>

<p style="text-align:justify">n&oacute;; t&ocirc;i kh&ocirc;ng l&agrave;m n&oacute; để in ra v&agrave; b&aacute;n cho bất kỳ ai; v&agrave; t&ocirc;i cũng kh&ocirc;ng l&agrave;m n&oacute; để thể hiện g&igrave; tr&igrave;nh độ của m&igrave;nh cả. Bạn c&oacute; thể chọn tin lời t&ocirc;i hoặc kh&ocirc;ng, t&ocirc;i kh&ocirc;ng quan t&acirc;m, nhưng điều t&ocirc;i muốn n&oacute;i l&agrave;: t&ocirc;i chọn l&agrave;m n&oacute;, v&igrave; t&ocirc;i muốn bạn đọc n&oacute;.</p>

<p style="text-align:justify">T&ocirc;i biết việc chỉ hết sức khen ngợi cuốn s&aacute;ch n&agrave;y trong một d&ograve;ng &ldquo;trạng th&aacute;i&rdquo; vu vơ n&agrave;o đ&oacute; tr&ecirc;n mạng x&atilde; hội, hay li&ecirc;n tục bỏ bom trang mạng c&aacute; nh&acirc;n của bạn với những b&igrave;nh luận kiểu &ldquo;h&atilde;y đọc n&oacute; đi, n&oacute; hay lắm&hellip;&rdquo; l&agrave; kh&ocirc;ng đủ. D&ugrave; cho tr&igrave;nh độ tiếng Anh của bạn c&oacute; đủ tốt để biết được cuốn s&aacute;ch viết g&igrave;, r&agrave;o cản ng&ocirc;n ngữ vẫn sẽ l&agrave; một nh&acirc;n tố cản trở (d&ugrave; c&oacute; thể chỉ l&agrave; rất nhỏ). V&agrave; d&ugrave; nh&acirc;n tố cản trở đ&oacute; c&oacute; thể rất nhỏ, nhưng nh&acirc;n n&oacute; l&ecirc;n với dung lượng của cuốn s&aacute;ch n&agrave;y (bản điện tử m&agrave; t&ocirc;i c&oacute; l&agrave; một bản PDF chữ nhỏ li ti m&agrave; cũng đ&atilde; 139 trang); c&ugrave;ng với chủ đề c&oacute; vẻ thiếu hấp dẫn của n&oacute; (&ldquo;t&acirc;m l&yacute; học&rdquo;, &ldquo;t&iacute;nh c&aacute;ch&rdquo;, &ldquo;người hướng nội&rdquo;); lại nữa, h&atilde;y nghĩ đến cả thể loại của n&oacute; (&ldquo;non-fiction&rdquo; v&agrave; &ldquo;self-help&rdquo;) vốn l&agrave; thứ t&ocirc;i kh&ocirc;ng nghĩ được số đ&ocirc;ng trong c&aacute;c bạn ưa th&iacute;ch. H&atilde;y th&agrave;nh thực m&agrave; n&oacute;i đi, bạn thử nghĩ đến những thứ n&agrave;y m&agrave; xem, nếu n&oacute; kh&ocirc;ng phải l&agrave; một t&agrave;i liệu học tập bắt buộc hoặc một cuốn s&aacute;ch nghi&ecirc;n cứu buộc-phải-c&oacute; kinh điển cần thiết cho c&ocirc;ng việc, bao nhi&ecirc;u trong số c&aacute;c bạn sẽ bị hấp dẫn đến với một cuốn s&aacute;ch với dung lượng, chủ đề v&agrave; thể loại như thế? T&ocirc;i nghĩ l&agrave; kh&ocirc;ng nhiều. T&ocirc;i cũng phải th&uacute; thật l&agrave; kể cả t&ocirc;i c&oacute; lẽ cũng sẽ kh&ocirc;ng t&igrave;m đến với một thứ như thế đ&acirc;u, nếu t&ocirc;i đ&atilde; được biết đến n&oacute; theo c&aacute;ch n&agrave;y.</p>

<p style="text-align:justify">Nhưng t&ocirc;i biết đ&acirc;y l&agrave; một cuốn s&aacute;ch rất đ&aacute;ng đọc. V&agrave; T&Ocirc;I MUỐN C&Aacute;C BẠN ĐỌC N&Oacute;. Th&agrave;nh thực m&agrave; n&oacute;i, bạn c&oacute; thể d&ugrave;ng việc n&agrave;y để đ&aacute;nh gi&aacute; t&ocirc;i đấy. T&ocirc;i đang l&agrave;m c&aacute;i việc mạo hiểm l&agrave; đem uy t&iacute;n của m&igrave;nh ra để đảm bảo cho cuốn s&aacute;ch n&agrave;y. Nếu bạn đọc thử v&agrave; kh&ocirc;ng thấy n&oacute; đ&aacute;ng đọc như lời t&ocirc;i t&acirc;ng bốc, vậy th&igrave; t&ocirc;i coi như mất sạch sẽ uy t&iacute;n với bạn nhỉ. Từ nay về sau mọi lời t&ocirc;i n&oacute;i sẽ kh&ocirc;ng c&ograve;n mấy sức nặng với bạn nữa. Nhưng kể cả khi biết điều đ&oacute;, t&ocirc;i vẫn tin chắc v&agrave; vẫn sẽ n&oacute;i cho bạn biết, rằng: T&Ocirc;I TIN Đ&Acirc;Y L&Agrave; MỘT CUỐN S&Aacute;CH Đ&Aacute;NG ĐỌC.</p>

<p style="text-align:justify">Việc dịch cuốn s&aacute;ch n&agrave;y l&agrave; cố gắng của t&ocirc;i để đạp đổ r&agrave;o cản ng&ocirc;n ngữ. Việc t&ocirc;i sử dụng trang c&aacute; nh&acirc;n của m&igrave;nh v&agrave; đăng tải những đoạn tr&iacute;ch t&ocirc;i thấy hay trong cuốn s&aacute;ch n&agrave;y l&agrave; những nỗ lực nhỏ của t&ocirc;i để thu h&uacute;t sự quan t&acirc;m của mọi người tới với chủ đề của cuốn s&aacute;ch. V&agrave; bằng việc thực sự trở n&ecirc;n tự tin hơn, sống tốt hơn, thể hiện ra qua cuộc sống thực ngo&agrave;i đời v&agrave; qua những g&igrave; t&ocirc;i giao tiếp với mọi người xung quanh cả tr&ecirc;n mạng lẫn trong đời thực, bất chấp việc l&agrave; một người hướng nội nh&uacute;t nh&aacute;t, t&ocirc;i hy vọng rằng m&igrave;nh đ&atilde; c&oacute; thể chứng minh cho c&aacute;c bạn&mdash;những ai biết t&ocirc;i&mdash;thấy rằng cuốn s&aacute;ch n&agrave;y, d&ugrave; l&agrave; s&aacute;ch self-help, d&ugrave; l&agrave; s&aacute;ch non-fiction, nhưng n&oacute; vẫn thực sự đ&aacute;ng gi&aacute;, v&igrave; n&oacute;</p>

<p style="text-align:justify">c&oacute; thể l&agrave;m thay đổi cuộc sống của bạn theo những nghĩa tốt hơn. T&ocirc;i l&agrave; một bằng chứng cho điều đ&oacute;.</p>

<p style="text-align:justify">BẢN DỊCH N&Agrave;Y KH&Ocirc;NG HỀ HO&Agrave;N HẢO. Bạn cần phải biết điều đ&oacute;. V&agrave; bạn cũng cần phải biết rằng t&ocirc;i biết điều đ&oacute;. N&oacute; chi ch&iacute;t lỗi. Lỗi về c&aacute;ch d&ugrave;ng từ tiếng Việt. Lỗi về ng&ocirc;n ngữ dịch. Lỗi cả về thao t&aacute;c tham khảo nguồn để l&agrave;m ch&uacute; th&iacute;ch. Lỗi cả trong những kh&acirc;u chế bản điện tử, tạo file PDF, lỗi trong việc thiết kế b&igrave;a, chọn m&agrave;u b&igrave;a. Lỗi trong cả c&aacute;ch chọn dịch ti&ecirc;u đề. Chi ch&iacute;t lỗi. Nhưng t&ocirc;i hy vọng rằng ch&uacute;ng sẽ kh&ocirc;ng l&agrave;m phiền bạn qu&aacute; nhiều trong qu&aacute; tr&igrave;nh đọc, v&agrave;, quan trọng hơn, kh&ocirc;ng l&agrave;m ảnh hưởng đến việc tiếp nhận những &yacute; tưởng từ cuốn s&aacute;ch n&agrave;y của bạn. T&ocirc;i chỉ mong bản dịch n&agrave;y của m&igrave;nh c&oacute; thể gi&uacute;p cho việc đọc của bạn trở n&ecirc;n dễ d&agrave;ng hơn, v&agrave; do đ&oacute;, bạn sẽ đỡ vất vả hơn trong việc ho&agrave;n tất việc đọc cuốn s&aacute;ch n&agrave;y, chứ t&ocirc;i thực sự kh&ocirc;ng d&aacute;m mong n&oacute; trở th&agrave;nh một bản dịch ho&agrave;n hảo, c&oacute; thể khiến t&ecirc;n tuổi t&ocirc;i nổi như cồn v&agrave; được khen ngợi tới tấp. Kh&ocirc;ng, kh&ocirc;ng đ&acirc;u ạ. CHẮC CHẮN BẠN SẼ THẤY BẢN DỊCH N&Agrave;Y CHI CH&Iacute;T LỖI. Nhưng</p>

<p style="text-align:justify">t&ocirc;i vẫn hy vọng bạn sẽ thấy th&iacute;ch th&uacute; khi đọc n&oacute;, t&ocirc;i n&oacute;i điều n&agrave;y ra một c&aacute;ch ho&agrave;n to&agrave;n ch&acirc;n th&agrave;nh.</p>

<p style="text-align:justify">Hy vọng đến đ&acirc;y, c&oacute; lẽ bạn đ&atilde; c&oacute; c&acirc;u trả lời của t&ocirc;i cho hai c&acirc;u hỏi lớn m&agrave; c&oacute; thể bạn đang muốn hỏi t&ocirc;i: &ldquo;Cuốn s&aacute;ch n&agrave;y c&oacute; đ&aacute;ng đọc kh&ocirc;ng, tại sao?&rdquo; v&agrave; &ldquo;Sao bạn lại muốn bỏ c&ocirc;ng sức ra thực hiện việc dịch n&oacute;?&rdquo;. Sau đ&acirc;y, t&ocirc;i xin d&agrave;nh mấy lời cuối c&ugrave;ng n&agrave;y để trả lời nốt mấy c&acirc;u hỏi m&agrave; từ mấy h&ocirc;m nay t&ocirc;i đ&atilde; nhận được, kể từ khi t&ocirc;i c&ocirc;ng bố tr&ecirc;n trang c&aacute; nh&acirc;n rằng &ldquo;dự &aacute;n c&aacute; nh&acirc;n lớn nhất sau năm 20 tuổi&rdquo; của t&ocirc;i đ&atilde; ch&iacute;nh thức kết th&uacute;c:</p>

<p style="text-align:justify">&frac34; Tại sao t&ocirc;i kh&ocirc;ng gửi s&aacute;ch cho nh&agrave; xuất bản, m&agrave; lại chịu tải c&ocirc;ng sức dịch của m&igrave;nh l&ecirc;n mạng một c&aacute;ch miễn ph&iacute; thế n&agrave;y? T&ocirc;i c&oacute; sợ vi phạm luật bản quyền g&igrave; đ&oacute; kh&ocirc;ng?</p>

<p style="text-align:justify">T&ocirc;i kh&ocirc;ng thể, kh&ocirc;ng d&aacute;m v&agrave; cũng kh&ocirc;ng biết c&aacute;ch để gửi bản dịch cho nh&agrave; xuất bản, nếu bạn muốn tin t&ocirc;i. T&ocirc;i kh&ocirc;ng thể chịu được những lời ph&ecirc; b&igrave;nh, bất kể ch&uacute;ng c&oacute; t&iacute;ch cực v&agrave; x&aacute;c đ&aacute;ng thế n&agrave;o, v&agrave; một khi đ&atilde; l&agrave; một dịch giả xuất bản, người đ&ograve;i hỏi c&aacute;c bạn đọc trả tiền cho t&ocirc;i để được đọc thứ t&ocirc;i dịch, t&ocirc;i sẽ phải chịu một tr&aacute;ch nhiệm qu&aacute; lớn cho bản dịch của m&igrave;nh. C&aacute;c bạn sẽ c&oacute; quyền ph&ecirc; b&igrave;nh t&ocirc;i. Nhưng t&ocirc;i cực kỳ gh&eacute;t bị ph&ecirc; b&igrave;nh, d&ugrave; tr&ecirc;n bất cứ phương diện g&igrave;, d&ugrave; n&oacute; c&oacute; nhẹ nh&agrave;ng v&agrave; x&aacute;c đ&aacute;ng đến thế n&agrave;o đi nữa. Hơn nữa, tự t&ocirc;i biết tr&igrave;nh độ của m&igrave;nh qu&aacute; thấp. T&ocirc;i biết chắc rằng c&oacute; đầy lỗi về c&aacute;ch d&ugrave;ng từ v&agrave; lỗi về c&aacute;ch viết trong bản dịch n&agrave;y, v&agrave; t&ocirc;i lại l&agrave; một người theo chủ nghĩa ho&agrave;n hảo nữa, n&ecirc;n t&ocirc;i kh&ocirc;ng thể b&aacute;n một sản phẩm m&agrave; t&ocirc;i biết kh&ocirc;ng đạt được chất lượng tốt nhất c&oacute; thể như vậy. Cuối c&ugrave;ng, t&ocirc;i kh&ocirc;ng</p>

<p style="text-align:justify">c&oacute; uy t&iacute;n, thiếu kinh nghiệm v&agrave; z&ecirc;-r&ocirc; quan hệ với bất cứ một nh&agrave; xuất bản n&agrave;o, v&agrave; t&ocirc;i cũng qu&aacute; nh&uacute;t nh&aacute;t rụt r&egrave; v&agrave; thiếu tự tin để c&oacute; thể d&aacute;m đem thứ m&igrave;nh dịch n&agrave;y ra trước bất cứ hội đồng thẩm định của bất cứ nh&agrave; xuất bản n&agrave;o. T&ocirc;i sợ sự đ&aacute;nh gi&aacute;. V&agrave; do vậy, t&ocirc;i đ&atilde; chọn kh&ocirc;ng t&igrave;m c&aacute;ch xuất bản ch&iacute;nh thống bản dịch n&agrave;y. H&atilde;y để cho ai đ&oacute; ph&ugrave; hợp hơn t&ocirc;i l&agrave;m thế khi n&agrave;o họ c&oacute; thể đi. T&ocirc;i chỉ cần bản dịch n&agrave;y đến với c&aacute;c bạn được l&agrave; được rồi, dẫu chỉ l&agrave; qua Internet th&ocirc;i cũng kh&ocirc;ng sao. Một ng&agrave;y n&agrave;o đấy, sẽ c&oacute; một cuốn s&aacute;ch với t&ecirc;n Nguyễn Tiến Đạt, hoặc với tư c&aacute;ch l&agrave; dịch giả, hoặc (v&agrave; t&ocirc;i mong l&agrave;) với tư c&aacute;ch một t&aacute;c giả. C&ograve;n h&ocirc;m nay, mong c&aacute;c bạn h&atilde;y nhận lấy m&oacute;n qu&agrave; n&agrave;y của t&ocirc;i từ Internet.</p>

<p style="text-align:justify">Về vấn đề đọc v&agrave; tải s&aacute;ch bản quyền, bản th&acirc;n t&ocirc;i coi đ&acirc;y l&agrave; một vấn đề vẫn c&ograve;n chưa thực sự r&otilde; r&agrave;ng về mặt đạo đức. Liệu sao ch&eacute;p, ph&acirc;n phối hay tải s&aacute;ch hay bất cứ thứ g&igrave; từ tr&ecirc;n mạng về một c&aacute;ch miễn ph&iacute; c&oacute; được coi l&agrave; ăn cắp kh&ocirc;ng? T&ocirc;i kh&ocirc;ng tin v&agrave;o điều n&agrave;y, nhưng t&ocirc;i cũng kh&ocirc;ng khuyến kh&iacute;ch những h&agrave;nh vi bị coi l&agrave; vi phạm luật bản quyền. V&agrave; t&ocirc;i vẫn quyết định sẽ chia sẻ bản dịch n&agrave;y của m&igrave;nh, bởi theo chiếc la b&agrave;n đạo đức nội tại của t&ocirc;i, t&ocirc;i kh&ocirc;ng tin rằng việc m&igrave;nh đang l&agrave;m l&agrave; sai. V&agrave; t&ocirc;i cũng kh&ocirc;ng quan t&acirc;m liệu bạn c&oacute; ủng hộ t&ocirc;i trong vấn đề n&agrave;y hay kh&ocirc;ng. Ở đ&acirc;y, t&ocirc;i chỉ xin dừng lại để n&oacute;i rằng: t&ocirc;i đang l&agrave;m điều t&ocirc;i tin l&agrave; đ&uacute;ng đắn v&agrave; n&ecirc;n l&agrave;m, v&agrave; với t&ocirc;i, chỉ vậy l&agrave; đủ.</p>

<p style="text-align:justify">&frac34; Tại sao lại chọn thiết kế b&igrave;a như vậy? Tại sao lại chọn dịch ti&ecirc;u đề &ldquo;Quiet&rdquo; th&agrave;nh &ldquo;Im lặng&rdquo;?</p>

<p style="text-align:justify">B&igrave;a của &ldquo;Im lặng&rdquo; c&oacute; h&igrave;nh ảnh chủ đạo l&agrave; một trục phần tư m&ocirc; phỏng một hệ trục tọa độ. Đ&acirc;y l&agrave; t&ocirc;i thiết kế dựa v&agrave;o một &yacute; tưởng xuất hiện trong cuốn s&aacute;ch, đ&oacute; l&agrave;: &ldquo;một đồ thị với một trục đứng v&agrave; một trục nằm ngang, với trục ngang l&agrave; khoảng dao động giữa hai th&aacute;i cực hướng nội-hướng ngoại, v&agrave; trục đứng tương ứng với khoảng b&igrave;nh thản-lo lắng. Với m&ocirc; h&igrave;nh n&agrave;y, bạn c&oacute; được bốn ph&acirc;n loại kh&aacute;c nhau của t&iacute;nh c&aacute;ch con người, tương ứng với bốn g&oacute;c phần tư của đồ thị: người hướng ngoại b&igrave;nh thản, người hướng ngoại lo lắng (hoặc bốc đồng), người hướng nội b&igrave;nh thản, v&agrave; người hướng nội lo lắng.</p>

<p style="text-align:justify">N&oacute;i một c&aacute;ch kh&aacute;c, bạn c&oacute; thể l&agrave; một người hướng ngoại nh&uacute;t nh&aacute;t như Barbra Streisand, người c&oacute; một t&iacute;nh c&aacute;ch hết sức đặc sắc v&agrave; thu h&uacute;t, nhưng vẫn sợ đến t&ecirc; liệt cả người đi mỗi khi phải bước l&ecirc;n s&acirc;n khấu; hoặc một người hướng nội kh&ocirc;ng-nh&uacute;t-nh&aacute;t, như Bill Gates, người m&agrave; về mọi phương diện đều tr&aacute;nh phải tiếp x&uacute;c với mọi người, nhưng chưa bao giờ phải lo lắng v&igrave; &aacute;p lực &yacute; kiến của người kh&aacute;c.&rdquo; Đ&acirc;y l&agrave; chi tiết t&acirc;m đắc đầu ti&ecirc;n t&ocirc;i bắt gặp trong cuốn s&aacute;ch khi lần đầu đọc n&oacute;, v&agrave; do đ&acirc;y l&agrave; một dự &aacute;n c&aacute; nh&acirc;n của ri&ecirc;ng t&ocirc;i, t&ocirc;i kh&ocirc;ng nghĩ m&igrave;nh c&oacute; g&igrave; phải ngại trong việc chọn một chi tiết m&igrave;nh</p>

<p style="text-align:justify">th&iacute;ch l&agrave;m cảm hứng để thiết kế b&igrave;a. N&oacute;i lu&ocirc;n, b&igrave;a m&agrave;u xanh l&aacute; c&acirc;y cũng chỉ đơn giản l&agrave; v&igrave; đ&acirc;y l&agrave; m&agrave;u sắc ưa th&iacute;ch nhất của t&ocirc;i m&agrave; th&ocirc;i. D&ugrave; sao cũng mong l&agrave; n&oacute; hợp mắt c&aacute;c bạn, nhưng dẫu n&oacute; (nhỡ) c&oacute; kh&ocirc;ng hợp mắt c&aacute;c bạn th&igrave; t&ocirc;i cũng đ&agrave;nh chịu; đ&acirc;y l&agrave; dự &aacute;n c&aacute; nh&acirc;n của t&ocirc;i, t&ocirc;i sẽ l&agrave;m n&oacute; theo những c&aacute;ch m&agrave; t&ocirc;i muốn, chứ kh&ocirc;ng phải l&agrave; theo &yacute; th&iacute;ch của bất kể ai kh&aacute;c.</p>

<p style="text-align:justify">Chữ &ldquo;Quiet&rdquo;, l&agrave; ti&ecirc;u đề ch&iacute;nh của bản gốc, đ&atilde; được t&ocirc;i chọn dịch l&agrave; &ldquo;Im lặng&rdquo;. T&ocirc;i c&oacute; l&yacute; do cho điều n&agrave;y. B&ecirc;n cạnh sự tương hợp đến một mức độ n&agrave;o đấy với n&eacute;t nghĩa m&agrave; t&ocirc;i hiểu của từ &ldquo;Quiet&rdquo; theo &yacute; d&ugrave;ng của t&aacute;c giả, t&ocirc;i cố t&igrave;nh chọn chữ &ldquo;Im lặng&rdquo;, với chữ &ldquo;I&rdquo; chủ &yacute; k&eacute;o d&agrave;i ra v&agrave; l&agrave;m lớn hơn hẳn c&aacute;c chữ c&ograve;n lại khi in tr&ecirc;n b&igrave;a, c&ograve;n l&agrave; v&igrave; t&ocirc;i muốn đặc biệt d&agrave;nh tặng cuốn s&aacute;ch n&agrave;y cho những người c&oacute; t&iacute;nh c&aacute;ch &ldquo;I&rdquo;, viết tắt của &ldquo;introverted&rdquo;&mdash; hướng nội, theo ph&acirc;n loại của b&agrave;i Trắc nghiệm t&iacute;nh c&aacute;ch Myers-Briggs (Myers-Briggs Type Indicator), thường được viết ngắn gọn l&agrave; MBTI. Chữ &ldquo;I&rdquo; lớn đ&oacute; ch&iacute;nh l&agrave; d&agrave;nh cho họ, những con người nh&uacute;t nh&aacute;t, rụt r&egrave;, ngại giao tiếp, th&iacute;ch suy nghĩ s&acirc;u sắc, ham đọc s&aacute;ch, khi&ecirc;m tốn, nhạy cảm, thận trọng, nghi&ecirc;m t&uacute;c, sống nội t&acirc;m, hiền l&agrave;nh, điềm tĩnh, th&iacute;ch t&igrave;m sự đơn độc, ngại mạo hiểm, dễ bị tổn thương bởi lời l&ecirc;n &aacute;n hoặc x&uacute;c phạm. Những người như t&ocirc;i. Cuốn s&aacute;ch n&agrave;y được Susan Cain viết trước hết l&agrave; để cho họ. Bản dịch n&agrave;y được t&ocirc;i thực hiện, trước hết l&agrave; để cho họ.</p>

<p style="text-align:justify">Những lời n&agrave;y n&oacute;i ra, t&ocirc;i hy vọng đ&atilde; gi&uacute;p bạn hiểu được t&ocirc;i l&agrave;m thế n&agrave;y l&agrave; để l&agrave;m g&igrave;, để đạt được g&igrave;, v&agrave; để bạn hiểu rằng bạn n&ecirc;n tr&ocirc;ng mong những g&igrave; v&agrave; kh&ocirc;ng n&ecirc;n tr&ocirc;ng mong những g&igrave; từ bản dịch n&agrave;y. Kể từ giờ trở đi, t&ocirc;i xin nhường lại c&ocirc;ng việc quyết định cho bạn. Nếu bạn tin t&ocirc;i, tin v&agrave;o những điều t&ocirc;i n&oacute;i, hoặc &iacute;t nhất l&agrave; tin v&agrave;o gi&aacute; trị của cuốn s&aacute;ch n&agrave;y, v&agrave; muốn sử dụng đến bản dịch (d&ugrave; thiếu ho&agrave;n hảo) n&agrave;y của t&ocirc;i, t&ocirc;i xin được n&oacute;i: Cảm ơn bạn.</p>

<p style="text-align:justify">Ch&uacute;c bạn tất cả những g&igrave; tốt đẹp nhất. Bản dịch n&agrave;y xin được gửi tặng đến tất cả những người hướng nội ở ngo&agrave;i kia, cũng như những người hướng ngoại y&ecirc;u qu&yacute;, gắn b&oacute; hoặc cộng t&aacute;c với những người hướng nội nữa. Cảm ơn c&aacute;c bạn đ&atilde; đọc đến đ&acirc;y. Cảm ơn c&aacute;c bạn, v&agrave; ch&uacute;c c&aacute;c bạn cũng sẽ t&igrave;m được những hiểu biết v&agrave; &yacute; tưởng thật s&acirc;u sắc, mới mẻ từ cuốn s&aacute;ch n&agrave;y, như t&ocirc;i đ&atilde; t&igrave;m thấy được vậy.</p>

<p style="text-align:justify"><strong><em>H&agrave; Nội, ng&agrave;y 10 th&aacute;ng Năm, năm 2014. Nguyễn Tiến Đạt (sutucon)</em></strong></p>
', CAST(N'2021-12-19T17:20:25.697' AS DateTime), 1, CAST(N'2022-03-21T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (16, N'Hãy Tin Rằng Bạn Được Yêu Thương', N'hay_tin_rang_ban_duoc_yeu_thuong', NULL, N'hay-tin-rang-ban-duoc-yeu-thuong.jpg', NULL, N'Philis BoultingHouse', CAST(99000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), 850, 2, N'<blockquote>
<p><strong><span style="font-family:Times New Roman,Times,serif">Mỗi ng&agrave;y tr&ocirc;i qua, bạn h&atilde;y nhớ rằng lu&ocirc;n c&oacute; người cần một v&ograve;ng tay th&acirc;n thương&hellip;<br />
&hellip; Thậm ch&iacute; c&oacute; thể đ&oacute; l&agrave; bạn!</span></strong></p>
</blockquote>

<p>Mối quan hệ giữa những người bạn g&aacute;i rất đặc biệt, kh&ocirc;ng giống bất cứ mối quan hệ n&agrave;o. D&ugrave; ở độ tuổi 15 hay 50,&nbsp;t&igrave;nh bạn&nbsp;gắn b&oacute; của những người phụ nữ đều được h&igrave;nh th&agrave;nh từ những&nbsp;t&acirc;m hồn&nbsp;rộng mở, sự sẻ chia, v&agrave; th&aacute;i độ ch&acirc;n th&agrave;nh cổ vũ cho nhau.<br />
D&ugrave; bạn l&agrave; ai, mới quen biết hay được y&ecirc;u qu&yacute; từ l&acirc;u, quyển s&aacute;ch n&agrave;y xin sẻ chia một &ldquo;c&aacute;i &ocirc;m&rdquo; thương mến với tất cả những ai được bạn gọi l&agrave; &ldquo;bạn&rdquo;.</p>
', CAST(N'2021-12-19T18:42:31.783' AS DateTime), 1, NULL, 8)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (17, N'Quà Tặng Cho Người Muốn Thành Công', N'qua_tang_cho_nguoi_muon_thanh_cong', NULL, N'qua-tang-cho-nguoi-muon-thanh-cong.jpg', NULL, N'Brian Tracy', CAST(145000 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), 1300, 2, N'<p>&ldquo;Nếu cuộc sống của bạn ho&agrave;n hảo qu&aacute; th&igrave; cuộc sống đ&oacute; sẽ như thế n&agrave;o?</p>

<p>Trừ khi bạn kh&ocirc;ng muốn nữa, c&ograve;n kh&ocirc;ng, những g&igrave; bạn muốn đạt được trong đời th&igrave; v&ocirc; hạn.</p>

<p>Bạn từ đ&acirc;u đến kh&ocirc;ng quan trọng, vấn đề quan trọng l&agrave; bạn đang đi đến đ&acirc;u.</p>

<p>Mỗi người đều c&oacute; những tiềm năng lớn lao chưa được động tới. C&ocirc;ng việc sẽ gi&uacute;p giải ph&oacute;ng những tiềm năng đ&oacute;.</p>

<p>Cuộc đời như một c&aacute;i kho&aacute; số. Mục ti&ecirc;u của bạn l&agrave; phải t&igrave;m được những con số đ&uacute;ng, một trật tự đ&uacute;ng để c&oacute; thể mở bất kỳ c&aacute;nh cửa n&agrave;o bạn muốn.</p>

<p>Nếu bạn l&agrave;m đ&uacute;ng c&aacute;ch, đ&uacute;ng việc, chắc chắn bạn sẽ đạt được mọi th&agrave;nh quả như m&igrave;nh khao kh&aacute;t.</p>

<p>Mọi việc ta l&agrave;m trong đời đều l&agrave; để được thương y&ecirc;u, hoặc để b&ugrave; đắp sự thiếu t&igrave;nh y&ecirc;u</p>

<p>T&iacute;nh bền bỉ ch&iacute;nh l&agrave; t&agrave;i sản gi&aacute; trị nhất của mỗi người.</p>

<p>Ch&iacute;nh tiếng n&oacute;i b&ecirc;n trong sẽ hướng dẫn để bạn biết khi n&agrave;o th&igrave; phải n&oacute;i đ&uacute;ng điều cần n&oacute;i, l&agrave;m đ&uacute;ng việc cần l&agrave;m.</p>

<p>H&atilde;y học hỏi c&aacute;c chuy&ecirc;n gia, v&igrave; cuộc đời rất ngắn, kh&ocirc;ng đủ thời gian để ta tự biết hết mọi điều&rdquo;&hellip;.</p>
', CAST(N'2021-12-19T18:44:01.137' AS DateTime), 1, NULL, 7)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (18, N'Ta yêu nhau', N'ta_yeu_nhau', N'<p style="text-align:justify">T&igrave;nh y&ecirc;u l&agrave; một m&oacute;n qu&agrave; m&agrave; ta phải mất hết một đời mới mở ra được. Ngay khi ch&uacute;ng ta nghĩ rằng m&igrave;nh đ&atilde; hiểu hết tất cả, th&igrave; bỗng nhi&ecirc;n lại ph&aacute;t hiện th&ecirc;m một điều mới mẻ c&oacute; thể l&agrave;m thay đổi mọi thứ. Khi c&agrave;ng trưởng th&agrave;nh hơn, th&igrave; ch&uacute;ng ta c&agrave;ng nhận ra rằng m&oacute;n qu&agrave; t&igrave;nh y&ecirc;u thật mu&ocirc;n m&agrave;u mu&ocirc;n vẻ: c&oacute; nhục cảm, c&oacute; bao dung, c&oacute; dịu d&agrave;ng, c&oacute; tươi vui, c&oacute; lạ lẫm, c&oacute; cao thượng, c&oacute; cả tầm thường, c&oacute; l&atilde;ng mạn, m&agrave; cũng c&oacute; thực dụng. Ấy l&agrave; chỉ đơn cử một v&agrave;i trong v&ocirc; v&agrave;n biểu hiện của t&igrave;nh y&ecirc;u &ndash; một m&oacute;n qu&agrave; v&ocirc; c&ugrave;ng phức tạp</p>
', N'ta-yeu-nhau.jpg', NULL, N'Ron and Lyn Rose', CAST(45000 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)), 2098, 2, N'<p style="text-align:justify">Những mối li&ecirc;n hệ mật thiết trọn đời được gắn kết nhờ đức qu&ecirc;n m&igrave;nh của người hiến tặng. Diệu k&igrave; nhất l&agrave; c&agrave;ng được ban tặng nhiều t&igrave;nh y&ecirc;u, ta lại phải c&agrave;ng tặng nhiều hơn nữa, khiến m&oacute;n qu&agrave; đ&oacute; ng&agrave;y c&agrave;ng lớn dần cho đến v&ocirc; tận! V&igrave; thế nhiều khi ta vẫn được người y&ecirc;u thương ngay cả khi ta kh&ocirc;ng c&ograve;n xứng đ&aacute;ng!</p>

<p style="text-align:justify">Nhưng cũng lạ l&ugrave;ng trong t&igrave;nh y&ecirc;u, một khi mọi c&aacute;nh cửa đ&atilde; kh&eacute;p lại, &aacute;nh s&aacute;ng kh&ocirc;ng c&ograve;n nữa, th&igrave; người n&agrave;y lại chỉ c&ograve;n thấy r&otilde; ở người kia những tật xấu kh&oacute; ưa v&agrave; những điều b&iacute; mật thầm k&iacute;n kh&oacute; hiểu.</p>

<p style="text-align:justify">Chỉ c&oacute; &aacute;nh s&aacute;ng của t&igrave;nh y&ecirc;u chung thủy mới gi&uacute;p ch&uacute;ng ta biết chấp nhận lẫn nhau, biết sẵn l&ograve;ng tha thứ v&agrave; kh&ocirc;ng chấp n&ecirc; những điều nhỏ nhặt để nhận biết được điều tốt đẹp nhất ở mỗi người.</p>

<p style="text-align:justify">Thứ t&igrave;nh y&ecirc;u n&agrave;y vẫn hiếm hoi v&agrave; c&oacute; nếm trải qua rồi ch&uacute;ng ta mới c&oacute; thể hiểu m&agrave; tặng cho người kh&aacute;c.</p>

<p style="text-align:justify">M&oacute;n qu&agrave; mang t&ecirc;n t&igrave;nh y&ecirc;u l&agrave; thứ qu&agrave; phải giao đ&uacute;ng địa chỉ, kh&ocirc;ng thể gửi tặng t&ugrave;y tiện bất k&igrave; ai. N&oacute; phải l&agrave;m cho người nhận cảm thấy l&ograve;ng m&igrave;nh x&uacute;c động v&agrave; hồn m&igrave;nh thăng hoa. N&oacute; kh&ocirc;ng thể l&agrave; g&ocirc;ng c&ugrave;m, biến người nhận th&agrave;nh n&ocirc; lệ để ta thống trị, hay th&agrave;nh t&ugrave; nh&acirc;n để ta theo d&otilde;i. M&oacute;n qu&agrave; t&igrave;nh y&ecirc;u, trước hết, l&agrave; cho ta. N&oacute; như một ngọn đ&egrave;n, gi&uacute;p ta nh&igrave;n r&otilde; những ưu điểm của người kia, n&oacute; khiến ta, ngay cả khi ho&agrave;n cảnh ngăn trở, vẫn thấy hiện ra những điều tốt đẹp nhất, rực rỡ nhất.</p>

<p style="text-align:justify">Khi c&aacute;c mối d&acirc;y li&ecirc;n kết giữa ch&uacute;ng ta được sinh ra trong tr&aacute;i tim Thượng Đế, ch&uacute;ng ta sẽ l&agrave;m cho nhau những điều tốt đẹp nhất, bởi những mối d&acirc;y ấy được nu&ocirc;i dưỡng bằng t&igrave;nh y&ecirc;u.</p>

<p style="text-align:right"><strong>Don Lessin</strong></p>
', CAST(N'2021-12-19T18:45:57.373' AS DateTime), 1, CAST(N'2022-02-25T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (19, N'Nói Sao Cho Trẻ Chịu Nghe', N'noi_sao_cho_tre_chiu_nghe', NULL, N'noi-sao-cho-tre-chiu-nghe-nghe-sao-cho-tre-chiu-noi-adele-faber-elaine-mazlish.jpg', NULL, N'Adele Faber and Elaine Mazlish', CAST(221000 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), 9990, 2, N'<p><strong>Ch&uacute;ng t&ocirc;i ch&acirc;n th&agrave;nh gửi lời cảm ơn tới:</strong></p>

<ul>
	<li>Leslie Faber v&agrave; Robert Mazlish, cố vấn thường trực của ch&uacute;ng t&ocirc;i, những người lu&ocirc;n ở cạnh ch&uacute;ng t&ocirc;i với những lời cổ vũ v&agrave; tư duy mới.</li>
	<li>Carl, Joanna, v&agrave; Abram Faber; Kathy, Liz v&agrave; John Mazlish, những nguồn vui của ch&uacute;ng t&ocirc;i, chỉ bằng c&aacute;ch c&aacute;c con l&agrave; ch&iacute;nh m&igrave;nh.</li>
	<li>Kathy Menninger, người hỗ trợ đ&aacute;nh m&aacute;y văn bản với sự ch&uacute; &yacute; cẩn thận đến từng chi tiết.</li>
	<li>Họa sĩ Kimberly Coe, người tạo n&ecirc;n h&igrave;nh h&agrave;i cho những nh&acirc;n vật của ch&uacute;ng t&ocirc;i từ những ph&aacute;c thảo ban đầu m&agrave; thoạt nh&igrave;n ch&uacute;ng t&ocirc;i đ&atilde; cảm ngay.</li>
	<li>Robert Markel với sự ủng hộ v&agrave; chỉ dẫn trong những giờ ph&uacute;t khủng hoảng</li>
	<li>Gerald Nierenberg, người bạn h&agrave;o ph&oacute;ng với những lời khuy&ecirc;n gi&agrave;u kinh nghiệm v&agrave; t&iacute;nh chuy&ecirc;n m&ocirc;n.</li>
	<li>Những phụ huynh tham gia c&aacute;c chương tr&igrave;nh hội thảo của ch&uacute;ng t&ocirc;i, với những g&oacute;p &yacute; nghi&ecirc;m khắc nhất, cả trực tiếp lẫn qua thư từ.</li>
	<li>Ann Marie Geiger v&agrave; Patricia King, lu&ocirc;n tận t&acirc;m bất cứ khi n&agrave;o ch&uacute;ng t&ocirc;i cần.</li>
	<li>Jim Wade, bi&ecirc;n tập vi&ecirc;n của ch&uacute;ng t&ocirc;i, người lu&ocirc;n khắt khe về chất lượng, người m&agrave; ch&uacute;ng t&ocirc;i cảm thấy sung sướng khi l&agrave;m việc c&ugrave;ng.</li>
	<li>V&agrave; nhất l&agrave; tiến sĩ Haim Ginott, người giới thiệu cho ch&uacute;ng t&ocirc;i những phương ph&aacute;p mới về giao tiếp với trẻ em. Một người lu&ocirc;n đau đ&aacute;u với mục ti&ecirc;u &ldquo;kh&ocirc;ng được để một vết xước n&agrave;o l&ecirc;n t&acirc;m hồn con trẻ&rdquo;. Khi &ocirc;ng qua đời, trẻ em thế giới mất đi một người thầy vĩ đại.</li>
</ul>
', CAST(N'2021-12-19T18:49:01.000' AS DateTime), 1, CAST(N'2022-01-21T00:00:00.000' AS DateTime), 52)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (20, N'Ơn cha nghĩa mẹ', N'on_cha_nghia_me', NULL, N'On-cha-nghia-me-170x300-1.jpg', NULL, N'Nhiều tác giả', CAST(36000 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)), 3249, 2, NULL, CAST(N'2021-12-19T18:50:52.743' AS DateTime), 1, CAST(N'2022-12-12T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (21, N'Đám đông cô đơn', N'dam_dong_co_don', NULL, N'Dam-Dong-Co-Don.jpg', NULL, N'David Riesman, Nathan Glazer and Reuel Denny', CAST(77000 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), 500, 2, NULL, CAST(N'2021-12-19T18:53:30.870' AS DateTime), 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (22, N'Luật hấp dẫn', N'luat_hap_dan', NULL, N'Luat-Hap-Dan-–-5-Buoc-Thuc-Hanh.jpg', NULL, N'Joe Vitale', CAST(85000 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), 600, 2, NULL, CAST(N'2021-12-19T18:54:44.593' AS DateTime), 1, NULL, 1)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10023, N'Mathematical Statistics, Essays on History and Methodology', N'mathematical_statistics__essays_on_history_and_methodology', N'<p><span style="font-size:16px">Mathematical statistics</span></p>

<h3><span style="font-size:16px"><strong>Copyright: &copy; All Rights Reserved</strong></span></h3>
', N'1531107212.png', NULL, N'Johann Pfanzagl', CAST(245000 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)), 500, 16, NULL, CAST(N'2021-12-30T10:23:33.000' AS DateTime), 1, CAST(N'2022-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10024, N'Anxious People: A Novel', N'anxious_people__a_novel', N'<h2><span style="font-size:12px">If you&rsquo;re looking for an uplifting read (and who isn&rsquo;t these days), this feel-good charmer from &ldquo;A Man Called Ove&rdquo; author Fredrik Backman is sure to boost your spirits and restore your belief in the power of community.</span></h2>
', N'1640758680.png', NULL, N'Fredrik Backman', CAST(200000 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), 950, 17, N'<p>An apartment open-house changes from a run-of-the-mill real estate opportunity to a life-or-death struggle as a robber takes a group of strangers hostage at gunpoint. From the #1 New York Times bestselling author Fredrik Backman, Anxious People: A Novel is a surprisingly feel-good story for the subject matter.</p>

<p>The captives include a recently retired couple who prefer to focus on fixing up properties instead of their own marriage, a wealthy bank director whose career is his life, a young, constantly-bickering couple who are expecting their first child, an 87-year-old woman who could care less about the gun waving in her face, and a wheeling-and-dealing real estate agent who locked himself in the apartment&rsquo;s only bathroom.</p>

<p>As the hostage situation carries on and police surround the building, tensions boil over and grievances, hurts, secrets, and passions come to light. Everyone in the apartment, robber included, is in search of some sort of rescue.</p>

<p>With his signature understanding of human nature and authentic dialogue, Backman uses an unlikely situation to discuss friendship, forgiveness, and hope in even the most anxious times.</p>
', CAST(N'2021-12-30T11:22:29.000' AS DateTime), 1, CAST(N'2022-01-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10025, N'The Deal of a Lifetime', N'the_deal_of_a_lifetime', N'<p><strong>In this short story enhanced with beautiful illustrations, the bestselling author of&nbsp;<em>A Man Called Ove</em>,&nbsp;<em>Beartown</em>, and&nbsp;<em>Anxious People</em>&nbsp;delivers an insightful and poignant tale about finding out what is truly important in life.</strong></p>
', N'1639941547.png', NULL, N'Fredrik Backman', CAST(125000 AS Decimal(18, 0)), CAST(23 AS Decimal(18, 0)), 699, 17, N'<p style="text-align:justify">A father and a son are seeing each other for the first time in years. The father has a story to share before it&rsquo;s too late. He tells his son about a courageous little girl lying in a hospital bed a few miles away. She&rsquo;s a smart kid&mdash;smart enough to know that she won&rsquo;t beat cancer by drawing with crayons all day, but it seems to make the adults happy, so she keeps doing it.<br />
<br />
As he talks about this plucky little girl, the father also reveals more about himself: his triumphs in business, his failures as a parent, his past regrets, his hopes for the future.<br />
<br />
Now, on a cold winter&rsquo;s night, the father has been given an unexpected chance to do something remarkable that could change the destiny of a little girl he hardly knows. But before he can make the deal of a lifetime, he must find out what his own life has actually been worth, and only his son can reveal that answer.<br />
<br />
With humor and compassion, Fredrik Backman&rsquo;s&nbsp;<em>The Deal of a Lifetime</em>&nbsp;reminds us that life is a fleeting gift, and our legacy rests in how we share that gift with others.</p>
', CAST(N'2021-12-30T11:31:37.557' AS DateTime), 1, CAST(N'2022-01-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10026, N'Beartown: A Novel', N'beartown__a_novel', N'<p style="text-align:justify"><strong>Now an HBO Original Series</strong></p>

<blockquote>
<p style="text-align:justify"><strong>&ldquo;You&rsquo;ll love this engrossing novel.&rdquo; &mdash;<em>People</em></strong></p>
</blockquote>

<p style="text-align:justify"><br />
<strong>Named a Best Book of the Year by&nbsp;<em>LibraryReads</em>,&nbsp;<em>BookBrowse</em>, and&nbsp;<em>Goodreads</em></strong><br />
<strong>From the #1&nbsp;<em>New York Times</em>&nbsp;bestselling author of&nbsp;<em>Anxious People,</em>&nbsp;a dazzling and profound novel about a small town with a big dream&mdash;and the price required to make it come true.</strong></p>
', N'1639586771.png', NULL, N'Fredrik Backman', CAST(85000 AS Decimal(18, 0)), CAST(17 AS Decimal(18, 0)), 997, 17, N'<p style="text-align:justify">By the lake in Beartown is an old ice rink, and in that ice rink Kevin, Amat, Benji, and the rest of the town&rsquo;s junior ice hockey team are about to compete in the national semi-finals&mdash;and they actually have a shot at winning. All the hopes and dreams of this place now rest on the shoulders of a handful of teenage boys.<br />
<br />
Under that heavy burden, the match becomes the catalyst for a violent act that will leave a young girl traumatized and a town in turmoil. Accusations are made and, like ripples on a pond, they travel through all of Beartown.<br />
<br />
This is a story about a town and a game, but even more about loyalty, commitment, and the responsibilities of friendship; the people we disappoint even though we love them; and the decisions we make every day that come to define us. In this story of a small forest town, Fredrik Backman has found the entire world.</p>
', CAST(N'2021-12-30T11:34:29.487' AS DateTime), 1, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10027, N'Blind Eye: The Terrifying Story Of A Doctor Who Got Away With', N'blind_eye__the_terrifying_story_of_a_doctor_who_got_away_with', N'<p>By&nbsp;James B. Stewart</p>
', N'1631724083.png', NULL, N'James B. Stewart', CAST(112000 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), 750, 4, N'<p style="text-align:justify"><strong>A medical thriller from Pulitzer Prize&ndash;winning author James B. Stewart about serial killer doctor Michael Swango and the medical community that chose to turn a blind eye on his criminal activities.</strong><br />
<br />
No one could believe that the handsome young doctor might be a serial killer. Wherever he was hired&mdash;in Ohio, Illinois, New York, South Dakota&mdash;Michael Swango at first seemed the model physician. Then his patients began dying under suspicious circumstances.<br />
<br />
At once a gripping read and a hard-hitting look at the inner workings of the American medical system,&nbsp;<em>Blind Eye</em>&nbsp;describes a professional hierarchy where doctors repeatedly accept the word of fellow physicians over that of nurses, hospital employees, and patients&mdash;even as horrible truths begin to emerge. With the prodigious investigative reporting that has defined his Pulitzer Prize&ndash;winning career, James B. Stewart has tracked down survivors, relatives of victims, and shaken coworkers to unearth the evidence that may finally lead to Swango&rsquo;s conviction.<br />
<br />
Combining meticulous research with spellbinding prose, Stewart has written a shocking chronicle of a psychopathic doctor and of the medical establishment that chose to turn a blind eye on his criminal activities.</p>
', CAST(N'2021-12-30T11:39:07.417' AS DateTime), 1, CAST(N'2021-12-14T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10028, N'If I Never Met You', N'if_i_never_met_you', N'<p><span style="font-size:16px"><strong>Written by:</strong> Mhairi McFarlane &nbsp;</span></p>

<p><span style="font-size:16px"><strong>Narrated by:</strong> Sara Novak</span></p>
', N'1634278934.png', NULL, N'Mhairi McFarlane ', CAST(55000 AS Decimal(18, 0)), CAST(22 AS Decimal(18, 0)), 748, 14, N'<p style="text-align:center"><span style="font-size:16px"><strong>If faking love is this easy...how do you know when it&rsquo;s real?</strong></span></p>

<p style="text-align:center"><span style="font-size:16px"><strong>The brand new novel from&nbsp;</strong><strong><em>Sunday Times</em></strong><strong>&nbsp;best-selling author Mhairi McFarlane</strong></span></p>

<p style="text-align:center"><span style="font-size:16px"><strong>Laurie and Jamie have the perfect office romance</strong></span></p>

<p style="text-align:center"><span style="font-size:16px">(They set the rules via email)</span></p>

<p style="text-align:center"><span style="font-size:16px"><strong>Everyone can see they&rsquo;re head over heels</strong></span></p>
', CAST(N'2021-12-30T12:45:56.360' AS DateTime), 1, CAST(N'2022-01-13T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10029, N'Inheriting Edith: A Novel', N'inheriting_edith__a_novel', N'<p><strong>A&nbsp;poignant breakout novel, for fans of</strong><em><strong>&nbsp;</strong></em><strong>J. Courtney Sullivan and Elin Hilderbrand,&nbsp;about a single mother who inherits a beautiful beach house with a caveat&mdash;she must take care of the ornery elderly woman who lives in it.</strong></p>
', N'1640677093.png', NULL, N'Zoe Fishman', CAST(85000 AS Decimal(18, 0)), CAST(14 AS Decimal(18, 0)), 1000, 14, N'<p style="text-align:justify">For years, Maggie Sheets has been an invisible hand in the glittering homes of wealthy New York City clients, scrubbing, dusting, mopping, and doing all she can to keep her head above water as a single mother. Everything changes when a former employer dies leaving Maggie a staggering inheritance. A house in Sag Harbor. The catch? It comes with an inhabitant: The deceased&rsquo;s eighty-two-year old mother Edith.</p>

<p style="text-align:justify">Edith has Alzheimer&rsquo;s&mdash;or so the doctors tell her&mdash;but she remembers exactly how her daughter Liza could light up a room, or bring dark clouds in her wake. And now Liza&rsquo;s gone, by her own hand, and Edith has been left&mdash;like a chaise or strand of pearls&mdash;to a poorly dressed young woman with a toddler in tow.</p>

<p style="text-align:justify">Maggie and Edith are both certain this arrangement will be an utter disaster. But as summer days wane, a tenuous bond forms, and Edith, who feels the urgency of her diagnosis, shares a secret that she&rsquo;s held close for five decades, launching Maggie on a mission that might just lead them each to what they are looking for.</p>
', CAST(N'2021-12-30T12:47:34.670' AS DateTime), 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10030, N'Just Like Heaven', N'just_like_heaven', NULL, N'1640679296.png', NULL, N'Julia Quinn', CAST(113000 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)), 3248, 14, N'<p>Once again, #1&nbsp;<em>New York Times</em>&nbsp;bestselling author Julia Quinn transports her readers to historical romance heaven! Quinn&rsquo;s&nbsp;<em>Just Like Heaven</em>&nbsp;is the dazzling first installment of a delightful quartet of Regency Era-set tales featuring the romantic exploits of the well-meaning but less-than-accomplished Smythe-Smith musicians&mdash;in this case, a beautiful violinist in the pitiful group who has her sights set on marrying the last unwed Bridgerton&hellip;unless her handsome, love-struck guardian has anything to say about it. Bridgerton fans will cry, &ldquo;Encore!&rdquo;&mdash;as will every reader who adores England&rsquo;s Regency period and great love stories that are smart, witty, and lighthearted.</p>
', CAST(N'2021-12-30T12:51:09.000' AS DateTime), 1, CAST(N'2022-01-29T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10031, N'Learning Geospatial Analysis with Python', N'learning_geospatial_analysis_with_python', NULL, N'1617219943.png', NULL, N'Lawhead Joel', CAST(345000 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), 1233, 12, N'<p style="text-align:justify">Geospatial analysis is used in almost every field you can think of from medicine, to defense, to farming. It is an approach to use statistical analysis and other informational engineering to data which has a geographical or geospatial aspect. And this typically involves applications capable of geospatial display and processing to get a compiled and useful data.</p>

<p style="text-align:justify">&quot;Learning Geospatial Analysis with Python&quot; uses the expressive and powerful Python programming language to guide you through geographic information systems, remote sensing, topography, and more. It explains how to use a framework in order to approach Geospatial analysis effectively, but on your own terms.</p>

<p style="text-align:justify">&quot;Learning Geospatial Analysis with Python&quot; starts with a background of the field, a survey of the techniques and technology used, and then splits the field into its component speciality areas: GIS, remote sensing, elevation data, advanced modelling, and real-time data.</p>

<p style="text-align:justify">This book will teach you everything there is to know, from using a particular software package or API to using generic algorithms that can be applied to Geospatial analysis. This book focuses on pure Python whenever possible to minimize compiling platform-dependent binaries, so that you don&rsquo;t become bogged down in just getting ready to do analysis.</p>

<p style="text-align:justify">&quot;Learning Geospatial Analysis with Python&quot; will round out your technical library with handy recipes and a good understanding of a field that supplements many a modern day human endeavors.</p>

<p style="text-align:justify">Approach</p>

<p style="text-align:justify">This is a tutorial-style book that helps you to perform Geospatial and GIS analysis with Python and its tools/libraries. This book will first introduce various Python-related tools/packages in the initial chapters before moving towards practical usage, examples, and implementation in specialized kinds of Geospatial data analysis.</p>

<p style="text-align:justify">Who this book is for</p>

<p style="text-align:justify">This book is for anyone who wants to understand digital mapping and analysis and who uses Python or another scripting language for automation or crunching data manually.This book primarily targets Python developers, researchers, and analysts who want to perform Geospatial, modeling, and GIS analysis with Python.</p>
', CAST(N'2021-12-30T12:53:49.000' AS DateTime), 1, CAST(N'2022-01-27T00:00:00.000' AS DateTime), 17)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10032, N'Getting to Know ArcGIS Pro', N'getting_to_know_arcgis_pro', NULL, N'1638609206.png', NULL, N'Michael Law and Amy Collins', CAST(758000 AS Decimal(18, 0)), CAST(31 AS Decimal(18, 0)), 249, 12, N'<p style="text-align:justify"><span style="font-size:16px">In the tradition of the best-selling Getting to Know series,&nbsp;<em>Getting to Know ArcGIS Pro</em>, second edition teaches new and existing GIS users how to get started solving problems by visualizing, querying, creating, editing, analyzing, and presenting geospatial data in both 2D and 3D environments using ArcGIS Pro. This book teaches the basic functions and capabilities of ArcGIS Pro through practical project workflows and shows how to be productive with this essential component of the ArcGIS platform. The second edition has been updated for ArcGIS Pro 2.3.</span></p>

<p style="text-align:justify"><span style="font-size:16px"><strong>Note:</strong>&nbsp;This e-book requires ArcGIS software. You can download the ArcGIS Trial at&nbsp;http://www.esri.com/arcgis/trial, contact your school or business Esri Site License Administrator, or purchase a student or individual license through the&nbsp;Esri Store.</span></p>
', CAST(N'2021-12-30T12:56:59.783' AS DateTime), 1, NULL, 101)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10033, N'Lược Sử Thế Giới', N'luoc_su_the_gioi', NULL, N'b22440f058b655363780c8006a84290a-removebg-preview.png', NULL, N'E.H. Gombrich', CAST(208000 AS Decimal(18, 0)), CAST(17 AS Decimal(18, 0)), 1748, 7, N'<p style="text-align:justify">Từ khi được viết ra bằng tiếng Đức năm 1935,&nbsp;<em>Lược sử thế giới</em>&nbsp;đ&atilde; trở th&agrave;nh cuốn s&aacute;ch lịch sử b&aacute;n chạy ở ba mươi ng&ocirc;n ngữ. Năm 2005, cuốn s&aacute;ch được xuất bản bằng tiếng Anh với phần minh họa bổ sung, v&agrave; phi&ecirc;n bản n&agrave;y b&aacute;n được hơn nửa triệu bản tr&ecirc;n to&agrave;n thế giới.</p>

<p style="text-align:justify">Như một b&agrave;i thơ về lịch sử thế giới, E. H. Gombrich lịch l&atilde;m dẫn người đọc đi từ thời kỳ Đồ đ&aacute; đến thời kỳ của năng lượng nguy&ecirc;n tử, với những biến cố lịch sử phức tạp nhất, c&aacute;c tr&agrave;o lưu tư tưởng kh&oacute; hiểu nhất, những nh&acirc;n vật lịch sử đa chiều nhất, c&aacute;c th&agrave;nh tựu lớn lao nhất của tr&iacute; tuệ con người&hellip; tất cả đều được t&aacute;c giả m&ocirc; tả v&agrave; diễn giải dễ hiểu đến bất ngờ.</p>

<p style="text-align:justify">Với cuốn s&aacute;ch n&agrave;y trong tay, bạn sẽ thấy niềm vui to lớn trong việc t&igrave;m hiểu lịch sử, c&ugrave;ng v&ocirc; số khoảnh khắc qu&ecirc;n hết tất cả để say m&ecirc; đắm m&igrave;nh trong qu&aacute; v&atilde;ng của d&ograve;ng chảy lịch sử.</p>

<p style="text-align:justify">&ldquo;Một c&acirc;u chuyện hấp dẫn, được tổ chức tuyệt vời v&agrave; được kể với một năng lượng v&agrave; sự tự tin v&ocirc; c&ugrave;ng cuốn h&uacute;t, tr&agrave;n ngập t&igrave;nh nh&acirc;n văn v&agrave; tinh thần h&agrave;o sảng m&agrave; h&agrave;ng ng&agrave;n người ngưỡng mộ Gombrich đ&atilde; y&ecirc;u mến trong suốt cuộc đời d&agrave;i v&agrave; đầy s&aacute;ng tạo của &ocirc;ng. Cuốn s&aacute;ch thực sự l&agrave; một điều bất ngờ đầy th&uacute; vị, kh&ocirc;ng thể n&agrave;o cưỡng lại!&rdquo;</p>

<p style="text-align:justify">- Philip Pullman</p>

<p style="text-align:justify">Gi&aacute; sản phẩm tr&ecirc;n Tiki đ&atilde; bao gồm thuế theo luật hiện h&agrave;nh. B&ecirc;n cạnh đ&oacute;, tuỳ v&agrave;o loại sản phẩm, h&igrave;nh thức v&agrave; địa chỉ giao h&agrave;ng m&agrave; c&oacute; thể ph&aacute;t sinh th&ecirc;m chi ph&iacute; kh&aacute;c như ph&iacute; vận chuyển, phụ ph&iacute; h&agrave;ng cồng kềnh, thuế nhập khẩu (đối với đơn h&agrave;ng giao từ nước ngo&agrave;i c&oacute; gi&aacute; trị tr&ecirc;n 1 triệu đồng).....</p>
', CAST(N'2021-12-30T21:16:53.000' AS DateTime), 1, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10034, N'Sapiens Lược Sử Loài Người (Tái Bản)', N'sapiens_luoc_su_loai_nguoi__tai_ban_', NULL, N'sapien_luocsuloainguoi.jpg', NULL, N'Yuval Noah Harari', CAST(168040 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)), 3899, 7, N'<p style="text-align:justify">Sapiens l&agrave; một c&acirc;u chuyện lịch sử lớn về nền văn minh nh&acirc;n loại &ndash; c&aacute;ch ch&uacute;ng ta ph&aacute;t triển từ x&atilde; hội săn bắt h&aacute;i lượm thuở sơ khai đến c&aacute;ch ch&uacute;ng ta tổ chức x&atilde; hội v&agrave; nền kinh tế ng&agrave;y nay.</p>

<p style="text-align:justify">Trong ấn bản mới n&agrave;y của cuốn Sapiens - Lược sử lo&agrave;i người, ch&uacute;ng t&ocirc;i đ&atilde; c&oacute; một số hiệu chỉnh về nội dung với sự tham gia, đ&oacute;ng g&oacute;p của c&aacute;c th&agrave;nh vi&ecirc;n Cộng đồng đọc s&aacute;ch Tinh hoa. Xin tr&acirc;n trọng cảm ơn &yacute; kiến đ&oacute;ng g&oacute;p tận t&acirc;m của c&aacute;c qu&yacute; độc giả, đặc biệt l&agrave; &ocirc;ng Nguyễn Ho&agrave;ng Giang, &ocirc;ng Nguyễn Việt Long, &ocirc;ng Đặng Trọng Hiếu c&ugrave;ng những người kh&aacute;c. Mong tiếp tục nhận được sự quan t&acirc;m v&agrave; g&oacute;p &yacute; từ độc giả.</p>

<p style="text-align:justify">Điểm độc đ&aacute;o ở Harari l&agrave; &ocirc;ng tập trung v&agrave;o sức mạnh của c&acirc;u chuyện v&agrave; huyền thoại để đưa mọi người lại gần T&ocirc;i muốn giới thiệu cuốn s&aacute;ch n&agrave;y cho bất cứ ai hứng th&uacute; quan t&acirc;m tới một c&aacute;ch nh&igrave;n đầy hấp dẫn v&agrave; th&uacute; vị về lịch sử ban đầu của con ngườ Harari kể về lịch sử lo&agrave;i người theo một c&aacute;ch dễ tiếp cận khiến bạn thật kh&oacute; c&oacute; thể đặt n&oacute; xuống&rdquo;. &ndash; Bill Gates</p>

<p style="text-align:justify">&ldquo;Sapiens t&igrave;m c&acirc;u trả lời cho vấn đề lớn nhất của lịch sử cũng như của thế giới hiện đại, v&agrave; n&oacute; được viết bằng một thứ ng&ocirc;n ngữ tuyệt vời khiến người ta kh&ocirc;ng thể qu&ecirc;n được&rdquo;. &ndash; Jared Diamond, t&aacute;c giả cuốn s&aacute;ch đoạt giải Pulitzer S&uacute;ng, vi tr&ugrave;ng v&agrave; th&eacute;p</p>

<p style="text-align:justify">&ldquo;Sapiens thuộc loại s&aacute;ch c&oacute; thể gi&uacute;p dọn sạch t&acirc;m tr&iacute; bạn. T&aacute;c giả của n&oacute;, Yuval Noah Harari, l&agrave; một học giả người Israel trẻ tuổi v&agrave; l&agrave; một người l&agrave;m xiếc tri thức đi&ecirc;u luyện với những bước nhảy logic khiến bạn phải th&oacute;t tim ngưỡng mộ Ng&ograve;i b&uacute;t của Harari tỏa ra sức mạnh v&agrave; sự s&aacute;ng r&otilde;, l&agrave;m cho thế giới trở n&ecirc;n kỳ lạ v&agrave; mới mẻ&rdquo;.</p>
', CAST(N'2021-12-30T21:21:10.000' AS DateTime), 1, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10035, N'Bí Ẩn Mãi Mãi Là Bí Ẩn Tập 1', N'bi_an_mai_mai_la_bi_an_tap_1', N'<p style="text-align:justify"><strong><em>B&iacute; ẩn m&atilde;i m&atilde;i l&agrave; b&iacute; ẩn Tập 1</em></strong>&nbsp;giới thiệu đến c&aacute;c bạn những điều b&iacute; ẩn đ&atilde; v&agrave; đang tồn tại xung quanh cuộc sống của ch&uacute;ng ta; những điều m&agrave; khoa học c&ograve;n chưa c&oacute;&nbsp; lời giải th&iacute;ch.</p>
', N'31936451._UY1173_SS1173_-removebg-preview.png', NULL, N'Nhiều tác giả', CAST(40000 AS Decimal(18, 0)), CAST(14 AS Decimal(18, 0)), 2249, 7, N'<p style="text-align:justify">S&aacute;ch bao gồm 8 chủ đề:<br />
- Những vụ mất t&iacute;ch trong lịch sử<br />
- V&ugrave;ng tam gi&aacute;c quỷ Bermuda<br />
- UFO v&agrave; người ngo&agrave;i h&agrave;nh tinh<br />
- T&igrave;m kiếm nền văn minh ngo&agrave;i h&agrave;nh tinh<br />
- C&aacute;c hiện tượng phi thường của cơ thể lo&agrave;i người<br />
- Linh hồn<br />
- Qu&aacute;i vật<br />
- Sinh vật lo&agrave;i người<br />
<br />
D&ugrave; biết l&agrave; cuốn s&aacute;ch n&agrave;y mỏng th&ocirc;i n&ecirc;n lượng kiến thức hẳn l&agrave; cũng kh&ocirc;ng nhiều, nhưng nếu n&oacute;i m&igrave;nh kh&ocirc;ng kỳ vọng g&igrave; ở cuốn n&agrave;y th&igrave; kh&ocirc;ng đ&uacute;ng, v&agrave; lần n&agrave;y th&igrave; kỳ vọng bao nhi&ecirc;u thất vọng bấy nhi&ecirc;u. &Yacute; m&igrave;nh l&agrave;, m&igrave;nh thấy cuốn s&aacute;ch n&agrave;y như kiểu những mẩu tin thế giới kỳ th&uacute; b&iacute; ẩn quanh ta n&agrave;y nọ tr&ecirc;n b&aacute;o vậy, số lượng th&ocirc;ng tin trong s&aacute;ch nhiều hơn tr&ecirc;n b&aacute;o một x&iacute;u v&agrave; cũng nhiều h&igrave;nh hơn (nhưng l&agrave; h&igrave;nh đen trắng v&agrave; c&oacute; những h&igrave;nh chụp từ l&acirc;u rồi n&ecirc;n kh&aacute; kh&oacute; nh&igrave;n). Kh&ocirc;ng biết c&aacute;c tập kh&aacute;c thế n&agrave;o, nhưng ở tập 1 n&agrave;y m&igrave;nh thấy &ocirc;m đồm nhiều thứ qu&aacute; n&ecirc;n thiếu chiều s&acirc;u, đọc như gi&oacute; thoảng m&acirc;y tr&ocirc;i, xong rồi l&agrave; qu&ecirc;n r&aacute;o trọi. Ở thời điểm hiện tại, m&igrave;nh kh&ocirc;ng đủ hứng th&uacute; cũng như sự quan t&acirc;m để t&igrave;m hiểu xem c&aacute;c sự kiện trong s&aacute;ch t&iacute;nh x&aacute;c thực thế n&agrave;o, nhưng thiệt t&igrave;nh l&agrave; l&uacute;c đọc m&igrave;nh cũng kh&ocirc;ng tin mấy, thấy hư cấu thế n&agrave;o.<br />
<br />
Tuy vậy, trong s&aacute;ch vẫn c&oacute; hai nội dung khiến m&igrave;nh kh&aacute; hứng th&uacute; l&agrave; &ldquo;Những tượng đ&aacute; b&iacute; ẩn tr&ecirc;n đảo Phục Sinh&rdquo; v&agrave; &ldquo;Kim tự th&aacute;p Ai Cập&rdquo;. Thực tế l&agrave; hai c&aacute;i n&agrave;y chắc xuất hiện ra rả tr&ecirc;n tivi b&aacute;o đ&agrave;i mạng miếc rồi, nhưng trước giờ m&igrave;nh lại kh&ocirc;ng quan t&acirc;m t&igrave;m hiểu, lần n&agrave;y đọc được hai b&agrave;i n&agrave;y thấy th&uacute; vị gh&ecirc;, coi như cũng c&oacute; th&ecirc;m ch&uacute;t kiến thức (d&ugrave; kiến thức n&agrave;y chắc ai cũng biết hết rồi =_=).<br />
<br />
D&ugrave; sao th&igrave;, m&igrave;nh nghĩ cuốn s&aacute;ch n&agrave;y c&oacute; lẽ sẽ ph&ugrave; hợp với c&aacute;c em cấp 1, cấp 2, khi c&aacute;c em trong độ tuổi muốn t&igrave;m hiểu kh&aacute;m ph&aacute; th&ecirc;m nhiều điều mới mẻ của thế giới, c&ograve;n ở độ tuổi của m&igrave;nh th&igrave; đọc thấy kh&ocirc;ng kho&aacute;i mấy. Mỗi chủ đề trong s&aacute;ch c&oacute; thể xem như một gợi &yacute; để những ai muốn t&igrave;m hiểu s&acirc;u hơn c&oacute; thể tự t&igrave;m t&ograve;i th&ecirc;m qua c&aacute;c s&aacute;ch b&aacute;o t&agrave;i liệu kh&aacute;c.</p>
', CAST(N'2021-12-30T21:26:52.380' AS DateTime), 1, CAST(N'2022-01-15T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10036, N'Thái Nhân Cách - Phía Sau Tội Ác (Khám Phá Bộ Não Của Những Kẻ Sát Nhân Máu Lạnh)', N'thai_nhan_cach_-_phia_sau_toi_ac__kham_pha_bo_nao_cua_nhung_ke_sat_nhan_mau_lanh_', NULL, N'thai-nhan-cach-phia-sau-toi-ac-tac-gia-james-fallon.jpeg', NULL, N'James Fallon', CAST(94500 AS Decimal(18, 0)), NULL, 594, 2, N'<p style="text-align:justify">James Fallon l&agrave; nh&agrave; khoa học thần kinh từng đoạt giải thưởng tại Đại học California, Irvine, nơi &ocirc;ng đ&atilde; giảng dạy khoa học thần kinh cho c&aacute;c sinh vi&ecirc;n y khoa, nghi&ecirc;n cứu sinh v&agrave; b&aacute;c sĩ l&acirc;m s&agrave;ng về t&acirc;m thần học v&agrave; thần kinh học trong 35 năm. C&ocirc;ng ty khởi nghiệp của &ocirc;ng, NeuroRepair, đ&atilde; được hiệp hội quốc gia gồm c&aacute;c c&ocirc;ng ty c&ugrave;ng ng&agrave;nh b&igrave;nh chọn l&agrave; c&ocirc;ng ty c&ocirc;ng nghệ sinh học mới h&agrave;ng đầu của năm v&agrave; đ&atilde; tạo ra những đột ph&aacute; lớn trong nghi&ecirc;n cứu tế b&agrave;o gốc.</p>

<p style="text-align:justify">C&oacute; kinh nghiệm 35 năm nghi&ecirc;n cứu về mối li&ecirc;n hệ giữa thần kinh v&agrave; h&agrave;nh vi con người, nhưng đến năm 2005, James Fallon b&agrave;ng ho&agrave;ng nhận ra bản phim scan PET n&atilde;o của ch&iacute;nh m&igrave;nh v&agrave; những kẻ giết người h&agrave;ng loạt v&agrave; t&acirc;m thần ph&acirc;n liệt đều c&oacute; một v&ugrave;ng th&ugrave;y tr&aacute;n bị tổn thương. Đ&acirc;y được coi l&agrave; khu vực kiểm so&aacute;t h&agrave;nh vi phạm tội, nếu tổn thưởng th&igrave; năng lực đồng cảm v&agrave; nhận thức đạo đức của con người cũng sẽ bị ảnh hưởng.</p>

<p style="text-align:justify">Nhưng một c&aacute;ch thẳng thắn, James Fallon cũng kh&ocirc;ng ngần ngại tiết lộ th&ocirc;ng tin về gia đ&igrave;nh nh&agrave; nội của m&igrave;nh rằng &ocirc;ng cũng c&oacute; &iacute;t nhất 7 người bị kết tội giết người. V&agrave; bản th&acirc;n n&atilde;o của ch&iacute;nh &ocirc;ng cũng c&oacute; khu vực tổn thương kh&ocirc;ng kh&aacute;c g&igrave; kẻ giết người. &ldquo;Ph&aacute;t hiện n&agrave;y đ&atilde; khiến t&ocirc;i cho&aacute;ng v&aacute;ng bởi c&aacute; nh&acirc;n t&ocirc;i chưa hề c&oacute; &yacute; định giết người, cưỡng hiếp bất cứ ai. Như vậy, hoặc giả thiết của t&ocirc;i về v&ugrave;ng n&atilde;o phản &aacute;nh h&agrave;nh vi giết người đ&atilde; sai&rdquo;, James Fallon cho biết.</p>

<p style="text-align:justify">T&aacute;c giả Fallon l&agrave; một nh&agrave; khoa học nghi&ecirc;n cứu tu&acirc;n thủ ph&aacute;p luật v&agrave; l&agrave; người đ&agrave;n &ocirc;ng của gia đ&igrave;nh hay một kẻ t&acirc;m thần nguy hiểm? Vậy điều g&igrave; khiến &ocirc;ng trở th&agrave;nh nh&agrave; thần kinh học lỗi lạc v&agrave; c&oacute; nhiều đ&oacute;ng g&oacute;p về y học cho nước Mỹ, nhiều c&ocirc;ng tr&igrave;nh nghi&ecirc;n cứu của &ocirc;ng được sử dụng cho qu&acirc;n đội Mỹ v&agrave; cả Lầu Năm G&oacute;c James H. Fallon. B&ecirc;n trong kẻ th&aacute;i nh&acirc;n c&aacute;ch l&agrave; cuốn s&aacute;ch viết về ch&iacute;nh bản th&acirc;n James &ndash; kẻ th&aacute;i nh&acirc;n c&aacute;ch ủng hộ x&atilde; hội.</p>

<p style="text-align:justify">&Ocirc;ng từng lừa dối với lũ trẻ của m&igrave;nh tại Scrabble, tổ chức tiệc t&ugrave;ng qu&aacute; kh&iacute;ch, xa l&aacute;nh đồng nghiệp v&agrave; đưa anh trai đến một hang động bị nhiễm Ebola v&agrave; coi anh ta l&agrave;m mồi nhử sư tử.</p>

<p style="text-align:justify">Ở kh&iacute;a cạnh t&iacute;ch cực, t&iacute;nh hiếu thắng của James khiến &ocirc;ng trở th&agrave;nh một người c&oacute; ch&iacute; tiến thủ, th&agrave;nh c&ocirc;ng trong sự nghiệp. Nhưng mặt kh&aacute;c, ch&iacute;nh nhờ chuy&ecirc;n m&ocirc;n của m&igrave;nh, &ocirc;ng nhận ra m&igrave;nh cũng l&agrave; người c&oacute; khiếm khuyết về di truyền v&agrave; tuy&ecirc;n chiến với ch&iacute;nh mầm mống bạo lực trong m&igrave;nh v&agrave; học c&aacute;ch đồng cảm với người xung quanh.</p>

<p style="text-align:justify">Cuốn s&aacute;ch ph&acirc;n t&iacute;ch n&atilde;o của những kẻ Th&aacute;i nh&acirc;n c&aacute;ch, họ kh&ocirc;ng c&oacute; kh&aacute;i niệm về &ldquo;tốt cho cộng đồng&rdquo;, kh&ocirc;ng c&oacute; quan điểm về đạo đức, ho&agrave;n to&agrave;n m&aacute;u lạnh v&agrave; dễ d&agrave;ng g&acirc;y ra những tội &aacute;c kinh ho&agrave;ng. Tr&ecirc;n thực tế những kh&aacute;i niệm đi liền với Th&aacute;i nh&acirc;n c&aacute;ch sẽ l&agrave; chống đối x&atilde; hội, Tuy nhi&ecirc;n, Jame H lại tự nhận m&igrave;nh l&agrave; kẻ th&aacute;i nh&acirc;n c&aacute;ch ủng hộ x&atilde; hội.</p>

<p style="text-align:justify">Cuốn s&aacute;ch l&agrave; một c&aacute;i nh&igrave;n hấp dẫn v&agrave;o phần tối của bộ n&atilde;o. Một cuốn s&aacute;ch cần phải đọc cho bất kỳ ai t&ograve; m&ograve; về l&yacute; do tại sao bộ n&atilde;o của ch&uacute;ng ta nghĩ ra những suy nghĩ đen tối nhất v&agrave; bao nhi&ecirc;u người trong ch&uacute;ng ta rơi v&agrave;o trạng th&aacute;i rối loạn t&acirc;m thần m&agrave; kh&ocirc;ng hề nhận ra. Nghi&ecirc;n cứu của Tiến sĩ Fallon về bộ n&atilde;o của ch&iacute;nh m&igrave;nh đ&atilde; gi&uacute;p ta t&igrave;m ra những &yacute; tưởng kỳ lạ nhất của m&igrave;nh v&agrave; l&yacute; do tại sao t&ocirc;i hoạt động theo c&aacute;ch ta l&agrave;m.</p>

<p style="text-align:justify"><img alt="" class="d-block mx-auto" src="https://salt.tikicdn.com/ts/tmp/04/c7/49/99c9c64ce61ad75e5ead5e0f813615a6.jpg" style="height:500px; width:750px" /></p>

<p style="text-align:justify">Gi&aacute; sản phẩm tr&ecirc;n Tiki đ&atilde; bao gồm thuế theo luật hiện h&agrave;nh. B&ecirc;n cạnh đ&oacute;, tuỳ v&agrave;o loại sản phẩm, h&igrave;nh thức v&agrave; địa chỉ giao h&agrave;ng m&agrave; c&oacute; thể ph&aacute;t sinh th&ecirc;m chi ph&iacute; kh&aacute;c như ph&iacute; vận chuyển, phụ ph&iacute; h&agrave;ng cồng kềnh, thuế nhập khẩu (đối với đơn h&agrave;ng giao từ nước ngo&agrave;i c&oacute; gi&aacute; trị tr&ecirc;n 1 triệu đồng).....</p>
', CAST(N'2021-12-30T21:33:28.607' AS DateTime), 1, CAST(N'2022-01-13T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10037, N'Các Thế Giới Song Song (Tái Bản 2018)', N'cac_the_gioi_song_song__tai_ban_2018_', NULL, N'cac_the_gioi_song_song.jpg', NULL, N'Michio Kaku', CAST(83700 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), 2245, 9, N'<p style="text-align:justify"><strong>C&aacute;c Thế Giới Song Song</strong></p>

<p style="text-align:justify">Một chuyến du h&agrave;nh đầy tr&iacute; tuệ qua c&aacute;c vũ trụ, được dẫn dắt t&agrave;i t&igrave;nh bởi &quot;thuyền trưởng&quot;&nbsp;<strong>Michio Kaku</strong>&nbsp;v&agrave; độc giả c&oacute; dịp chi&ecirc;m ngưỡng vẻ đẹp kỳ vĩ của vũ trụ kể từ vụ nổ lớn, vượt qua những hố đen, lỗ s&acirc;u, bước v&agrave;o c&aacute;c thế giới lượng tử từ mu&ocirc;n m&agrave;u kỳ lạ nằm ngay trước mũi ch&uacute;ng ta, vốn dĩ tồn tại song song tr&ecirc;n một m&agrave;ng b&ecirc;n ngo&agrave;i kh&ocirc;ng - thời gian bốn chiều, ngắm nh&igrave;n thực tại vật chất quen thuộc ho&agrave; quyện với thế giới của những điều kỳ diệu như năng lượng v&agrave; vật chất tối, sự nảy chồi của c&aacute;c vũ trụ, những chiều kh&ocirc;ng gian b&iacute; ẩn v&agrave; sự biến ảo của c&aacute;c d&acirc;y rung si&ecirc;u nhỏ...</p>

<p style="text-align:justify">Dẫn chuyện l&ocirc;i cuốn, kết hợp tường minh, sống động một lượng th&ocirc;ng tin đồ sộ để khai mở những giới hạn tột c&ugrave;ng của tr&iacute; &nbsp;tưởng tượng,&nbsp;<strong>Kaku</strong>&nbsp;thực sự xứng đ&aacute;ng l&agrave; &quot; nh&agrave; truyền gi&aacute;o&quot; vĩ đại đ&atilde; mang thế giới vật l&yacute; l&yacute; thuyết tới quảng đại quần ch&uacute;ng.</p>
', CAST(N'2021-12-30T21:37:34.890' AS DateTime), 1, NULL, 5)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10038, N'Kỹ Thuật Bảo Dưỡng Và Sửa Chữa Ô Tô Hiện Đại - Kỹ Năng Cơ Bản Sửa Chữa Ô Tô (Tái bản)', N'ky_thuat_bao_duong_va_sua_chua_o_to_hien_dai_-_ky_nang_co_ban_sua_chua_o_to__tai_ban_', NULL, N'49b5cc63fd204666f88d01017417893e.jpg', NULL, N'Nhiều tác giả', CAST(99600 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), 400, 15, N'<p style="text-align:justify">&Ocirc; t&ocirc; ng&agrave;y c&agrave;ng được sử dụng rộng r&atilde;i như một phương tiện đi lại c&aacute; nh&acirc;n cũng như vận chuyển h&agrave;nh kh&aacute;ch v&agrave; h&agrave;ng h&oacute;a. Sự gia tăng nhanh ch&oacute;ng về số lượng xe &ocirc; t&ocirc; sử dụng trong x&atilde; hội, đặc biệt l&agrave; c&aacute;c loại &ocirc; t&ocirc; đời mới, đang k&eacute;o theo nhu cầu đ&agrave;o tạo rất lớn về nguồn nh&acirc;n lực phục vụ bảo dưỡng v&agrave; sửa chữa &ocirc; t&ocirc;. Ngo&agrave;i ra, c&aacute;c bạn đọc y&ecirc;u th&iacute;ch &ocirc; t&ocirc; hoặc c&aacute;c bạn đọc đang l&agrave; chủ sở hữu &ocirc; t&ocirc; cũng c&oacute; nhu cầu t&igrave;m hiểu về cấu tạo, nguy&ecirc;n l&yacute; cũng như c&aacute;ch bảo dưỡng, sửa chữa th&ocirc;ng thường đối với &ocirc; t&ocirc;.</p>

<p style="text-align:justify"><br />
Để đ&aacute;p ứng nhu cầu của bạn đọc, ch&uacute;ng t&ocirc;i xin tr&acirc;n trọng giới thiệu đến bạn đọc bộ s&aacute;ch:<br />
&ldquo;KỸ THUẬT BẢO DƯỠNG V&Agrave; SỬA CHỮA &Ocirc; T&Ocirc; HIỆN ĐẠI&rdquo;<br />
Bộ s&aacute;ch được in ấn th&agrave;nh 5 tập:<br />
Tập 1: Kỹ năng cơ bản sửa chữa &ocirc; t&ocirc;<br />
Tập 2: Bảo dưỡng &ocirc; t&ocirc;<br />
Tập 3: Sửa chữa động cơ &ocirc; t&ocirc;<br />
Tập 4: Sửa chữa gầm, m&acirc;m &ocirc; t&ocirc;<br />
Tập 5: Sửa chữa điện &ocirc; t&ocirc;<br />
Bộ s&aacute;ch được bi&ecirc;n soạn dưới dạng c&aacute;c b&agrave;i thực h&agrave;nh c&oacute; t&iacute;nh ứng dụng cao. Mỗi b&agrave;i thực h&agrave;nh c&oacute; kết hợp giữa phần l&yacute; thuyết v&agrave; phần thực h&agrave;nh với mục đ&iacute;ch gi&uacute;p bạn đọc c&oacute; thể vận dụng được những kiến thức trong bộ s&aacute;ch v&agrave;o thực tế.</p>

<p style="text-align:justify"><br />
Bộ s&aacute;ch n&agrave;y được bi&ecirc;n soạn nhằm phục vụ c&aacute;c đối tượng sau đ&acirc;y:<br />
&ndash; Sinh vi&ecirc;n khoa động lực v&agrave; kỹ thuật &ocirc; t&ocirc; m&aacute;y k&eacute;o.<br />
&ndash; Học vi&ecirc;n hệ cao đẳng v&agrave; trung cấp chuy&ecirc;n ng&agrave;nh sửa chữa &ocirc; t&ocirc;.<br />
&ndash; Học vi&ecirc;n c&aacute;c lớp đ&agrave;o tạo ngắn hạn của c&aacute;c trung t&acirc;m dạy nghề v&agrave; c&aacute;c trường tư dạy nghề sửa chữa &ocirc; t&ocirc;.<br />
&ndash; C&aacute;c bạn đang sử dụng &ocirc; t&ocirc;.</p>
', CAST(N'2021-12-30T21:40:29.180' AS DateTime), 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10039, N'Kỹ Thuật Sữa Chữa Xe Máy - Nâng Cao (Tái Bản 2020)', N'ky_thuat_sua_chua_xe_may_-_nang_cao__tai_ban_2020_', NULL, N'suachuaxemayHungLe.png', NULL, N'Hùng Lê', CAST(100000 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)), 800, 15, N'<p style="text-align:justify">Nước ta l&agrave; một quốc gia sản xuất v&agrave; ti&ecirc;u thụ xe m&aacute;y rất nhiều. Do nhu cầu sử dụng ng&agrave;y c&agrave;ng tăng cao k&eacute;o theo nhu cầu về sửa chữa, bảo dưỡng xe m&aacute;y ng&agrave;y một nhiều, điều đ&oacute; cũng đ&ograve;i hỏi nhưng người thợ sửa chữa xe m&aacute;y n&acirc;ng cao tay nghề. Tuy nhi&ecirc;n những cuốn s&aacute;ch hướng dẫn về kỹ thuật sửa chữa xe m&aacute;y n&acirc;ng cao chưa thật đầy đủ v&agrave; chuy&ecirc;n s&acirc;u. V&igrave; vậy Huy Ho&agrave;ng Bookstore xin giới thiệu bạn đọc cuốn s&aacute;ch &ldquo;Kỹ thuật sửa chữa xe m&aacute;y n&acirc;ng cao&rdquo; như một &ldquo;c&ocirc;ng cụ&rdquo; gi&uacute;p những người thợ, những nh&acirc;n vi&ecirc;n bảo dưỡng xe chuy&ecirc;n nghiệp, hay những ai đang quan t&acirc;m đến kỹ thuật sửa chữa xe m&aacute;y l&agrave;m t&agrave;i liệu cho m&igrave;nh.<br />
<br />
&ldquo;Kỹ thuật sửa chữa xe m&aacute;y n&acirc;ng cao&rdquo; bao gồm những kiến thức cơ bản về sửa chữa xe m&aacute;y, b&atilde;o dưỡng xe m&aacute;y, điều chỉnh những bộ phận thường gặp, linh kiện cần thay thế (m&atilde; phanh, bugi, gioăng cao su, dầu m&aacute;y,&hellip;), kỹ năng ph&aacute;n đo&aacute;n c&aacute;c sự cố thường gặp,&hellip; Hy vọng, cuốn s&aacute;ch sẽ trở th&agrave;nh cuốn cẩm nang hữu &iacute;ch cho bạn đọc.<br />
<br />
Huy Ho&agrave;ng Bookstore h&acirc;n hạnh giới thiệu!</p>
', CAST(N'2021-12-30T21:51:07.227' AS DateTime), 1, CAST(N'2021-12-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10040, N'The Book of Lost Names', N'the_book_of_lost_names', N'<p>Written by&nbsp;<a href="https://www.scribd.com/author/229959240/Kristin-Harmel">Kristin Harmel</a></p>

<p>Narrated by&nbsp;<a href="https://www.scribd.com/contributor/262137664/Madeleine-Maby">Madeleine Maby</a></p>
', N'1640113421.png', NULL, N'Kristin Harmel', CAST(87500 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), 733, 17, N'<p style="text-align:justify"><strong>&ldquo;A fascinating, heartrending page-turner that, like the real-life forgers who inspired the novel, should never be forgotten.&rdquo; &mdash;Kristina McMorris,&nbsp;<em>New York Times</em>&nbsp;bestselling author of&nbsp;<em>Sold on a Monday</em></strong><br />
<br />
<strong>Inspired by an astonishing true story from World War II, a young woman with a talent for forgery helps hundreds of Jewish children flee the Nazis in this &ldquo;sweeping and magnificent&rdquo; (Fiona Davis, bestselling author of&nbsp;<em>The Lions of Fifth Avenue</em>) historical novel from the #1 international bestselling author of&nbsp;<em>The Winemaker&rsquo;s Wife</em>.</strong><br />
<br />
Eva Traube Abrams, a semi-retired librarian in Florida, is shelving books when her eyes lock on a photograph in the&nbsp;<em>New York Times</em>. She freezes; it&rsquo;s an image of a book she hasn&rsquo;t seen in more than sixty years&mdash;a book she recognizes as&nbsp;<em>The Book of Lost Names</em>.<br />
<br />
The accompanying article discusses the looting of libraries by the Nazis across Europe during World War II&mdash;an experience Eva remembers well&mdash;and the search to reunite people with the texts taken from them so long ago. The book in the photograph, an eighteenth-century religious text thought to have been taken from France in the waning days of the war, is one of the most fascinating cases. Now housed in Berlin&rsquo;s Zentral- und Landesbibliothek library, it appears to contain some sort of code, but researchers don&rsquo;t know where it came from&mdash;or what the code means. Only Eva holds the answer, but does she have the strength to revisit old memories?<br />
<br />
As a graduate student in 1942, Eva was forced to flee Paris and find refuge in a small mountain town in the Free Zone, where she began forging identity documents for Jewish children fleeing to neutral Switzerland. But erasing people comes with a price, and along with a mysterious, handsome forger named R&eacute;my, Eva decides she must find a way to preserve the real names of the children who are too young to remember who they really are. The records they keep in&nbsp;<em>The Book of Lost Names</em>&nbsp;will become even more vital when the resistance cell they work for is betrayed and R&eacute;my disappears.<br />
<br />
An engaging and evocative novel reminiscent of&nbsp;<em>The Lost Girls of Paris</em>&nbsp;and&nbsp;<em>The Alice Network</em>,&nbsp;<em>The Book of Lost Names&nbsp;</em>is a testament to the resilience of the human spirit and the power of bravery and love in the face of evil.</p>
', CAST(N'2022-01-12T16:29:41.880' AS DateTime), 1, CAST(N'2022-01-15T00:00:00.000' AS DateTime), 17)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10041, N'Vụ Án Mạng Ở Lữ Quán Kairotei', N'vu_an_mang_o_lu_quan_kairotei', NULL, N'54447361._SX318_.jpg', NULL, N'Keigo Higashino', CAST(89000 AS Decimal(18, 0)), NULL, 1000, 3, N'<p style="text-align:justify">Một t&aacute;c phẩm đậm chất trinh th&aacute;m cổ điển vua trinh th&aacute;m Nhật Bản Keigo Higashino.</p>

<p style="text-align:justify">Bản di ch&uacute;c về khối t&agrave;i sản kếch x&ugrave; của &ocirc;ng Ichigahara Takaaki sẽ được c&ocirc;ng bố v&agrave;o đ&uacute;ng lễ 49 ng&agrave;y của &ocirc;ng tại lữ qu&aacute;n Kairotei, nơi sinh thời &ocirc;ng v&ocirc; c&ugrave;ng y&ecirc;u mến. Nhưng một l&aacute; thư h&eacute; lộ sự thật bị ch&ocirc;n v&ugrave;i dưới lớp tro t&agrave;n của vụ hỏa hoạn ở lữ qu&aacute;n n&agrave;y nửa năm trước, xuất hiện đ&uacute;ng buổi tối trước ng&agrave;y c&ocirc;ng bố di ch&uacute;c đ&atilde; khiến mọi chuyện trở n&ecirc;n rối tung. Cũng trong đ&ecirc;m đ&oacute;, một người đ&atilde; bị s&aacute;t hại. Ngọn lửa ngờ vực bắt đầu &acirc;m ỉ ch&aacute;y lan, một thảm kịch kh&aacute;c đ&atilde; được soạn sẵn v&agrave; chờ hồi kết để hạ m&agrave;</p>

<p style="text-align:justify"><span style="color:#ecf0f1"><strong><span style="background-color:#f1c40f">Giới thiệu t&aacute;c giả:</span></strong></span></p>

<p style="text-align:justify">Higashino Keigo l&agrave; tiểu thuyết gia trinh th&aacute;m h&agrave;ng đầu Nhật Bản với nhiều t&aacute;c phẩm h&agrave;ng triệu bản b&aacute;n ra trong v&agrave; ngo&agrave;i nước, gặt h&aacute;i v&ocirc; v&agrave;n giải thưởng. &Ocirc;ng từng l&agrave; Chủ tịch thứ 13 của Hội nh&agrave; văn Trinh th&aacute;m Nhật Bản từ năm 2009 tới năm 2013.</p>

<p style="text-align:justify">Mỗi t&aacute;c phẩm của &ocirc;ng đều c&oacute; phong c&aacute;ch kh&aacute;c nhau, nhưng nh&igrave;n chung đều c&oacute; diễn biến bất ngờ, khắc họa t&acirc;m l&yacute; nh&acirc;n vật s&acirc;u sắc, l&agrave;m n&ecirc;n n&eacute;t ri&ecirc;ng biệt trong chất văn của Higashino Keigo.</p>

<p style="text-align:justify">Gi&aacute; sản phẩm tr&ecirc;n Tiki đ&atilde; bao gồm thuế theo luật hiện h&agrave;nh. B&ecirc;n cạnh đ&oacute;, tuỳ v&agrave;o loại sản phẩm, h&igrave;nh thức v&agrave; địa chỉ giao h&agrave;ng m&agrave; c&oacute; thể ph&aacute;t sinh th&ecirc;m chi ph&iacute; kh&aacute;c như ph&iacute; vận chuyển, phụ ph&iacute; h&agrave;ng cồng kềnh, thuế nhập khẩu (đối với đơn h&agrave;ng giao từ nước ngo&agrave;i c&oacute; gi&aacute; trị tr&ecirc;n 1 triệu đồng).....</p>
', CAST(N'2022-01-15T06:06:38.000' AS DateTime), 1, CAST(N'2022-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10042, N'Những Vụ Kỳ Án Của Sherlock Holmes (Bản Mới 2012)', N'nhung_vu_ky_an_cua_sherlock_holmes__ban_moi_2012_', NULL, N'nhung-vu-ky-an-cua-sherlockholmes.jpg', NULL, N'Conan Doyle', CAST(91000 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), 4000, 3, N'<p style="text-align:justify">Sherlock Holmes l&agrave; một th&aacute;m tử t&agrave;i ba Anh quốc v&agrave; cũng l&agrave; th&aacute;m tử đại t&agrave;i lừng danh thế giới. Do &ocirc;ng c&oacute; c&ocirc;ng kh&aacute;m ph&aacute; c&aacute;c vụ kỳ &aacute;n n&ecirc;n đ&atilde; được ho&agrave;ng gia Anh phong tước. &Ocirc;ng l&agrave; một th&acirc;n sỹ nước Anh rất c&oacute; tr&aacute;ch nhiệm với x&atilde; hội, l&agrave; điển h&igrave;nh của thời đại Victoria.</p>

<p style="text-align:justify">Sherlock Holmes, nh&agrave; th&aacute;m tử lừng danh nhất thế giới bất tử! &Ocirc;ng sống c&ugrave;ng với những vụ &aacute;n ly kỳ, h&oacute;c b&uacute;a, biến ho&aacute; v&ocirc; c&ugrave;ng v&agrave; cũng lắm dữ dội, hiểm nguy m&agrave; ở đ&oacute; &ocirc;ng thể hiện t&agrave;i ba ph&aacute; &aacute;n phi ph&agrave;m của m&igrave;nh. &Ocirc;ng được độc giả h&acirc;m mộ tới mức đ&atilde; c&oacute; rất nhiều hội những người h&acirc;m mộ &ocirc;ng được th&agrave;nh lập.</p>

<p style="text-align:justify">Cuốn s&aacute;ch cuốn h&uacute;t c&aacute;c bạn trẻ c&ograve;n bởi lối kể chuyện nhẹ nh&agrave;ng nhưng b&iacute; hiểm v&agrave; v&ocirc; c&ugrave;ng th&ocirc;ng minh.&nbsp;<strong>&quot;Những vụ kỳ &aacute;n của Sherlock Holmes&quot;</strong>&nbsp;đưa ch&uacute;ng ta sống c&ugrave;ng những vụ &aacute;n ly kỳ, h&oacute;c b&uacute;a, biến ho&aacute; v&ocirc; c&ugrave;ng, v&agrave; cũng lắm dữ dội, hiểm nguy, m&agrave; ở đ&oacute; &ocirc;ng thể hiện t&agrave;i ba ph&aacute; &aacute;n phi ph&agrave;m của m&igrave;nh.</p>

<p style="text-align:justify">...</p>

<p style="text-align:justify"><strong>Mời c&aacute;c bạn đ&oacute;n đọc!</strong></p>
', CAST(N'2022-01-15T06:09:35.300' AS DateTime), 1, CAST(N'2022-01-20T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10043, N'Chính Trị Luận (Tái Bản 2018)', N'chinh_tri_luan__tai_ban_2018_', NULL, N'chinh_tri_luan_tai_ban_2018_1_2018_08_03_10_50_26.jpg', NULL, N'Aristotle', CAST(125000 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)), 4995, 5, N'<p style="text-align:justify"><strong>Ch&iacute;nh Trị Luận (T&aacute;i Bản 2018)</strong></p>

<p style="text-align:justify">T&aacute;c phẩm nổi tiếng viết về c&aacute;c kh&aacute;i niệm m&agrave; từ đ&oacute; định h&igrave;nh c&aacute;c quốc gia v&agrave; ch&iacute;nh phủ. Mặc d&ugrave;, Aristotle cổ vũ mạnh mẽ cho chế độ n&ocirc; lệ lạc hậu, quan điểm của &ocirc;ng về Hiến ph&aacute;p v&agrave; c&aacute;ch điều h&agrave;nh ch&iacute;nh phủ lại rất kinh điển. D&ugrave; chỉ thảo luận về nh&agrave; nước v&agrave; c&aacute;c định chế thời Hy Lạp cổ nhưng t&aacute;c phẩm n&agrave;y của &ocirc;ng đ&atilde; đặt nền tảng cho khoa học ch&iacute;nh trị hiện đại</p>

<p style="text-align:justify">T&aacute;c phẩm n&agrave;y được xem l&agrave; căn bản cho Ch&iacute;nh trị học T&acirc;y phương. Ch&iacute;nh trị luận nghi&ecirc;n cứu c&aacute;c vấn đề cơ bản về nh&agrave; nước, ch&iacute;nh quyền, ch&iacute;nh trị, tự do, c&ocirc;ng bằng, t&agrave;i sản, quyền, luật v&agrave; việc thực thi luật ph&aacute;p của c&aacute;c cơ quan thẩm quyền.</p>

<p style="text-align:justify">Aristotle l&agrave; biểu tượng của tr&iacute; tuệ tư duy triết học. Mặc d&ugrave; nội dung rất s&acirc;u sắc nhưng c&aacute;ch tr&igrave;nh b&agrave;y của &ocirc;ng lại rất dễ hiểu. &Ocirc;ng viết những suy nghĩ của m&igrave;nh một c&aacute;ch r&otilde; r&agrave;ng với độ ch&iacute;nh x&aacute;c si&ecirc;u ph&agrave;m. Học thuyết của &ocirc;ng c&oacute; ảnh hưởng lớn đến những lĩnh vực hiện đại như : khoa học, chủ nghĩa duy thực v&agrave; logic học</p>

<p style="text-align:justify">Theo Aristotle, l&agrave; một người tốt kh&ocirc;ng th&ocirc;i chưa đủ. Nếu người d&acirc;n tốt m&agrave; kh&ocirc;ng t&iacute;ch cực tham gia v&agrave;o đời sống ch&iacute;nh trị của chế độ th&igrave; chế độ đ&oacute; c&oacute; cơ nguy trở th&agrave;nh tho&aacute;i h&oacute;a v&agrave; trở th&agrave;nh một chế độ xấu. &ndash; Dịch giả N&ocirc;ng Duy Trường</p>
', CAST(N'2022-01-15T06:12:40.840' AS DateTime), 1, NULL, 5)
INSERT [dbo].[Product] ([ID], [Name], [MetaTitle], [Description], [Image], [MoreImages], [Authors], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreatedDate], [Status], [TopHot], [ViewCout]) VALUES (10044, N'Địa Chính Trị Của Loài Muỗi - Khái Lược Về Toàn Cầu Hóa', N'dia_chinh_tri_cua_loai_muoi_-_khai_luoc_ve_toan_cau_hoa', NULL, N'b4__24207.jpg', NULL, N'Erik Orsenna', CAST(85000 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), 4000, 5, N'<p style="text-align:justify">Từ 250 triệu năm trước, muỗi đ&atilde; c&oacute; mặt tr&ecirc;n Tr&aacute;i đất, vậy nhưng ch&uacute;ng chẳng n&aacute;n lại l&acirc;u la g&igrave;: v&ograve;ng đời trung b&igrave;nh của một con muỗi l&agrave; 30 ng&agrave;y. Rất đ&ocirc;ng đ&uacute;c (3564 lo&agrave;i), c&oacute; mặt tr&ecirc;n khắp c&aacute;c ch&acirc;u lục, ch&uacute;ng giết người v&ocirc; tội vạ (750 000 người mỗi năm)! Khi ch&uacute;ng vo ve b&ecirc;n tai ta th&igrave; kh&ocirc;ng phải chỉ l&agrave; để quấy rầy giấc khuya của ta, m&agrave; c&ograve;n l&agrave; để kể cho ch&uacute;ng ta một c&acirc;u chuyện : c&acirc;u chuyện về những đường bi&ecirc;n giới bị x&oacute;a nh&ograve;a, về những đột biến kh&ocirc;ng ngừng, về những cuộc chiến đấu để sinh tồn. V&agrave; đặc biệt l&agrave; c&acirc;u chuyện tay ba giữa muỗi, k&yacute; sinh tr&ugrave;ng v&agrave; con mồi (ch&iacute;nh l&agrave; ch&uacute;ng ta).<br />
<br />
C&acirc;u chuyện của lo&agrave;i muỗi trong bối cảnh to&agrave;n cầu h&oacute;a được Erik Orsenna kể lại một c&aacute;ch h&agrave;i hước v&agrave; v&ocirc; c&ugrave;ng chi tiết khiến độc giả vừa sợ h&atilde;i trước những căn bệnh do lo&agrave;i vật b&eacute; nhỏ n&agrave;y l&acirc;y truyền, vừa th&aacute;n phục trước khả năng th&iacute;ch ứng th&ocirc;ng minh tuyệt vời của ch&uacute;ng để sinh tồn.</p>

<p style="text-align:justify">Gi&aacute; sản phẩm tr&ecirc;n Tiki đ&atilde; bao gồm thuế theo luật hiện h&agrave;nh. B&ecirc;n cạnh đ&oacute;, tuỳ v&agrave;o loại sản phẩm, h&igrave;nh thức v&agrave; địa chỉ giao h&agrave;ng m&agrave; c&oacute; thể ph&aacute;t sinh th&ecirc;m chi ph&iacute; kh&aacute;c như ph&iacute; vận chuyển, phụ ph&iacute; h&agrave;ng cồng kềnh, thuế nhập khẩu (đối với đơn h&agrave;ng giao từ nước ngo&agrave;i c&oacute; gi&aacute; trị tr&ecirc;n 1 triệu đồng).....</p>
', CAST(N'2022-01-15T06:16:18.497' AS DateTime), 1, CAST(N'2022-01-18T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (1, N'Kĩ năng sống', N'life_skills.png', N'ki_nang_song', 1, CAST(N'2021-12-11T22:38:33.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (2, N'Tâm lý', N'du-hoc-singapore-nganh-tam-ly.jpg', N'tam_ly', 2, CAST(N'2021-12-11T22:38:50.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (3, N'Trinh thám', N'detective-concepto-personaje-sombrero-ilustracion-dibujos-animados_201904-600.jpg', N'trinh_tham', 3, CAST(N'2021-12-11T22:38:56.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (4, N'Viễn tưởng', N'235645.png', N'vien_tuong', 4, CAST(N'2021-12-11T22:38:59.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (5, N'Chính trị', N'2362.jpg', N'chinh_tri', 5, CAST(N'2021-12-11T22:39:01.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (6, N'Khởi nghiệp', N'Cac-buoc-khoi-nghiep.jpg', N'khoi_nghiep', 6, CAST(N'2021-12-11T22:39:06.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (7, N'Lịch sử', N'97950.png', N'lich_su', 7, CAST(N'2021-12-11T22:39:08.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (8, N'Truyện ngắn', N'phan-tich-truyen-ngan-chiec-luoc-nga.jpg', N'truyen_ngan', 8, CAST(N'2021-12-11T22:39:31.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (9, N'Khoa học', N'science.jpg', N'khoa_hoc', 9, CAST(N'2021-12-11T22:39:39.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (10, N'Kinh tế', N'gorgi-krlev-reconceptualizing-social-econ-737x737.jpg', N'kinh_te', 10, CAST(N'2021-12-11T22:39:41.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (12, N'Công nghệ thông tin', N'unnamed.jpg', N'cong_nghe_thong_tin', 11, CAST(N'2021-12-19T19:54:21.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (14, N'Ngôn tình', N'true-love-real-love.jpg', N'ngon_tinh', 12, CAST(N'2021-12-19T20:37:41.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (15, N'Khoa học kĩ thuật', N'1600228399536-co-cau-to-chuc-phong-ky-thuat-gom-nhung-gi-3.jpg', N'khoa_hoc_ki_thuat', 13, CAST(N'2021-12-29T09:25:44.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (16, N'Khoa học tự nhiên', N'science-fair-nature-research-artwork-physics-removebg-preview.png', N'khoa_hoc_tu_nhien', 14, CAST(N'2021-12-30T10:20:57.000' AS DateTime), NULL, 1)
INSERT [dbo].[ProductCategory] ([ID], [Name], [Image], [MetaTitle], [DisplayOrder], [CreatedDate], [CreatedBy], [Status]) VALUES (17, N'Văn học', N'JASMINE-DAYS_spread.jpg', N'van_hoc', 6, CAST(N'2021-12-30T11:29:04.610' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([ID], [Name]) VALUES (1, N'VIEW')
INSERT [dbo].[Roles] ([ID], [Name]) VALUES (2, N'EDIT')
INSERT [dbo].[Roles] ([ID], [Name]) VALUES (5, N'DELETE')
INSERT [dbo].[Roles] ([ID], [Name]) VALUES (6, N'CREATE')
INSERT [dbo].[Roles] ([ID], [Name]) VALUES (7, N'ADMIN')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Slide] ON 

INSERT [dbo].[Slide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (12, N'/Assets/Client/images/slide-1-image.png', 1, N'\', N'Get to Know More About Our Memorable Services Lorem Ipsum is simply dummy text
Shop Now
CLEARANCE
SALE
UPTo 40% OFF
Get to Know More About Our Memorable Services', CAST(N'2021-12-11T23:41:08.250' AS DateTime), 1)
INSERT [dbo].[Slide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (13, N'/Assets/Client/images/slide-2-image.jpg', 2, N'\', N'Get to Know More About Our Memorable Services Lorem Ipsum is simply dummy text
Shop Now
CLEARANCE
SALE
UPTo 40% OFF
Get to Know More About Our Memorable Services', CAST(N'2021-12-11T23:43:54.397' AS DateTime), 1)
INSERT [dbo].[Slide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (14, N'/Assets/Client/images/slide-3-image.jpg', 3, N'\', N'Get to Know More About Our Memorable Services Lorem Ipsum is simply dummy text
Shop Now
CLEARANCE
SALE
UPTo 40% OFF
Get to Know More About Our Memorable Services', CAST(N'2021-12-11T23:43:54.397' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Slide] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (1, N'iamcaominhtien', N'202cb962ac59075b964b07152d234b70', N'Cao Minh Tien', N'To 17', N'iamcaominhtien@gmail.com', N'0935839613', CAST(N'2022-01-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (2, N'cmtienabc2', N'fcea920f7412b5da7be0cf42b8c93759', N'Cao Tien', N'23/10 street', N'cmtienc2@gmail.com', N'0935839613', CAST(N'2021-12-14T10:16:54.927' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (3, N'nguyenchienthang', N'e10adc3949ba59abbe56e057f20f883e', N'Nguyễn Chiến Thắng', N'To 17 23/10', N'ncthang@gmail.com', N'0935839613', CAST(N'2022-01-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (4, N'lethithuphuong', N'60629c9c7c1e03fcfec6c91d404bef3a', N'Lê Thị Thu Phương', N'Phu Yen', N'lethithuphuong@gmail.com', N'0935839631', CAST(N'2022-01-07T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (5, N'lethihuyenkhanh', N'dd082859a8bb2373e654d095d69e047b', N'Lê Thị Huyền Khanh', N'Cần Thơ', N'lethihuyenkhanh@gmail.com', N'0933123212', CAST(N'2022-01-08T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (7, N'nnngan', N'81dc9bdb52d04dc20036dbd8313ed055', N'Nguyễn Ngọc Nganh', N'Cà Mau', N'nguyenngocngan@gmail.com', N'0935839613', CAST(N'2022-01-09T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (8, N'taylorswift', N'cec2141fca511f27c06f55a244c108d9', N'New York', N'Lạng Giang', N'iamtaylor@gmail.com', N'0935839614', CAST(N'2022-01-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (10, N'luckyluck', N'202cb962ac59075b964b07152d234b70', N'California', N'Bắc Ninh', N'luckyluck@gmail.com', N'0935839633', CAST(N'2022-01-11T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (11, N'katyperry', N'e6c528e8f88f6a47668963a5b860b2b7', N'London', N'USA', N'katyperry@gmail.com', N'0935839652', CAST(N'2022-01-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (12, N'cmtien', N'fcea920f7412b5da7be0cf42b8c93759', N'Cao Minh Tien', N'Phú Quốc', N'cmtienabc2@gmail.com', N'0935839613', CAST(N'2022-01-06T07:41:58.563' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (15, N'nvan', N'fcea920f7412b5da7be0cf42b8c93759', N'Nguyen Van An', N'Ninh Bình', N'nvan@gmail.com', N'0935839613', CAST(N'2022-01-06T09:37:20.967' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (16, N'ntan', N'202cb962ac59075b964b07152d234b70', N'Nguyen Thien An', N'To 17', N'nguyenthienan@gmail.com', N'0328386527', CAST(N'2021-12-27T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (17, N'ltynhu', N'202cb962ac59075b964b07152d234b70', N'Lê Thị Ý Như', N'Võ Dõng', N'ltynhu@gmail.com', N'0328386528', CAST(N'2021-12-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (18, N'tmthuan', N'202cb962ac59075b964b07152d234b70', N'Tran Minh Thuan', N'Binh Cang', N'tranminhthuan@gmail.com', N'0328386528', CAST(N'2021-12-15T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (19, N'lqvinh', N'202cb962ac59075b964b07152d234b70', N'Le Quang Vinh', N'Vinh Trung', N'lequangvinh@gmail.cim', N'0328386529', CAST(N'2021-12-16T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (20, N'lthang', N'202cb962ac59075b964b07152d234b70', N'Le Thi Hang', N'Vinh Diem Trung', N'lethihang@gmail.com', N'0328386530', CAST(N'2021-12-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (21, N'ltttam', N'202cb962ac59075b964b07152d234b70', N'Le Thi Thanh Tam', N'Nha Trang', N'lethithanhtam@gmail.com', N'0328386522', CAST(N'2021-12-27T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (22, N'nhanh', N'202cb962ac59075b964b07152d234b70', N'Nguyen Hong Anh', N'Nha Trang', N'nguyenhonganh@gmail.com', N'0328386533', CAST(N'2021-12-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (23, N'btttruc', N'202cb962ac59075b964b07152d234b70', N'Bùi Thị Thanh Trúc', N'Võ Dõng', N'buithithanhtruc@gmail.com', N'0328386534', CAST(N'2021-12-29T06:50:39.410' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (24, N'vnhtram', N'202cb962ac59075b964b07152d234b70', N'Võ Nguyễn Hoàng Trâm', N'Tổ 18', N'vonguyenhoangtram@gmail.com', N'0328386535', CAST(N'2021-12-29T06:50:39.410' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (25, N'natuan', N'202cb962ac59075b964b07152d234b70', N'Nguyễn Anh Tuấn', N'Tổ 7', N'nguyenanhtuan', N'0328386536', CAST(N'2021-12-29T06:50:39.410' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (26, N'ttphien', N'202cb962ac59075b964b07152d234b70', N'Trương Thị Phương HIền', N'Nha Trang', N'truongthiphuonghien@gmail.com', N'0328386537', CAST(N'2021-12-29T06:50:39.410' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (27, N'nthhanh', N'202cb962ac59075b964b07152d234b70', N'Nguyễn Thị Hồng Hạnh', N'Tổ 6', N'nguyenthihonghanh@gmail.com', N'0328386538', CAST(N'2021-12-29T06:50:39.410' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (28, N'tkathi', N'202cb962ac59075b964b07152d234b70', N'Tống Kiều Anh Thi', N'Vĩnh Trung', N'tongkieuanhthi@gmail.com', N'0328386539', CAST(N'2021-12-29T06:50:39.410' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (30, N'dangtrucanh', N'858151bf6bf02775dbed595bc0ee5452', N'Đặng Trúc Anh', N'Tổ 17', N'dangtrucanh@gmail.com', N'1236545', CAST(N'2022-01-12T13:48:33.653' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (36, N'nthoai', N'fcea920f7412b5da7be0cf42b8c93759', N'Nguyễn Thu Hoài', N'Tổ 16 Vĩnh Hiệp - Nha Trang', N'nthoai@gmail.com', N'0328526357', CAST(N'2022-01-12T18:21:37.650' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (37, N'qtdanh', N'fcea920f7412b5da7be0cf42b8c93759', N'Quách Thành Danh', N'Tổ 16 Vĩnh Hiệp - Nha Trang', N'qtdanh@gmail.com', N'012345678', CAST(N'2022-01-13T21:56:45.303' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (38, N'qta', N'fcea920f7412b5da7be0cf42b8c93759', N'Quách Thành Anh', N'Vĩnh Phương, Nha Trang', N'qtanh@gmail.com', N'0321456987', CAST(N'2022-01-13T22:16:42.987' AS DateTime), 0)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (39, N'dvlam', N'fcea920f7412b5da7be0cf42b8c93759', N'Đặng Văn Lâm', N'Tổ 16 Vĩnh Hiệp - Nha Trang', N'dvlam@gmail.com', N'0328526357', CAST(N'2022-01-14T23:40:41.087' AS DateTime), 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (40, N'nthoainam', N'fcea920f7412b5da7be0cf42b8c93759', N'Nguyễn Thu Hoài', N'Tổ 16 Vĩnh Hiệp - Nha Trang', N'nthoainam@gmail.com', N'0328526357', CAST(N'2022-01-15T00:48:50.880' AS DateTime), 0)
INSERT [dbo].[User] ([ID], [UserName], [Password], [Name], [Address], [Email], [Phone], [CreatedDate], [Status]) VALUES (42, N'nguyenthuhoai', N'fcea920f7412b5da7be0cf42b8c93759', N'Nguyễn Thu Hoài', N'Võ Dõng', N'nguyenthuhoai@gmail.com', N'0328526357', CAST(N'2022-01-15T07:33:52.570' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Order_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ManagerGroup] ADD  CONSTRAINT [DF_ManagerGroup_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ManagerGroup] ADD  CONSTRAINT [DF_ManagerGroup_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ViewCout]  DEFAULT ((0)) FOR [ViewCout]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_CreatedBy]  DEFAULT (N'Admin') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Slide] ADD  CONSTRAINT [DF_Slide_DisplayOrder]  DEFAULT ((1)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[Slide] ADD  CONSTRAINT [DF_Slide_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Slide] ADD  CONSTRAINT [DF_Slide_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[User] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Cart] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_Manager_ManagerGroup] FOREIGN KEY([GroupID])
REFERENCES [dbo].[ManagerGroup] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_Manager_ManagerGroup]
GO
ALTER TABLE [dbo].[MappingRole]  WITH CHECK ADD  CONSTRAINT [FK_MappingRole_ManagerGroup] FOREIGN KEY([ManagerGroupID])
REFERENCES [dbo].[ManagerGroup] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MappingRole] CHECK CONSTRAINT [FK_MappingRole_ManagerGroup]
GO
ALTER TABLE [dbo].[MappingRole]  WITH CHECK ADD  CONSTRAINT [FK_MappingRole_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MappingRole] CHECK CONSTRAINT [FK_MappingRole_Roles]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategory] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductCategory]
GO
/****** Object:  StoredProcedure [dbo].[BestSellerProductCategoryThisWeek]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BestSellerProductCategoryThisWeek]
AS
BEGIN
	select Name, t.Quantity
	from ProductCategory,
	(
		select b.CategoryID, sum(a.Quantity) Quantity
		from CartDetail a, Product b, Cart c
		where a.ProductID=b.ID and a.OrderID=c.ID and c.CreatedDate >=(GETDATE()-7)
		group by CategoryID
	) t
	where ProductCategory.ID=t.CategoryID
END
GO
/****** Object:  StoredProcedure [dbo].[ChartNewRegister_LastWeek]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChartNewRegister_LastWeek]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SELECT *
	FROM [BOOKSTORE].[dbo].[User]
	where CreatedDate >= (GETDATE()-14) and CreatedDate <(GETDATE()-7)
	order by CreatedDate

END
GO
/****** Object:  StoredProcedure [dbo].[ChartNewRegister_ThisWeek]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChartNewRegister_ThisWeek]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SELECT *
	FROM [BOOKSTORE].[dbo].[User]
	where CreatedDate >= (GETDATE()-7)
	order by CreatedDate

END
GO
/****** Object:  StoredProcedure [dbo].[CheckUserCart]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckUserCart]
	-- Add the parameters for the stored procedure here
	@CustomerID int
AS
BEGIN
	select OrderID,CustomerID,ProductID,Quantity
	from cart as a, cartdetail as b
	where a.CustomerID=@CustomerID and a.ID=b.OrderID and a.status=1
END
GO
/****** Object:  StoredProcedure [dbo].[DetailProduct]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[DetailProduct]
	-- Add the parameters for the stored procedure here
	@cateid int
AS
BEGIN
	select *
	from Product
	where ID=@cateid and Status=1
END
GO
/****** Object:  StoredProcedure [dbo].[GET_CARTDETAIL]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_CARTDETAIL]
	-- Add the parameters for the stored procedure here
	@productID INT,
	@orderID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT *
	FROM CartDetail
	WHERE ProductID=@productID AND OrderID=@orderID
END
GO
/****** Object:  StoredProcedure [dbo].[GET_LISTPRODUCT_CANPAGING]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[GET_LISTPRODUCT_CANPAGING]
	-- Add the parameters for the stored procedure here
	@CateID INT,
	@skip int,
	@pageSize int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select *
	from Product
	where CategoryID=@CateID
	order by CreatedDate
	OFFSET (@skip) ROWS FETCH NEXT (@pageSize) ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[Get_PromotionProduct]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_PromotionProduct] 
	-- Add the parameters for the stored procedure here
	@cateID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select *
	from Product
	where (PromotionPrice is not null) and CategoryID=@cateID
	order by PromotionPrice desc
END
GO
/****** Object:  StoredProcedure [dbo].[GET_USERCART]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_USERCART]
	-- Add the parameters for the stored procedure here
	@CustomerID INT,
	@Status int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	if @Status is not null
		SELECT B.OrderID, B.ProductID, B.Quantity
		FROM Cart A, CartDetail B
		WHERE A.ID=B.OrderID AND A.Status=@Status AND A.CustomerID=@CustomerID
	else 
		SELECT B.OrderID, B.ProductID, B.Quantity
		FROM Cart A, CartDetail B
		WHERE A.ID=B.OrderID AND A.CustomerID=@CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[GET_USERCART_ALL]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_USERCART_ALL]
	-- Add the parameters for the stored procedure here
	@CustomerID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT B.OrderID, B.ProductID, B.Quantity
	FROM Cart A, CartDetail B
	WHERE A.ID=B.OrderID AND A.CustomerID=@CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[GET_USERCART_CANPAGING]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_USERCART_CANPAGING]
	-- Add the parameters for the stored procedure here
	@CustomerID INT,
	@skip int,
	@pageSize int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT B.OrderID, B.ProductID, B.Quantity
	FROM Cart A, CartDetail B
	WHERE A.ID=B.OrderID AND A.CustomerID=@CustomerID
	order by a.CreatedDate
	OFFSET (@skip) ROWS FETCH NEXT (@pageSize) ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetManagerByUserName]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetManagerByUserName]
	@param1 varchar(50)
AS
	SELECT *
	FROM Manager
	WHERE UserName=@param1
GO
/****** Object:  StoredProcedure [dbo].[GetUserCart_ByCartID]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserCart_ByCartID]
	-- Add the parameters for the stored procedure here
	@CartID int
AS
BEGIN
	SELECT B.OrderID, B.ProductID, B.Quantity
	FROM Cart A, CartDetail B
	WHERE A.ID=B.OrderID and A.ID=@CartID
END
GO
/****** Object:  StoredProcedure [dbo].[HotProduct]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HotProduct]
AS
BEGIN
	SELECT *
	FROM Product
	WHERE Status=1 and TopHot>=GETDATE()
	order by CreatedDate

END
GO
/****** Object:  StoredProcedure [dbo].[LatestProducts]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LatestProducts]
AS
BEGIN
	SELECT top(15) *
	FROM Product
	WHERE Status=1
	order by CreatedDate desc
END
GO
/****** Object:  StoredProcedure [dbo].[ListProductByCategory]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListProductByCategory]
	@cate_id int
AS
BEGIN
	SELECT *
	FROM Product
	WHERE CategoryID=@cate_id and Status=1 
END
GO
/****** Object:  StoredProcedure [dbo].[ListProductCategoryByStatus]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListProductCategoryByStatus]
AS
BEGIN
	SELECT *
	FROM ProductCategory
	WHERE Status=1
	order by DisplayOrder
END
GO
/****** Object:  StoredProcedure [dbo].[Product_BestSeller]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Product_BestSeller]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	select k.Name, k.Quantity, a.Price, a.Image
	from 
	(
		select Top(8) Name, sum(Quantity) Quantity
		from (
			select Name, b.Quantity
			from Product a
			inner join CartDetail b on a.ID=b.ProductID
			inner join Cart c on c.ID=b.OrderID and c.CreatedDate>=(GETDATE()-7)
		) ProductBestSeller
		group by Name
		order by Quantity desc
	) k
	inner join Product a on k.Name=a.Name
	order by Quantity desc

END
GO
/****** Object:  StoredProcedure [dbo].[RelatedProduct]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelatedProduct]
	-- Add the parameters for the stored procedure here
	@productID int
AS
BEGIN
	select top 4 *
	from Product
	where ID!=@productID and Status=1 and CategoryID=(
		select CategoryID
		from Product
		where ID=@productID
	)
END
GO
/****** Object:  StoredProcedure [dbo].[SaleChartLastWeek]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaleChartLastWeek] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	select CreatedDate,sum(Price*Quantity) Price
	from (
		select CONVERT(date,a.CreatedDate) CreatedDate,c.Price,b.Quantity
		from Cart a, CartDetail b, Product c
		where a.ID=b.OrderID and b.ProductID=c.ID and a.CreatedDate>=(GETDATE()-14) and a.CreatedDate<(GETDATE()-7)
	) t
	group by CreatedDate
END
GO
/****** Object:  StoredProcedure [dbo].[SaleChartThisWeek]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaleChartThisWeek] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	select CreatedDate,sum(Price*Quantity) Price
	from (
		select CONVERT(date,a.CreatedDate) CreatedDate,c.Price,b.Quantity
		from Cart a, CartDetail b, Product c
		where a.ID=b.OrderID and b.ProductID=c.ID and a.CreatedDate>=(GETDATE()-7)
	) t
	group by CreatedDate
END
GO
/****** Object:  StoredProcedure [dbo].[Search_Cart]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Search_Cart]
    @name nvarchar(100)='',
	@status varchar(1)='',
	@fromDate varchar(20) = '',
	@toDate varchar(20)=''
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT c.ID,c.CreatedDate,u.Name,c.Status
       FROM Cart c, [BOOKSTORE].[dbo].[User] u
       WHERE c.CustomerID=u.ID
       '
IF @name !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (u.Name LIKE N''%'+@name+'%'')
              '
IF @status !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (c.Status = '+@status+')
              '
IF @fromDate !=''  
       SELECT @SqlStr = @SqlStr + '
             AND (cast(c.CreatedDate as date) >= '''+@fromDate+''')
             '
IF @toDate !=''  
       SELECT @SqlStr = @SqlStr + '
             AND (cast(c.CreatedDate as date) <= '''+@toDate+''')
             '
	EXEC SP_EXECUTESQL @SqlStr
END
GO
/****** Object:  StoredProcedure [dbo].[Search_ManagerGroup]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Search_ManagerGroup]
    @searchString varchar(50)='',
	@status varchar(1)='',
	@fromDate varchar(20) = '',
	@toDate varchar(20)=''
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM ManagerGroup
       WHERE  (1=1)
       '
IF @searchString !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Name LIKE ''%'+@searchString+'%'')
              '
IF @status !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Status = '+@status+')
              '
IF @fromDate !=''  
       SELECT @SqlStr = @SqlStr + '
             AND (cast(CreatedDate as date) >= '''+@fromDate+''')
             '
IF @toDate !=''  
       SELECT @SqlStr = @SqlStr + '
             AND (cast(CreatedDate as date) <= '''+@toDate+''')
             '
	EXEC SP_EXECUTESQL @SqlStr
END
GO
/****** Object:  StoredProcedure [dbo].[SEARCH_MANAGERS]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SEARCH_MANAGERS]
	-- Add the parameters for the stored procedure here
	@NAME nvarchar(100)='',
	@USERNAME VARCHAR(50)='',
	@STATUS varchar(1)='',
	@MANAGERGROUP VARCHAR(20)=''
AS
begin
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM Manager
       WHERE (1=1)
       '
IF @NAME !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (SirName+'' ''+FirstName LIKE N''%'+@NAME+'%'')
              '
IF @USERNAME !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (UserName LIKE ''%'+@USERNAME+'%'')
              '
IF @STATUS !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Status = '+@STATUS+')
              '
IF @MANAGERGROUP !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (GroupID = '+@MANAGERGROUP+')
              '
EXEC SP_EXECUTESQL @SqlStr

END
GO
/****** Object:  StoredProcedure [dbo].[SEARCH_PRODUCT]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SEARCH_PRODUCT]
	-- Add the parameters for the stored procedure here
	@SEARCH NVARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT Top(10) Name
	FROM Product
	WHERE Name LIKE (N'%'+@SEARCH+'%')
END
GO
/****** Object:  StoredProcedure [dbo].[SEARCH_PRODUCT_BY_KEY]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SEARCH_PRODUCT_BY_KEY]
	-- Add the parameters for the stored procedure here
	@SEARCH NVARCHAR(250),
	@PAGESIZE varchar(20) = '',
	@SKIP varchar(20) = ''
AS
BEGIN
	DECLARE @SqlStr NVARCHAR(4000),
			@ParamList nvarchar(2000)
	SELECT @SqlStr = '
		   SELECT *
		   From Product
		   WHERE (Product.Name LIKE (N''%'+@SEARCH+'%'')) and (Status=1)
		   '
	if (@PAGESIZE !='') and (@SKIP!='')
		SELECT @SqlStr = @SqlStr + '
			  order by CreatedDate desc OFFSET ('+@SKIP+') ROWS FETCH NEXT ('+@PAGESIZE+') ROWS ONLY
              '
	EXEC SP_EXECUTESQL @SqlStr

END
GO
/****** Object:  StoredProcedure [dbo].[SEARCH_PRODUCT_CATEGORY]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SEARCH_PRODUCT_CATEGORY]
	-- Add the parameters for the stored procedure here
	@SEARCH NVARCHAR(250)='',
	@STATUS varchar(1)=''
AS
begin
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM ProductCategory
       WHERE  (1=1)
       '
IF @SEARCH !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Name LIKE N''%'+@SEARCH+'%'')
              '
IF @STATUS !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Status = '+@STATUS+')
              '
set @SqlStr=@SqlStr+' order by CreatedDate desc'

EXEC SP_EXECUTESQL @SqlStr

END
GO
/****** Object:  StoredProcedure [dbo].[SEARCH_PRODUCT_MULTIPLE]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SEARCH_PRODUCT_MULTIPLE]
	-- Add the parameters for the stored procedure here
	@SEARCH NVARCHAR(250)='',
	@STATUS varchar(1)='',
	@MINPRICE VARCHAR(20)='',
	@MAXPRICE VARCHAR(20)='',
	@CATEGORYID VARCHAR(20)=''
AS
begin
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM PRODUCT
       WHERE  (1=1)
       '
IF @SEARCH !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Name LIKE N''%'+@SEARCH+'%'')
              '
IF @STATUS !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Status = '+@STATUS+')
              '
IF @MINPRICE !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (CAST(PRICE AS INT) >= '+@MINPRICE+')
              '
IF @MAXPRICE !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (CAST(PRICE AS INT) <= '+@MAXPRICE+')
              '
IF @CATEGORYID !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (CategoryID = '+@CATEGORYID+')
              '
set @SqlStr=@SqlStr+' order by CreatedDate desc'

EXEC SP_EXECUTESQL @SqlStr

END
GO
/****** Object:  StoredProcedure [dbo].[SEARCH_USERS]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SEARCH_USERS]
	-- Add the parameters for the stored procedure here
	@NAME nvarchar(100)='',
	@ADDRESS nvarchar(100),
	@USERNAME VARCHAR(50)='',
	@STATUS varchar(1)='',
	@EMAIL VARCHAR(50)='',
	@PHONE VARCHAR(50)=''
AS
begin
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
       SELECT * 
       FROM [BOOKSTORE].[dbo].[User]
       WHERE (1=1)
       '
IF @NAME !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Name LIKE N''%'+@NAME+'%'')
              '
IF @USERNAME !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (UserName LIKE ''%'+@USERNAME+'%'')
              '
IF @STATUS !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Status = '+@STATUS+')
              '
IF @ADDRESS !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Address LIKE N''%'+@ADDRESS+'%'')
              '
IF @EMAIL !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Email LIKE ''%'+@EMAIL+'%'')
              '
IF @PHONE !=''  
       SELECT @SqlStr = @SqlStr + '
              AND (Phone LIKE ''%'+@PHONE+'%'')
              '
set @SqlStr=@SqlStr+' order by CreatedDate desc'

EXEC SP_EXECUTESQL @SqlStr

END
GO
/****** Object:  StoredProcedure [dbo].[SortProductByCateID]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SortProductByCateID]
AS
BEGIN
	SELECT *
	FROM Product
	order by CategoryID 
END
GO
/****** Object:  StoredProcedure [dbo].[TopRatedProduct]    Script Date: 1/15/2022 8:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TopRatedProduct]
	@takeval int
AS
BEGIN
	SELECT top (@takeval) *
	FROM Product
	WHERE Status=1 and TopHot>=GETDATE()
	order by ViewCout desc
END
GO
