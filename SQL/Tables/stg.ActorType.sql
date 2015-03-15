USE [GDELT]
GO

/****** Object:  Table [stg].[ActorType]    Script Date: 2015-03-15 11:44:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [stg].[ActorType](
	[ActorTypeKey] [varchar](50) NOT NULL,
	[ActorTypeDescription] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

