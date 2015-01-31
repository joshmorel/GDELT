USE [GDELT]
GO

/****** Object:  Table [stg].[ActorCountry]    Script Date: 31/01/2015 11:08:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[ActorCountry](
	[CountryKey] [varchar](50) NOT NULL,
	[CountryDescription] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

