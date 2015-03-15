USE [GDELT]
GO

/****** Object:  Table [stg].[GeoType]    Script Date: 2015-03-15 11:44:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[GeoType](
	[GeoTypeCode] [int] NOT NULL,
	[GeoTypeDesc] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

