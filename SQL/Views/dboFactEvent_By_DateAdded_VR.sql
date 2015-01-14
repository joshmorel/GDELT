USE [GDELT]
GO

/****** Object:  View [dbo].[FactEvent_By_DateAdded_VR]    Script Date: 13/01/2015 6:57:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[FactEvent_By_DateAdded_VR]
AS
SELECT 
     
	 AD.Date AS AddedDate
	 ,AD.Year AS AddedYear
	 ,AD.Month AS AddedMonth
	 ,AD.DayName as [DayOfWeek]
	,COUNT(*) AS RecordCount
    
  FROM dbo.FactEvent F
	INNER JOIN dbo.DimDate AD
		on F.AddedDateKey = AD.DateKey
GROUP BY
	 AD.Date
	 ,AD.Year
	 ,Ad.Month
	 ,AD.DayName




GO

