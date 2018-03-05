

CREATE Procedure [dbo].[Delete_OrderVersionTracks]
			  @PathwayVersionId		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 02/08/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Delete_OrderVerzionTracks
*
*	Description:
*			
*
*	PARAMETERS: 
*
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int
				
			
				Delete
					dbo.OrderVersionTracks 
				Where
					PathwayVersionId = @PathwayVersionId
	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch