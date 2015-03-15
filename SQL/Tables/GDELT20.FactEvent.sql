USE [GDELT]
GO

/****** Object:  Table [GDELT20].[FactEvent]    Script Date: 2015-03-15 11:42:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [GDELT20].[FactEvent](
	[FactEventKey] [int] NOT NULL,
	[OccurrenceDateKey] [int] NULL,
	[AddedDateKey] [int] NOT NULL,
	[AddedTimeKey] [int] NULL,
	[QuadClassKey] [int] NOT NULL,
	[Actor1Key] [int] NOT NULL,
	[Actor2Key] [int] NOT NULL,
	[IsRootEvent] [tinyint] NULL,
	[EventCodeKey] [int] NOT NULL,
	[Actor1GeoKey] [int] NOT NULL,
	[Actor2GeoKey] [int] NOT NULL,
	[ActionGeoKey] [int] NOT NULL,
	[GoldsteinScale] [decimal](3, 1) NULL,
	[NumMentions] [int] NULL,
	[NumSources] [int] NULL,
	[NumArticles] [int] NULL,
	[AvgTone] [float] NULL,
	[SourceURL] [varchar](255) NULL,
	[SourceLanguage] [tinyint] NULL,
 CONSTRAINT [PK_FactEvent] PRIMARY KEY CLUSTERED 
(
	[FactEventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

