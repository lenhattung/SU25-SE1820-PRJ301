USE [master]
GO
DROP DATABASE [PRJ301_PROJECT1]
GO

CREATE DATABASE [PRJ301_PROJECT1] 
GO

USE [PRJ301_PROJECT1]
GO

CREATE TABLE [dbo].[tblUsers](
	[userID] [nvarchar](50) NOT NULL,
	[fullName] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[roleID] [nvarchar](50) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'admin', N'Administrator', N'1', N'AD', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'hungnq', N'Nguyen Quang Hung', N'1', N'AD', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'se190011', N'Tran Manh Hung', N'hcm', N'MB', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'he181122', N'Hoang Minh Thoa', N'hn', N'MB', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'de175533', N'Vo Thi Hoang Oanh', N'dn', N'MB', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'qe175533', N'Pham Tuan Minh', N'qn', N'MB', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'ce175533', N'Mai Thanh Quan', N'ct', N'MB', 1)
GO


CREATE TABLE [dbo].[tblProducts](
	[id] [char](5) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[price] [float] NOT NULL,
	[size] [nvarchar](50) NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_tblProducts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-001', N'Fashion dresses', N'Fashion dresses for Summer 2025', 285,'L', 1)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-002', N'Men''s shirt', N'VIET TIEN long-sleeve men''s shirt', 115,'M', 1)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-003', N'Short office skirt', N'Short skirt for women''s office wear', 307,'S', 1)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-004', N'Vietnamese Ao Dai', N'Traditional Vietnamese Ao Dai dress', 436,'M', 1)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-005', N'Women''s shirt', N'AN PHUOC Ladies'' White Long-Sleeve Shirt', 155,'S', 0)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-006', N'Men''s jeans', N'Men''s jeans - LEVIS', 327,'L', 1)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-007', N'Women''s trousers', N'An Phuoc Ladies'' Plain Dark Blue Trousers', 235,'M', 1)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-008', N'Men''s blazer', N'Men''s suit jacket', 753,'L', 0)
INSERT [dbo].[tblProducts] ([id], [name], [description], [price], [size], [status]) VALUES (N'F-009', N'Ladies'' t-shirt', N'Ladies'' activewear t-shirt', 270,'S', 1)
GO

-- Thay doi du lieu
-- Them cot: image, type la TEXT
ALTER TABLE tblProducts
ADD COLUMN image TEXT;