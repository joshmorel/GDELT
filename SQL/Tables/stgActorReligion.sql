USE [GDELT]
GO

/****** Object:  Table [stg].[ActorReligion]    Script Date: 31/01/2015 11:09:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[ActorReligion](
	[ReligionKey] [varchar](50) NOT NULL,
	[ReligionDescription] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

