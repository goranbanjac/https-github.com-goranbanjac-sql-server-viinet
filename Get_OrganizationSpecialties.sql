
CREATE Procedure [dbo].[Get_OrganizationSpecialties]
		 @OrganizationId	int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/25/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_OrganizationSpecialties
*
*	Description:
*			
*
*	PARAMETERS: 
*		@OrganizationId	int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int		
	
			Select Id, Specialties From dbo.OrganizationSpecialties Where OrganizationId = @OrganizationId

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
