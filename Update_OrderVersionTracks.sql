
CREATE Procedure [dbo].[Update_OrderVersionTracks]
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
*	File Name:	dbo.Update_OrderVersionTracks
*
*	Description:
*			
*	PARAMETERS: 
*
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
				
					 Update dbo.OrderVersionTracks
					 Set 	
							ConditionOrderIds	= @ConditionOrderIds,
							Expression			= @Expression,
							TrackItem			= @TrackItem,
							Actions				= @Actions,
							EditedOn			= GetDate()			
					Where	PathwayVersionId	= @PathwayVersionId
					And		OrderVersionId		= @OrderVersionId

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch