USE [GDELT]
GO

/****** Object:  Table [dbo].[DimEventCode]    Script Date: 13/01/2015 6:54:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimEventCode](
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

