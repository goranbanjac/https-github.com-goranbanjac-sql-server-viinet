
CREATE Procedure [dbo].[Update_PersonAssignmentProgress]
		 @Id		Int
		,@Progress	NVarchar(max) 
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Update_PersonAssignmentResult
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @Id					Int
*		,@Results				NVarchar(max) 
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i Int
 
				Update	dbo.PersonAssignment 
				Set 	Progress = @Progress,
						EditedOn = GetDate()
				Where Id = @Id

	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		--If Xact_State() <> 0
		--	Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
