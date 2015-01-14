USE [GDELT]
GO

/****** Object:  Table [SSIS].[ETLHistory]    Script Date: 13/01/2015 6:55:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SSIS].[ETLHistory](
	[MasterPackageID] [uniqueidentifier] NOT NULL,
	[PackageID] [uniqueidentifier] NOT NULL,
	[RunTime] [datetime] NOT NULL,
	[PackageName] [varchar](255) NOT NULL,
	[SourceDateAdded] [date] NOT NULL,
	[NewRecordCount] [int] NOT NULL,
	[ModifiedRecordCount] [int] NOT NULL,
 CONSTRAINT [PK_ETLHistory] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC,
	[RunTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SSIS].[ETLHistory] ADD  CONSTRAINT [DFT_ETLHistory_RunTime]  DEFAULT (getdate()) FOR [RunTime]
GO

