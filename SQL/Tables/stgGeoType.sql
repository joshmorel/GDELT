USE [GDELT]
GO

/****** Object:  Table [stg].[GeoType]    Script Date: 01/02/2015 11:48:31 AM ******/
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

