

CREATE Procedure [dbo].[Delete_PathwayActionTime]
		  @PersonAssignmentId	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Delete_PathwayActionTime
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		  @PersonAssignmentId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				Delete PathwayActionTime
				Where PersonAssignmentId = @PersonAssignmentId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

