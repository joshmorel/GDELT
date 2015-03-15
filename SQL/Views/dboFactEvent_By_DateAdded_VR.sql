USE [GDELT]
GO

/****** Object:  View [GDELT20].[FactEvent_By_DateAdded_VR]    Script Date: 2015-03-15 11:34:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









create VIEW [GDELT20].[FactEvent_By_DateAdded_VR]
AS
SELECT
	 AD.FULL_DATE AS AddedDate
	 ,AD.CALENDAR_YEAR AS AddedYear
	 ,AD.MONTH_NAME AS AddedMonth
	 ,AD.DAY_OF_WEEK_NAME as [DayOfWeek]
	 ,F.AddedTimeKey AS AddedTime
	,COUNT(*) AS RecordCount

  FROM GDELT20.FactEvent F
	INNER JOIN COMMON.DimDate AD
		on F.AddedDateKey = AD.DATE_KEY
GROUP BY
	 AD.FULL_DATE
	 ,AD.CALENDAR_YEAR
	 ,AD.MONTH_NAME
	 ,F.AddedTimeKey
	 ,AD.DAY_OF_WEEK_NAME









GO

