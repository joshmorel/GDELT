USE [GDELT]
GO

/****** Object:  StoredProcedure [COMMON].[PopulateDimDate]    Script Date: 2015-03-15 11:45:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		Josh Morel
-- Create date: 2015-02-01
-- Description:	Insert geography dimension with transactional data
-- =============================================
CREATE PROCEDURE [COMMON].[PopulateDimDate]

AS
BEGIN
SET NOCOUNT ON;

truncate table COMMON.DimDate;

--Purpose: To populate the DIM_DATE table

--Step 1: Declare temporary holiday table and populate with data from ESP holiday table
--Note: Data available for FY 2004/05 forward. Updated yearly.

--Step 2: Declare temporary date table 
DECLARE @DIM_DATE TABLE (
	DATE_KEY INT
	,FULL_DATE DATETIME2(0)
	,DATE_YYYYMMDD VARCHAR(10)
	,DATE_MMDDYYYY VARCHAR(10)
	,DATE_DDMMYYYY VARCHAR(10)
	,DAY_OF_WEEK SMALLINT
	,DAY_OF_WEEK_NAME VARCHAR(10)
	,DAY_OF_WEEK_ABBREVIATION VARCHAR(3)
	,DAY_OF_MONTH SMALLINT
	,DAY_OF_YEAR SMALLINT

	,WEEKDAY_WEEKEND VARCHAR(7)
	,IS_WEEKDAY TINYINT

	,WEEK_OF_YEAR TINYINT
	,MONTH_NAME VARCHAR(10)
	,MONTH_ABBREVIATION VARCHAR(3)
	,MONTH_OF_YEAR SMALLINT
	,IS_LAST_DAY_OF_MONTH TINYINT
	,CALENDAR_QUARTER SMALLINT
	,CALENDAR_QUARTER_NAME VARCHAR(3)
	,CALENDAR_YEAR SMALLINT
	,CALENDAR_YEAR_NAME VARCHAR(7)
	,CALENDAR_YEAR_MONTH VARCHAR(16)
	,CALENDAR_YEAR_QUARTER VARCHAR(12)
	,FISCAL_MONTH_OF_YEAR SMALLINT
	,FISCAL_QUARTER SMALLINT
	,FISCAL_QUARTER_NAME VARCHAR(3)
	,FISCAL_YEAR SMALLINT
	,FISCAL_YEAR_NAME VARCHAR(10)
	,FISCAL_YEAR_MONTH VARCHAR(19)
	,FISCAL_YEAR_QUARTER VARCHAR(15)
	,LAST_DAY_OF_WEEK DATETIME2(0)
	,LAST_DAY_OF_MONTH DATETIME2(0)
);

--Step 3: Populate date table with days from 1950 to 2050
DECLARE @DATECTR DATETIME2(0) = '2000-01-01 00:00';

WHILE @DATECTR <= '2016-12-31'

BEGIN
INSERT INTO COMMON.DimDate
VALUES(
	CAST(CONVERT(CHAR(8),@DATECTR,112) AS INT) --Date Key
	,@DATECTR --Date in Date Format
	,CONVERT(CHAR(10),@DATECTR,111) --Date in YYYY/MM/DD format (Japan)
	,CONVERT(CHAR(10),@DATECTR,101) --Date in MM/DD/YYYY format (US)
	,CONVERT(CHAR(10),@DATECTR,103) --Date in DD/MM/YYYY format (UK)
	,DATEPART(DW,@DATECTR) --Day of Week (number)
	,DATENAME(DW,@DATECTR) --Day Name (full)
	,LEFT(DATENAME(DW,@DATECTR),3) --Day Name (abbreviation)
	,DAY(@DATECTR) --Day of Month
	,DATEPART(DY,@DATECTR) --Day of Year
	,CASE WHEN DATEPART(DW,@DATECTR) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END --Weekend/Weekday
	,CASE WHEN DATEPART(DW,@DATECTR) IN (1,7) THEN 0 ELSE 1 END --Is Weekend (boolean)
	,DATEPART(WEEK,@DATECTR) --Week of Year
	,DATENAME(M,@DATECTR) --Month Name (full)
	,LEFT(DATENAME(M,@DATECTR),3) --Month Name (abbreviation)
	,MONTH(@DATECTR) --Month of Year
	,CASE WHEN MONTH(@DATECTR) <> MONTH(DATEADD(DAY,1,@DATECTR)) THEN 1 ELSE 0 END --Is Last Day of Month (boolean)
	,DATEPART(QQ,@DATECTR) --Calendar Quarter (number) 
	,'Q'+DATENAME(QQ,@DATECTR) --Calendar Quarter (name)
	,YEAR(@DATECTR) --Calendar Year (quarter)
	,'CY '+DATENAME(YYYY,@DATECTR) --Calendar Year (name)
	,'CY '+DATENAME(YYYY,@DATECTR) + ' ' + RIGHT('0'+CAST(MONTH(@DATECTR) AS VARCHAR(2)),2) + '_' + LEFT(DATENAME(M,@DATECTR),3) --Calendar Year & Month
	,'CY '+DATENAME(YYYY,@DATECTR) + ' Q' + DATENAME(QQ,@DATECTR) --Calendar Year & Quarter
	,CASE WHEN MONTH(@DATECTR) <= 3 THEN MONTH(@DATECTR) + 9 ELSE MONTH(@DATECTR) - 3 END --Fiscal Year of Month
	,CASE WHEN MONTH(@DATECTR) <= 3 THEN 4 ELSE DATEPART(QQ,@DATECTR) - 1 END --Fiscal Quarter (number)
	,CASE WHEN MONTH(@DATECTR) <= 3 THEN 'Q4' ELSE 'Q'+CAST(DATEPART(QQ,@DATECTR) - 1 AS CHAR(1)) END --Fiscal Quarter (name)
	,CASE WHEN MONTH(@DATECTR) <= 3 THEN YEAR(@DATECTR)-1 ELSE YEAR(@DATECTR) END --Fiscal year (number)
	,CASE WHEN MONTH(@DATECTR) <= 3 
		THEN 'FY ' + CAST(YEAR(@DATECTR)-1 AS CHAR(4))+'/'+RIGHT(DATENAME(YYYY,@DATECTR),2) 
		ELSE 'FY ' + DATENAME(YYYY,@DATECTR) + '/' + RIGHT(CAST(YEAR(@DATECTR)+1 AS CHAR(4)),2) 
	END --Fiscal Year (name)
	,CASE WHEN MONTH(@DATECTR) <= 3 
		THEN 'FY ' + CAST(YEAR(@DATECTR)-1 AS CHAR(4))+'/'+RIGHT(DATENAME(YYYY,@DATECTR),2) + ' ' + 
			CAST(MONTH(@DATECTR) + 9 AS CHAR(2)) + '_' + LEFT(DATENAME(M,@DATECTR),3)
		ELSE 'FY ' + DATENAME(YYYY,@DATECTR) + '/' + RIGHT(CAST(YEAR(@DATECTR)+1 AS CHAR(4)),2) + ' ' + 
			RIGHT('0'+CAST(MONTH(@DATECTR) - 3 AS VARCHAR(2)),2) + '_' + LEFT(DATENAME(M,@DATECTR),3)
	END	--Fiscal Year & Month

	,CASE WHEN MONTH(@DATECTR) <= 3 
		THEN 'FY ' + CAST(YEAR(@DATECTR)-1 AS CHAR(4))+'/'+RIGHT(DATENAME(YYYY,@DATECTR),2) + ' Q4'
		ELSE 'FY ' + DATENAME(YYYY,@DATECTR) + '/' + RIGHT(CAST(YEAR(@DATECTR)+1 AS CHAR(4)),2) + ' ' 
			+ 'Q'+CAST(DATEPART(QQ,@DATECTR) - 1 AS CHAR(1))
	END	--Fiscal Year & Quarter
	,DATEADD(DAY,7-DATEPART(DW,@DATECTR),@DATECTR) --End of Week (Saturday of same week)
	,DATEADD(DAY,-DAY(DATEADD(MONTH,1,@DATECTR)),DATEADD(MONTH,1,@DATECTR)) --End of Month
)

SET @DATECTR = DATEADD(DAY,1,@DATECTR );
END

;


--Step 5: Insert unknown date record
INSERT INTO COMMON.DimDate
VALUES
(
	30001231
	,'3000-12-31'
	,'N/A'
	,'N/A'
	,'N/A'
	,null
	,'N/A'
	,'N/A'
	,null
	,null

	,'N/A'
	,null
	,null
	,'N/A'
	,'N/A'
	,null
	,null
	,null
	,'N/A'
	,null
	,'N/A'
	,'N/A'
	,'N/A'
	,null
	,null
	,'N/A'
	,null
	,'N/A'
	,'N/A'
	,'N/A'	
	,'3000-12-31'
	,'3000-12-31'
)


END



















GO

