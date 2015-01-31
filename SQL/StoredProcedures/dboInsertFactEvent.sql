USE [GDELT]
GO

/****** Object:  StoredProcedure [dbo].[InsertFactEvent]    Script Date: 31/01/2015 12:44:39 PM ******/
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
	--ascii() function to return ascii code of first character of string. If '-' = 45, if 0 to 9 = 48 to 57. Else alpha
	,Actor1Geo_Type as Actor1GeoTypeKey
	,isnull(a1g.GeoNameKey,0) as Actor1GeoNameKey  --Find Actor1GeoNameKey from dimension table joining based on name
	,isnull(Actor1Geo_ADM1Code,'0') as Actor1GeoCountryADM1Key
	,Actor1Geo_Lat as Actor1GeoLatitude
	,Actor1Geo_Long as Actor1GeoLongitude
	,case when ascii(Actor1Geo_FeatureID) >= 65 or Actor1Geo_FeatureID is null then -2147483648 else Actor1Geo_FeatureID 
		end as Actor1GeoFeatureKey 	--ascii() function to return ascii code of first character of string. If '-' = 45, if 0 to 9 = 48 to 57. Else alpha
	,Actor2Geo_Type as Actor2GeoTypeKey
	,isnull(a2g.GeoNameKey,0) as Actor2GeoNameKey --Find Actor2GeoNameKey from dimension table joining based on name
	,isnull(Actor2Geo_ADM1Code,'0') as Actor2GeoCountryADM1Key
	,Actor2Geo_Lat as Actor2GeoLatitude
	,Actor2Geo_Long as Actor2GeoLongitude
	,case when ascii(Actor2Geo_FeatureID) >= 65 or Actor2Geo_FeatureID is null then -2147483648 else Actor2Geo_FeatureID 
		end as Actor2GeoFeatureKey	--ascii() function to return ascii code of first character of string. If '-' = 45, if 0 to 9 = 48 to 57. Else alpha
	,ActionGeo_Type as ActionGeoTypeKey
	,isnull(acg.GeoNameKey,0) as ActionGeoNameKey --Find ActionGeoNameKey from dimension table joining based on name
	,isnull(ActionGeo_ADM1Code,'0') as ActionGeoCountryADM1Key
	,ActionGeo_Lat as ActionGeoLatitude
	,ActionGeo_Long as ActionGeoLongitude
	,case when ascii(ActionGeo_FeatureID) >= 65 or ActionGeo_FeatureID is null then -2147483648 else ActionGeo_FeatureID 
		end as ActionGeoFeatureKey	--ascii() function to return ascii code of first character of string. If '-' = 45, if 0 to 9 = 48 to 57. Else alpha
	,GoldsteinScale
	,NumMentions
	,NumSources
	,NumArticles
	,AvgTone
    ,SOURCEURL as SourceURL
into #dailyevent
 from stg.DailyEvent de
	left outer join dbo.DimGeoName a1g
		on de.Actor1Geo_Fullname = a1g.GeoName
	left outer join dbo.DimGeoName a2g
		on de.Actor2Geo_Fullname = a2g.GeoName
	left outer join dbo.DimGeoName acg
		on de.ActionGeo_Fullname = acg.GeoName
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
	,Actor1GeoTypeKey
	,Actor1GeoNameKey
	,Actor1GeoCountryADM1Key
	,Actor1GeoLatitude
	,Actor1GeoLongitude
	,Actor1GeoFeatureKey
	,Actor2GeoTypeKey
	,Actor2GeoNameKey
	,Actor2GeoCountryADM1Key
	,Actor2GeoLatitude
	,Actor2GeoLongitude
	,Actor2GeoFeatureKey
	,ActionGeoTypeKey
	,ActionGeoNameKey
	,ActionGeoCountryADM1Key
	,ActionGeoLatitude
	,ActionGeoLongitude
	,ActionGeoFeatureKey
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

SELECT @RowsInserted = @@ROWCOUNT;

drop table #dailyevent

END







GO

