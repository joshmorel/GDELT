USE [GDELT]
GO

/****** Object:  Table [dbo].[DimActor]    Script Date: 31/01/2015 12:42:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimActor](
	[ActorKey] [int] NOT NULL,
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

ALTER TABLE [dbo].[DimActor] ADD  CONSTRAINT [DFT_DimActorFull_ActorKey]  DEFAULT (NEXT VALUE FOR [dbo].[SeqActorFullKey]) FOR [ActorKey]
GO

