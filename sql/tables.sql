/****** Object:  Table [dbo].[DetailData]    Script Date: 22/03/2022 18:00:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetailData](
	[colA] [nvarchar](50) NULL,
	[colB] [nvarchar](50) NULL,
	[colC] [nvarchar](50) NULL,
	[colD] [nvarchar](50) NULL,
	[recordId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[ReportData]    Script Date: 22/03/2022 18:00:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ReportData](
	[colum1data] [nvarchar](50) NULL,
	[colume2data] [nvarchar](50) NULL,
	[colume3data] [nvarchar](50) NULL,
	[colume4data] [nvarchar](50) NULL,
	[colume5data] [nvarchar](50) NULL,
	[recordid] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Table_1]    Script Date: 22/03/2022 18:00:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Table_1](
	[data1] [varchar](50) NULL,
	[result1] [int] NULL,
	[data2] [nvarchar](50) NULL,
	[data3] [nvarchar](50) NULL
) ON [PRIMARY]
GO

