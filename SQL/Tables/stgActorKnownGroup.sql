USE [GDELT]
GO

/****** Object:  Table [stg].[ActorKnownGroup]    Script Date: 31/01/2015 11:08:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[ActorKnownGroup](
	[KnownGroupKey] [varchar](50) NOT NULL,
	[KnownGroupDescription] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

