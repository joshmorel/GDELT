USE [GDELT]
GO

/****** Object:  StoredProcedure [GDELT20].[InsertDimActor]    Script Date: 2015-03-15 11:45:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Josh Morel
-- Create date: 2014-12-24
-- Description:	Insert actor dimension from transactional data with all attributes
-- =============================================
CREATE PROCEDURE [GDELT20].[InsertDimActor] (@RowsInserted int output)
	-- Add the parameters for the stored procedure here
AS
BEGIN
SET NOCOUNT ON;

--Truncate staging table
truncate table stg.DimActor;

--First store distinct list of all actors from actor 1 and actor 2 columns into temp table
select distinct *
into #actor
from (
select 
	a1.Actor1Name ActorName
	,a1.Actor1Code ActorCode
	,a1.Actor1CountryCode ActorCountryCode
	,a1.Actor1KnownGroupCode ActorKnownGroupCode
	,a1.Actor1EthnicCode ActorEthnicCode
	,a1.Actor1Religion1Code ActorReligion1Code
	,a1.Actor1Religion2Code ActorReligion2Code
	,a1.Actor1Type1Code ActorType1Code
	,a1.Actor1Type2Code ActorType2Code
	,a1.Actor1Type3Code ActorType3Code
from stg.GDELT20DailyEvent a1
where a1.Actor1Name is not null
union all
select 
	a2.Actor2Name
	,a2.Actor2Code
	,a2.Actor2CountryCode
	,a2.Actor2KnownGroupCode
	,a2.Actor2EthnicCode
	,a2.Actor2Religion1Code
	,a2.Actor2Religion2Code
	,a2.Actor2Type1Code
	,a2.Actor2Type2Code
	,a2.Actor2Type3Code
from stg.GDELT20DailyEvent a2
where a2.Actor2Name is not null
) sq ;

--Next, get lookup values for descriptions and insert into staging table
insert into stg.DimActor
select 
	isnull(a.ActorName,'n/a') ActorName
	,isnull(a.ActorCode,'n/a') ActorCode 
	,isnull(a.ActorCountryCode,'n/a') ActorCountryCode
	,isnull(c.CountryDescription,'n/a') ActorCountryDesc
	,isnull(a.ActorKnownGroupCode,'n/a') ActorKnownGroupCode
	,isnull(k.KnownGroupDescription,'n/a') ActirKnownGroupDesc
	,isnull(a.ActorEthnicCode,'n/a') ActorEthnicCode
	,isnull(e.EthnicGroupDescription,'n/a') ActorEthnicDesc
	,isnull(a.ActorReligion1Code,'n/a') ActorReligion1Code
	,isnull(r1.ReligionDescription,'n/a') ActorReligion1Desc
	,isnull(a.ActorReligion2Code,'n/a') ActorReligion2Code
	,isnull(r2.ReligionDescription,'n/a') ActorReligion2Desc
	,isnull(a.ActorType1Code,'n/a') ActorType1Code
	,isnull(t1.ActorTypeDescription,'n/a') ActorType1Desc
	,isnull(a.ActorType2Code,'n/a') ActorType2Code
	,isnull(t2.ActorTypeDescription,'n/a') ActorType2Desc
	,isnull(a.ActorType3Code,'n/a') ActorType3Code
	,isnull(t3.ActorTypeDescription,'n/a') ActorType3Desc
from #actor a
	left outer join stg.ActorCountry c
		on a.ActorCountryCode = c.CountryKey
	left outer join stg.ActorKnownGroup k
		on a.ActorKnownGroupCode = k.KnownGroupKey
	left outer join stg.ActorEthnicGroup e
		on a.ActorEthnicCode = e.EthnicGroupKey
	left outer join stg.ActorReligion r1
		on a.ActorReligion1Code = r1.ReligionKey
	left outer join stg.ActorReligion r2
		on a.ActorReligion2Code = r2.ReligionKey
	left outer join stg.ActorType t1
		on a.ActorType1Code = t1.ActorTypeKey
	left outer join stg.ActorType t2
		on a.ActorType2Code = t2.ActorTypeKey
	left outer join stg.ActorType t3
		on a.ActorType3Code = t3.ActorTypeKey
;

--Finally, use merge statement to update or insert into production table on combination of unique columns (ActorCode is combination of three actor types)
	--ActorName,ActorCode,ActorCountryCode,ActorKnownGroupCode,ActorEthnicCode,ActorReligion1Code,ActorReligion2Code

merge GDELT20.DimActor as t1
using stg.DimActor as t2 
on t1.ActorName = t2.ActorName
	and t1.ActorCode = t2.ActorCode
	and t1.ActorCountryCode = t2.ActorCountryCode
	and t1.ActorKnownGroupCode = t2.ActorKnownGroupCode
	and t1.ActorEthnicCode = t2.ActorEthnicCode
	and t1.ActorReligion1Code = t2.ActorReligion1Code
	and t1.ActorReligion2Code = t2.ActorReligion2Code

  when not matched then 

      insert (ActorName
           ,ActorCode
           ,ActorCountryCode
           ,ActorCountryDesc
           ,ActorKnownGroupCode
           ,ActorKnownGroupDesc
           ,ActorEthnicCode
           ,ActorEthnicDesc
           ,ActorReligion1Code
           ,ActorReligion1Desc
           ,ActorReligion2Code
           ,ActorReligion2Desc
           ,ActorType1Code
           ,ActorType1Desc
           ,ActorType2Code
           ,ActorType2Desc
           ,ActorType3Code
           ,ActorType3Desc)

      values (ActorName
           ,ActorCode
           ,ActorCountryCode
           ,ActorCountryDesc
           ,ActorKnownGroupCode
           ,ActorKnownGroupDesc
           ,ActorEthnicCode
           ,ActorEthnicDesc
           ,ActorReligion1Code
           ,ActorReligion1Desc
           ,ActorReligion2Code
           ,ActorReligion2Desc
           ,ActorType1Code
           ,ActorType1Desc
           ,ActorType2Code
           ,ActorType2Desc
           ,ActorType3Code
           ,ActorType3Desc);

SELECT @RowsInserted = @@ROWCOUNT;
--Drop temp table
drop table #actor

END













GO

