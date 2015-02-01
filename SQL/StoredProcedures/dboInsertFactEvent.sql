USE [GDELT]
GO

/****** Object:  StoredProcedure [dbo].[InsertFactEvent]    Script Date: 01/02/2015 11:51:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		Josh Morel
-- Create date: 2014-12-15
-- Description:	Insert fact table event
-- =============================================
CREATE PROCEDURE [dbo].[InsertFactEvent] (@DateAdded int, @RowsInserted int output)
	-- Add the parameters for the stored procedure here
AS
BEGIN
SET NOCOUNT ON;


select 
	de.GlobalEventID as DailyEventKey
	,de.Day as OccurrenceDateKey
	,DATEADDED as AddedDateKey
	,QuadClass as QuadClassKey
	,isnull(de.Actor1Code,'n/a') Actor1Code
	,isnull(de.Actor1Name,'n/a') Actor1Name
	,isnull(de.Actor1CountryCode,'n/a') Actor1CountryCode
	,isnull(de.Actor1KnownGroupCode,'n/a') Actor1KnownGroupCode
	,isnull(de.Actor1EthnicCode,'n/a') Actor1EthnicCode
	,isnull(de.Actor1Religion1Code,'n/a') Actor1Religion1Code
	,isnull(de.Actor1Religion2Code,'n/a') Actor1Religion2Code
	,isnull(de.Actor2Code,'n/a') Actor2Code
	,isnull(de.Actor2Name,'n/a') Actor2Name
	,isnull(de.Actor2CountryCode,'n/a') Actor2CountryCode
	,isnull(de.Actor2KnownGroupCode,'n/a') Actor2KnownGroupCode
	,isnull(de.Actor2EthnicCode,'n/a') Actor2EthnicCode
	,isnull(de.Actor2Religion1Code,'n/a') Actor2Religion1Code
	,isnull(de.Actor2Religion2Code,'n/a') Actor2Religion2Code
	,IsRootEvent
	,case when ISNUMERIC(de.EventCode) = 1 then cast(de.EventCode as int) else 0 end as EventCodeKey
	--For Actor1GeoKey
	--FullName, Lat, Long, FeatureID can be assumed unique for DimGeo
	,isnull(Actor1Geo_Fullname,'n/a') Actor1Geo_Fullname
	,Actor1Geo_Lat
	,Actor1Geo_Long
	,isnull(Actor1Geo_FeatureID,'n/a') Actor1Geo_FeatureID
	--For Actor2GeoKey
	,isnull(Actor2Geo_Fullname,'n/a') Actor2Geo_Fullname
	,Actor2Geo_Lat
	,Actor2Geo_Long
	,isnull(Actor2Geo_FeatureID,'n/a') Actor2Geo_FeatureID
	--For ActionGeoKey
	,isnull(ActionGeo_Fullname,'n/a') ActionGeo_Fullname
	,ActionGeo_Lat
	,ActionGeo_Long
	,isnull(ActionGeo_FeatureID,'n/a') ActionGeo_FeatureID
	,GoldsteinScale
	,NumMentions
	,NumSources
	,NumArticles
	,AvgTone
    ,SOURCEURL as SourceURL
into #dailyevent
 from stg.DailyEvent de
where DATEADDED = @DateAdded;


insert into dbo.FactEvent
select
	DailyEventKey
	,OccurrenceDateKey
	,AddedDateKey
	,QuadClassKey
	,isnull(a1.ActorKey,-1) Actor1Key --These are non null actor not found in dimension (unexpected)
	,isnull(a2.ActorKey,-1) Actor2Key --These are non null actor not found in dimension (unexpected)
	,IsRootEvent
	,EventCodeKey
	,isnull(ag1.GeoKey,-1) Actor1GeoKey --These are non null actor not found in dimension (unexpected)
	,isnull(ag2.GeoKey,-1) Actor2GeoKey --These are non null actor not found in dimension (unexpected)
	,isnull(actg.GeoKey,-1) ActionGeoKey --These are non null actor not found in dimension (unexpected)
	,GoldsteinScale
	,NumMentions
	,NumSources
	,NumArticles
	,AvgTone
    ,SourceURL
from #dailyevent de
	left outer join dbo.DimActor a1
		on de.Actor1Name = a1.ActorName
			and de.Actor1Code = a1.ActorCode
			and de.Actor1CountryCode = a1.ActorCountryCode
			and de.Actor1KnownGroupCode = a1.ActorKnownGroupCode
			and de.Actor1EthnicCode = a1.ActorEthnicCode
			and de.Actor1Religion1Code = a1.ActorReligion1Code
			and de.Actor1Religion2Code = a1.ActorReligion2Code
	left outer join dbo.DimActor a2
		on de.Actor2Name = a2.ActorName
			and de.Actor2Code = a2.ActorCode
			and de.Actor2CountryCode = a2.ActorCountryCode
			and de.Actor2KnownGroupCode = a2.ActorKnownGroupCode
			and de.Actor2EthnicCode = a2.ActorEthnicCode
			and de.Actor2Religion1Code = a2.ActorReligion1Code
			and de.Actor2Religion2Code = a2.ActorReligion2Code
	left outer join dbo.DimGeo ag1
		on 	de.Actor1Geo_Fullname = ag1.GeoFullname
			and de.Actor1Geo_Lat = ag1.GeoLat
			and de.Actor1Geo_Long = ag1.GeoLong
			and de.Actor1Geo_FeatureID = ag1.GeoFeatureID
	left outer join dbo.DimGeo ag2
		on 	de.Actor2Geo_Fullname = ag2.GeoFullname
			and de.Actor2Geo_Lat = ag2.GeoLat
			and de.Actor2Geo_Long = ag2.GeoLong
			and de.Actor2Geo_FeatureID = ag2.GeoFeatureID
	left outer join dbo.DimGeo actg
		on 	de.ActionGeo_Fullname = actg.GeoFullname
			and de.ActionGeo_Lat = actg.GeoLat
			and de.ActionGeo_Long = actg.GeoLong
			and de.ActionGeo_FeatureID = actg.GeoFeatureID


SELECT @RowsInserted = @@ROWCOUNT;

drop table #dailyevent

END









GO

