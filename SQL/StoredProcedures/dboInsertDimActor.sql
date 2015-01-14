USE [GDELT]
GO

/****** Object:  StoredProcedure [dbo].[InsertDimActor]    Script Date: 13/01/2015 6:57:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Josh Morel
-- Create date: 2014-12-24
-- Description:	Insert actor dimension from transactional data
-- =============================================
CREATE PROCEDURE [dbo].[InsertDimActor] (@DateAdded int)
	-- Add the parameters for the stored procedure here
AS
BEGIN
SET NOCOUNT ON;

truncate table stg.DimActor;

insert into stg.DimActor (ActorName)
select distinct	Actor1Name
from stg.DailyEvent 
where DATEADDED = @DateAdded
and Actor1Name is not null

union 
select distinct	Actor2Name
from stg.DailyEvent 
where DATEADDED = @DateAdded
and Actor2Name is not null

  merge dbo.DimActor as t1

  using stg.DimActor as t2 on t1.ActorName = t2.ActorName

  when not matched then 

      insert (ActorName)

      values (ActorName);

END





GO

