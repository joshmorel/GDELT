USE [GDELT]
GO

/****** Object:  Table [SSIS].[ErrorLog]    Script Date: 13/01/2015 6:55:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SSIS].[ErrorLog](
	[Computer] [varchar](255) NULL,
	[Operator] [varchar](255) NULL,
	[SourceName] [varchar](255) NULL,
	[SourceID] [uniqueidentifier] NULL,
	[ExecutionID] [uniqueidentifier] NULL,
	[MessageText] [varchar](max) NULL,
	[DataBytes] [int] NULL,
	[StartTime] [datetime2](3) NULL,
	[EndTime] [datetime2](3) NULL,
	[Datacode] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

