USE [GDELT]
GO

/****** Object:  StoredProcedure [GDELT20].[InsertDimGeo]    Script Date: 2015-03-15 11:45:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Josh Morel
-- Create date: 2015-02-01
-- Description:	Insert geography dimension with transactional data
-- =============================================
CREATE PROCEDURE [GDELT20].[InsertDimGeo] (@RowsInserted int output)

AS
BEGIN
SET NOCOUNT ON;

--Truncate staging table
truncate table stg.DimGeo;

--First store distinct list of all geo locations from actor 1, actor 2 and action columns in temp table 
select distinct *
into #geo
from
(
select
	Actor1Geo_Type GeoType
    ,Actor1Geo_Fullname GeoFullname
    ,Actor1Geo_CountryCode GeoCountryCode
    ,Actor1Geo_ADM1Code GeoADM1Code
	,Actor1Geo_ADM2Code GeoADM2Code
    ,Actor1Geo_Lat GeoLat
    ,Actor1Geo_Long GeoLong
    ,Actor1Geo_FeatureID GeoFeatureID
from stg.GDELT20DailyEvent
where Actor1Geo_type <> 0 
union all
select
	Actor2Geo_Type GeoType
    ,Actor2Geo_Fullname GeoFullname
    ,Actor2Geo_CountryCode GeoCountryCode
    ,Actor2Geo_ADM1Code GeoADM1Code
	,Actor2Geo_ADM2Code GeoADM2Code
    ,Actor2Geo_Lat GeoLat
    ,Actor2Geo_Long GeoLong
    ,Actor2Geo_FeatureID GeoFeatureID
from stg.GDELT20DailyEvent	
where Actor2Geo_type <> 0
union all
select
	ActionGeo_Type GeoType
    ,ActionGeo_Fullname GeoFullname
    ,ActionGeo_CountryCode GeoCountryCode
    ,ActionGeo_ADM1Code GeoADM1Code
	,ActionGeo_ADM2Code GeoADM2Code
    ,ActionGeo_Lat GeoLat
    ,ActionGeo_Long GeoLong
    ,ActionGeo_FeatureID GeoFeatureID
from stg.GDELT20DailyEvent
where ActionGeo_Type <> 0
) sq ;

--Next, get lookup values for descriptions and insert into staging table
insert into stg.DimGeo
select 
	isnull(g.GeoFullname,'n/a') GeoFullname
	,g.GeoCountryCode
	,isnull(gc.GeoCountryDesc,'n/a') GeoCountryDesc
	,g.GeoADM1Code
	,case when G.GeoType = 1 then 'Not Applicable, Geo Is Country Type'
		else isnull(gca.GeoADM1Desc,'ADM1 Description Not Available')
	end GeoADM1Desc
	,isnull(g.GeoADM2Code,'n/a') GeoADM2Code
	,g.GeoFeatureID
	,g.GeoLat
	,g.GeoLong
	,G.GeoType GeoTypeCode
	,gt.GeoTypeDesc
from #geo g
	left outer join stg.GeoType gt
		on g.GeoType = gt.GeoTypeCode
	left outer join stg.GeoCountryADM1 gca
		on g.GeoADM1Code = gca.GeoCountryADM1Key
	left outer join stg.GeoCountryADM1 gc
		on g.GeoCountryCode = gc.GeoCountryADM1Key
;

--Finally, use merge statement to update or insert into production table on combination of unique columns
	--GeoFeatureID, GeoFullname, GeoLat, GeoLong, GeoADM1Code

merge GDELT20.DimGeo as t1
using stg.DimGeo as t2 
on t1.GeoFeatureID = t2.GeoFeatureID
	and t1.GeoFullname = t2.GeoFullname
	and t1.GeoADM1Code = t2.GeoADM1Code
	and t1.GeoADM2Code = t2.GeoADM2Code 
	and isnull(t1.GeoLat,0) = isnull(t2.GeoLat,0)
	and isnull(t1.GeoLong,0) = isnull(t2.GeoLong,0)

  when not matched then 

      insert (GeoFullname
		,GeoCountryCode
		,GeoCountryDesc
		,GeoADM1Code
		,GeoADM1Desc
		,GeoADM2Code
		,GeoFeatureID
		,GeoLat
		,GeoLong
		,GeoTypeCode
		,GeoTypeDesc)

      values (GeoFullname
		,GeoCountryCode
		,GeoCountryDesc
		,GeoADM1Code
		,GeoADM1Desc
		,GeoADM2Code
		,GeoFeatureID
		,GeoLat
		,GeoLong
		,GeoTypeCode
		,GeoTypeDesc);

SELECT @RowsInserted = @@ROWCOUNT;
--Drop temp table
drop table #geo

END

















GO

