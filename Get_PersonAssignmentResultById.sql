
CREATE Procedure [dbo].[Get_PersonAssignmentResultById]
		 @Id		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PersonAssignmentResultById
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @Id					Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i Int
 
				Select OrganizationId, PersonId, PathwayId PathwayVersionId,  Results
				From dbo.PersonAssignment  
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
