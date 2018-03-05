 
CREATE Procedure [dbo].[Get_AnswerVersionGroup]
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 3/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_AnswerVersionGroup
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

		Select g.Id AnswerVersionGroupId, AnswerVersionGroup, c.Id AnswerVersionChoice, VersionChoicesName, SortOrder, Score 
		From dbo.AnswerOptionGroup g
		inner join dbo.AnswerVersionChoice c On
			g.Id = c.AnswerVersionGroupId
		Order BY g.Id, SortOrder

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


