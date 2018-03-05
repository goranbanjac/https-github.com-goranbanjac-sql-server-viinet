
Create Procedure [dbo].[Add_PersonAssignmentVideo]
		 @PersonAssignmentId	BigInt
		,@VideoFileName			NVarchar(100)
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/25/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonAssignmentVideo
*
*	Description:
*			
*
*	PARAMETERS: 
*		 @PersonAssignmentId	BigInt
*		,@VideoFileName			NVarchar(100)
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int		
	
			Insert dbo.PersonAssignmentVideo ( Id, PersonAssignmentId, VideoFileName )
			Select   NewId(), @PersonAssignmentId, @VideoFileName	

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
