USE [GDELT]
GO

/****** Object:  Table [GDELT20].[DimGeo]    Script Date: 2015-03-15 11:42:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [GDELT20].[DimGeo](
	[GeoKey] [int] NOT NULL CONSTRAINT [DFT_DimGeo_GeoKey]  DEFAULT (NEXT VALUE FOR [dbo].[SeqGeoKey]),
	[GeoFullname] [varchar](255) NULL,
	[GeoCountryCode] [varchar](4) NULL,
	[GeoCountryDesc] [varchar](255) NULL,
	[GeoADM1Code] [varchar](4) NULL,
	[GeoADM1Desc] [varchar](255) NULL,
	[GeoADM2Code] [varchar](255) NULL,
	[GeoFeatureID] [varchar](255) NULL,
	[GeoLat] [decimal](9, 6) NULL,
	[GeoLong] [decimal](9, 6) NULL,
	[GeoTypeCode] [int] NULL,
	[GeoTypeDesc] [varchar](255) NULL,
 CONSTRAINT [PK_DimGeo] PRIMARY KEY CLUSTERED 
(
	[GeoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

