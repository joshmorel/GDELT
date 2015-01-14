USE [GDELT]
GO

/****** Object:  Table [stg].[DailyEventImportFailure]    Script Date: 13/01/2015 6:55:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[DailyEventImportFailure](
	[ErrorCode] [int] NULL,
	[ErrorDescription] [varchar](255) NULL,
	[ErrorOutputColumns] [varchar](max) NULL,
	[ErrorColumn] [int] NULL,
	[ErrorColumnName] [varchar](255) NULL,
	[GlobalEventID] [varchar](255) NULL,
	[Day] [varchar](255) NULL,
	[MonthYear] [varchar](255) NULL,
	[Year] [varchar](255) NULL,
	[FractionDate] [varchar](255) NULL,
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
	[IsRootEvent] [varchar](255) NULL,
	[EventCode] [varchar](255) NULL,
	[EventBaseCode] [varchar](255) NULL,
	[EventRootCode] [varchar](255) NULL,
	[QuadClass] [varchar](255) NULL,
	[GoldsteinScale] [varchar](255) NULL,
	[NumMentions] [varchar](255) NULL,
	[NumSources] [varchar](255) NULL,
	[NumArticles] [varchar](255) NULL,
	[AvgTone] [varchar](255) NULL,
	[Actor1Geo_Type] [varchar](255) NULL,
	[Actor1Geo_Fullname] [varchar](255) NULL,
	[Actor1Geo_CountryCode] [varchar](255) NULL,
	[Actor1Geo_ADM1Code] [varchar](255) NULL,
	[Actor1Geo_Lat] [varchar](255) NULL,
	[Actor1Geo_Long] [varchar](255) NULL,
	[Actor1Geo_FeatureID] [varchar](255) NULL,
	[Actor2Geo_Type] [varchar](255) NULL,
	[Actor2Geo_Fullname] [varchar](255) NULL,
	[Actor2Geo_CountryCode] [varchar](255) NULL,
	[Actor2Geo_ADM1Code] [varchar](255) NULL,
	[Actor2Geo_Lat] [varchar](255) NULL,
	[Actor2Geo_Long] [varchar](255) NULL,
	[Actor2Geo_FeatureID] [varchar](255) NULL,
	[ActionGeo_Type] [varchar](255) NULL,
	[ActionGeo_Fullname] [varchar](255) NULL,
	[ActionGeo_CountryCode] [varchar](255) NULL,
	[ActionGeo_ADM1Code] [varchar](255) NULL,
	[ActionGeo_Lat] [varchar](255) NULL,
	[ActionGeo_Long] [varchar](255) NULL,
	[ActionGeo_FeatureID] [varchar](255) NULL,
	[DATEADDED] [varchar](255) NULL,
	[SOURCEURL] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

