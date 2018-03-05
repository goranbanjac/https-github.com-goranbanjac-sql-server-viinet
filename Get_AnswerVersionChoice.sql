
CREATE Procedure [dbo].[Get_AnswerVersionChoice]
					@AnswerVersionGroupId Tinyint
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 9/04/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_AnswerVersionChoice
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int
		
			Select id, AnswerVersionGroupId, VersionChoicesName, SortOrder
			From dbo.AnswerVersionChoice 
			Where AnswerVersionGroupId = @AnswerVersionGroupId
			--Order BY SortOrder
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

