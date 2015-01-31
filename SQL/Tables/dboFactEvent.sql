USE [GDELT]
GO

/****** Object:  Table [dbo].[FactEvent]    Script Date: 31/01/2015 12:43:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[FactEvent](
	[FactEventKey] [int] NOT NULL,
	[OccurrenceDateKey] [int] NULL,
	[AddedDateKey] [int] NOT NULL,
	[QuadClassKey] [int] NOT NULL,
	[Actor1Key] [int] NOT NULL,
	[Actor2Key] [int] NOT NULL,
	[IsRootEvent] [tinyint] NULL,
	[EventCodeKey] [int] NOT NULL,
	[Actor1GeoTypeKey] [int] NOT NULL,
	[Actor1GeoNameKey] [int] NOT NULL,
	[Actor1GeoCountryADM1Key] [nchar](4) NOT NULL,
	[Actor1GeoLatitude] [decimal](9, 6) NULL,
	[Actor1GeoLongitude] [decimal](9, 6) NULL,
	[Actor1GeoFeatureKey] [int] NOT NULL,
	[Actor2GeoTypeKey] [int] NOT NULL,
	[Actor2GeoNameKey] [int] NOT NULL,
	[Actor2GeoCountryADM1Key] [nchar](4) NOT NULL,
	[Actor2GeoLatitude] [decimal](9, 6) NULL,
	[Actor2GeoLongitude] [decimal](9, 6) NULL,
	[Actor2GeoFeatureKey] [int] NOT NULL,
	[ActionGeoTypeKey] [int] NOT NULL,
	[ActionGeoNameKey] [int] NOT NULL,
	[ActionGeoCountryADM1Key] [nchar](4) NOT NULL,
	[ActionGeoLatitude] [decimal](9, 6) NULL,
	[ActionGeoLongitude] [decimal](9, 6) NULL,
	[ActionGeoFeatureKey] [int] NOT NULL,
	[GoldsteinScale] [decimal](3, 1) NULL,
	[NumMentions] [int] NULL,
	[NumSources] [int] NULL,
	[NumArticles] [int] NULL,
	[AvgTone] [float] NULL,
	[SourceURL] [varchar](255) NULL,
 CONSTRAINT [PK_FactEvent] PRIMARY KEY CLUSTERED 
(
	[FactEventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

