USE [GDELT]
GO

/****** Object:  StoredProcedure [dbo].[InsertDimGeoName]    Script Date: 13/01/2015 6:57:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Josh Morel
-- Create date: 2014-12-24
-- Description:	Insert dimension geography name from transactional data
-- =============================================
CREATE PROCEDURE [dbo].[InsertDimGeoName] (@DateAdded int)
	-- Add the parameters for the stored procedure here
AS
BEGIN
SET NOCOUNT ON;

truncate table stg.DimGeoName;

insert into stg.DimGeoName (GeoName)
select distinct	Actor1Geo_Fullname
from stg.DailyEvent 
where DATEADDED = @DateAdded
and Actor1Geo_Fullname is not null

union 
select distinct	Actor2Geo_Fullname
from stg.DailyEvent 
where DATEADDED = @DateAdded
and Actor2Geo_Fullname is not null

union 
select distinct	ActionGeo_Fullname
from stg.DailyEvent 
where DATEADDED = @DateAdded
and ActionGeo_Fullname is not null

  merge dbo.DimGeoName as t1

  using stg.DimGeoName as t2 on t1.GeoName = t2.GeoName

  when not matched then 

      insert (GeoName)

      values (GeoName);

END





GO

