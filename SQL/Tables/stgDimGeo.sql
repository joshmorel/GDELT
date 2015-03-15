USE [GDELT]
GO

/****** Object:  Table [stg].[DimGeo]    Script Date: 2015-03-15 11:44:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[DimGeo](
	[GeoFullname] [varchar](255) NOT NULL,
	[GeoCountryCode] [varchar](4) NOT NULL,
	[GeoCountryDesc] [varchar](255) NOT NULL,
	[GeoADM1Code] [varchar](4) NOT NULL,
	[GeoADM1Desc] [varchar](255) NOT NULL,
	[GeoADM2Code] [varchar](255) NOT NULL,
	[GeoFeatureID] [varchar](255) NOT NULL,
	[GeoLat] [decimal](9, 6) NULL,
	[GeoLong] [decimal](9, 6) NULL,
	[GeoTypeCode] [int] NOT NULL,
	[GeoTypeDesc] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

