
Create Proc [dbo].[Delete_Organization]
			 @Id int
AS
Set Nocount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 2/16/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Delete_Organization
*
*	Description:
*			
*
*	PARAMETERS: 
*			 @Id int	
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int
			Begin Tran

				Delete dbo.OrganizationRelationship
				Where OrganizationId = @Id

				Delete dbo.Organization
				Where Id = @Id

			Commit
	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		If Xact_State() <> 0
			Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0

