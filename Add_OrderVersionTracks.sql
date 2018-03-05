
CREATE Procedure [dbo].[Add_OrderVersionTracks]
			 @PathwayVersionId		Int
			,@OrderVersionId		Int
			,@ConditionOrderIds		Nvarchar( 1000 ) 
			,@Expression			NVarchar( 1000 )
			,@TrackItem				NVarchar( 4000 )
			,@Actions				NVarchar( 4000 )
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 02/08/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_OrderVerzionTracks
*
*	Description:
*			
*
*	PARAMETERS: 
*
* [dbo].[Add_OrderVersionG]
*			 @OrderVersionId		Int
*			,@ConditionOrderIds		Nvarchar( 1000 ) 
*			,@Expression			NVarchar( 1000 )
*			,@TrackItem				NVarchar( 4000 )
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int
				
			
				--Merge	dbo.OrderVersionTracks q
				--	Using	(	select	@PathwayVersionId, @OrderVersionId, @ConditionOrderIds, @Expression, @TrackItem ) s 
				--			(	PathwayVersionId, OrderVersionId, ConditionOrderIds, Expression, TrackItem ) on 
				--				q.PathwayVersionId = s.PathwayVersionId
				--			And	q.OrderVersionId = s.OrderVersionId
				--	When Matched 
				--		Then Update Set 	
				--						q.ConditionOrderIds	= s.ConditionOrderIds,
				--						q.Expression		= s.Expression,
				--						q.TrackItem			= s.TrackItem,
				--						q.EditedOn			= GetDate()			
				--	When Not Matched 
				--		Then 

						Insert dbo.OrderVersionTracks ( PathwayVersionId, OrderVersionId, ConditionOrderIds, Expression, TrackItem, Actions )
							Values ( @PathwayVersionId, @OrderVersionId, @ConditionOrderIds, @Expression, @TrackItem, @Actions  );

						--If @Id Is Null
							--Select @OrderVersionId = IsNull(@Id,SCOPE_IDENTITY())
							--	Select @OrderVersionId OrderVersionId

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch