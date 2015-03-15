USE [GDELT]
GO

/****** Object:  Table [GDELT20].[DimActor]    Script Date: 2015-03-15 11:42:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [GDELT20].[DimActor](
	[ActorKey] [int] NOT NULL CONSTRAINT [DFT_DimActorFull_ActorKey]  DEFAULT (NEXT VALUE FOR [dbo].[SeqActorFullKey]),
	[ActorName] [varchar](255) NOT NULL,
	[ActorCode] [varchar](50) NOT NULL,
	[ActorCountryCode] [varchar](50) NULL,
	[ActorCountryDesc] [varchar](255) NULL,
	[ActorKnownGroupCode] [varchar](50) NULL,
	[ActorKnownGroupDesc] [varchar](255) NULL,
	[ActorEthnicCode] [varchar](50) NULL,
	[ActorEthnicDesc] [varchar](255) NULL,
	[ActorReligion1Code] [varchar](50) NULL,
	[ActorReligion1Desc] [varchar](255) NULL,
	[ActorReligion2Code] [varchar](50) NULL,
	[ActorReligion2Desc] [varchar](255) NULL,
	[ActorType1Code] [varchar](50) NULL,
	[ActorType1Desc] [varchar](255) NULL,
	[ActorType2Code] [varchar](50) NULL,
	[ActorType2Desc] [varchar](255) NULL,
	[ActorType3Code] [varchar](50) NULL,
	[ActorType3Desc] [varchar](255) NULL,
 CONSTRAINT [PK_DimActorFull] PRIMARY KEY CLUSTERED 
(
	[ActorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

