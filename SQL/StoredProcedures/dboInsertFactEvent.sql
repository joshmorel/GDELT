USE [GDELT]
GO

/****** Object:  StoredProcedure [dbo].[InsertFactEvent]    Script Date: 13/01/2015 6:57:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Josh Morel
-- Create date: 2014-12-15
-- Description:	Insert fact table event
-- =============================================
CREATE PROCEDURE [dbo].[InsertFactEvent] (@DateAdded int)
	-- Add the parameters for the stored procedure here
AS
BEGIN
SET NOCOUNT ON;

insert into dbo.FactEvent
select 
	de.GlobalEventID as DailyEventKey
	,de.Day as OccurrenceDateKey
	,DATEADDED as AddedDateKey
	,QuadClass as QuadClassKey
	,isnull(a1.ActorKey,0) as Actor1Key --Find Actor1Key from dimension table joining based on name
	,isnull(de.Actor1CountryCode,'0') as Actor1CountryKey
	,isnull(de.Actor1KnownGroupCode,'0') as Actor1KnownGroupKey
	,isnull(de.Actor1EthnicCode,'0') as Actor1EthnicGroupKey
	,isnull(de.Actor1Religion1Code,'0') as Actor1Religion1Key
	,isnull(de.Actor1Religion2Code,'0') as Actor1Religion2Key
	,isnull(de.Actor1Type1Code,'0') as Actor1Type1Key
	,isnull(de.Actor1Type2Code,'0') as Actor1Type2Key
	,isnull(de.Actor1Type3Code,'0') as Actor1Type3Key
	,isnull(a2.ActorKey,0) as Actor2Key  --Find Actor2Key from dimension table joining based on name
	,isnull(de.Actor2CountryCode,'0') as Actor2CountryKey
	,isnull(de.Actor2KnownGroupCode,'0') as Actor2KnownGroupKey
	,isnull(de.Actor2EthnicCode,'0') as Actor2EthnicGroupKey
	,isnull(de.Actor2Religion1Code,'0') as Actor2Religion1Key
	,isnull(de.Actor2Religion2Code,'0') as Actor2Religion2Key
	,isnull(de.Actor2Type1Code,'0') as Actor2Type1Key
	,isnull(de.Actor2Type2Code,'0') as Actor2Type2Key
	,isnull(de.Actor2Type3Code,'0') as Actor2Type3Key
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
 from stg.DailyEvent de
	left outer join dbo.DimActor a1
		on de.Actor1Name = a1.ActorName
	left outer join dbo.DimActor a2
		on de.Actor2Name = a2.ActorName
	left outer join dbo.DimGeoName a1g
		on de.Actor1Geo_Fullname = a1g.GeoName
	left outer join dbo.DimGeoName a2g
		on de.Actor2Geo_Fullname = a2g.GeoName
	left outer join dbo.DimGeoName acg
		on de.ActionGeo_Fullname = acg.GeoName
where DATEADDED = @DateAdded

END





GO

