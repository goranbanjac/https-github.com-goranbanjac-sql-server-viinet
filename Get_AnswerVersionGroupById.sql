 
CREATE Procedure [dbo].[Get_AnswerVersionGroupById]
					@StrId NVarchar (1000)
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 12/29/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_AnswerVersionGroupById
*
*	Description:
*			
*
*	PARAMETERS: 
*			@StrId NVarchar (100)
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
		Where g.Id In ( Select value from dbo.SplitStrings_Native (@StrId,','))
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
