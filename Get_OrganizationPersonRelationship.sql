
CREATE PROCEDURE [dbo].[Get_OrganizationPersonRelationship]  
							@OrganizationId	Int		= Null,
							@PersonId		BigInt	= Null

As
Set NoCount On;
/*********************************************************************
--* ======================================================================
--*  Author: Goran Banjac
--*  Date Created: 04/10/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrganizationPersonRelationship
*
*	Description:
*			
*
*	PARAMETERS: 
*			@OrganizationId	Int ,
*			@PersonId		BigInt
*				
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text	
*												
*********************************************************************/
	Declare @i Int

	Begin Try

			Select OrganizationId, PersonId
			From OrganizationPersonRelationship --with(index(idx_OrganizationPersonRelationship_PersonId_OrganizationId))
			Where 	Id > 0
			And		(@OrganizationId Is Null  Or OrganizationId = @OrganizationId) 
			And		(@PersonId		 Is Null  Or PersonId = @PersonId) 
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

