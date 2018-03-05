

CREATE Procedure [dbo].[Get_OrderVersionTracks]
			  @PathwayVersionId		Int
			 ,@OrderVersionId		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 02/08/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_OrderVerzionTracks
*
*	Description:
*			
*
*	PARAMETERS: 
*
* [dbo].[Add_OrderVersionG]
*			 @OrderVersionId		Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int
				
			
				Select
					PathwayVersionId, OrderVersionId, ConditionOrderIds, Expression, TrackItem, Actions
				From 
					dbo.OrderVersionTracks 
				Where
					PathwayVersionId = @PathwayVersionId
				And	OrderVersionId = @OrderVersionId
	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch