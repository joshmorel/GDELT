USE [GDELT]
GO

/****** Object:  Table [dbo].[DimGeo]    Script Date: 01/02/2015 11:50:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimGeo](
	[GeoKey] [int] NOT NULL,
	[GeoFullname] [varchar](255) NULL,
	[GeoCountryCode] [varchar](4) NULL,
	[GeoCountryDesc] [varchar](255) NULL,
	[GeoADM1Code] [varchar](4) NULL,
	[GeoADM1Desc] [varchar](255) NULL,
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

ALTER TABLE [dbo].[DimGeo] ADD  CONSTRAINT [DFT_DimGeo_GeoKey]  DEFAULT (NEXT VALUE FOR [dbo].[SeqGeoKey]) FOR [GeoKey]
GO

