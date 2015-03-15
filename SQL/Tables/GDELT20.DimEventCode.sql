USE [GDELT]
GO

/****** Object:  Table [GDELT20].[DimEventCode]    Script Date: 2015-03-15 11:42:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [GDELT20].[DimEventCode](
	[EventCodeKey] [int] NOT NULL,
	[EventCode] [varchar](10) NOT NULL,
	[EventDescription] [varchar](255) NOT NULL,
	[EventBaseCode] [varchar](10) NOT NULL,
	[EventBaseDescription] [varchar](255) NOT NULL,
	[EventRootCode] [varchar](10) NOT NULL,
	[EventRootDescription] [varchar](255) NOT NULL,
 CONSTRAINT [PK_DimEventCode] PRIMARY KEY CLUSTERED 
(
	[EventCodeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

