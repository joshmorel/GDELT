USE [GDELT]
GO

/****** Object:  Table [stg].[GDELT20DailyEvent]    Script Date: 2015-03-15 11:44:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[GDELT20DailyEvent](
	[GlobalEventID] [int] NOT NULL,
	[Day] [int] NULL,
	[MonthYear] [int] NULL,
	[Year] [int] NULL,
	[FractionDate] [decimal](9, 4) NULL,
	[Actor1Code] [varchar](255) NULL,
	[Actor1Name] [varchar](255) NULL,
	[Actor1CountryCode] [varchar](255) NULL,
	[Actor1KnownGroupCode] [varchar](255) NULL,
	[Actor1EthnicCode] [varchar](255) NULL,
	[Actor1Religion1Code] [varchar](255) NULL,
	[Actor1Religion2Code] [varchar](255) NULL,
	[Actor1Type1Code] [varchar](255) NULL,
	[Actor1Type2Code] [varchar](255) NULL,
	[Actor1Type3Code] [varchar](255) NULL,
	[Actor2Code] [varchar](255) NULL,
	[Actor2Name] [varchar](255) NULL,
	[Actor2CountryCode] [varchar](255) NULL,
	[Actor2KnownGroupCode] [varchar](255) NULL,
	[Actor2EthnicCode] [varchar](255) NULL,
	[Actor2Religion1Code] [varchar](255) NULL,
	[Actor2Religion2Code] [varchar](255) NULL,
	[Actor2Type1Code] [varchar](255) NULL,
	[Actor2Type2Code] [varchar](255) NULL,
	[Actor2Type3Code] [varchar](255) NULL,
	[IsRootEvent] [tinyint] NULL,
	[EventCode] [varchar](255) NULL,
	[EventBaseCode] [varchar](255) NULL,
	[EventRootCode] [varchar](255) NULL,
	[QuadClass] [int] NULL,
	[GoldsteinScale] [decimal](3, 1) NULL,
	[NumMentions] [int] NULL,
	[NumSources] [int] NULL,
	[NumArticles] [int] NULL,
	[AvgTone] [float] NULL,
	[Actor1Geo_Type] [int] NULL,
	[Actor1Geo_Fullname] [varchar](255) NULL,
	[Actor1Geo_CountryCode] [varchar](255) NULL,
	[Actor1Geo_ADM1Code] [varchar](255) NULL,
	[Actor1Geo_ADM2Code] [varchar](255) NULL,
	[Actor1Geo_Lat] [decimal](9, 6) NULL,
	[Actor1Geo_Long] [decimal](9, 6) NULL,
	[Actor1Geo_FeatureID] [varchar](255) NULL,
	[Actor2Geo_Type] [int] NULL,
	[Actor2Geo_Fullname] [varchar](255) NULL,
	[Actor2Geo_CountryCode] [varchar](255) NULL,
	[Actor2Geo_ADM1Code] [varchar](255) NULL,
	[Actor2Geo_ADM2Code] [varchar](255) NULL,
	[Actor2Geo_Lat] [decimal](9, 6) NULL,
	[Actor2Geo_Long] [decimal](9, 6) NULL,
	[Actor2Geo_FeatureID] [varchar](255) NULL,
	[ActionGeo_Type] [int] NULL,
	[ActionGeo_Fullname] [varchar](255) NULL,
	[ActionGeo_CountryCode] [varchar](255) NULL,
	[ActionGeo_ADM1Code] [varchar](255) NULL,
	[ActionGeo_ADM2Code] [varchar](255) NULL,
	[ActionGeo_Lat] [decimal](9, 6) NULL,
	[ActionGeo_Long] [decimal](9, 6) NULL,
	[ActionGeo_FeatureID] [varchar](255) NULL,
	[DATEADDED] [bigint] NULL,
	[SOURCEURL] [varchar](255) NULL,
	[SourceLanguage] [varchar](255) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

