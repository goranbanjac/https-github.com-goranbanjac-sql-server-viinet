 
CREATE Procedure [dbo].[Get_Organization]
			@Id Int = null
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/22/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_Organization
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

		Select 
			 Id OrganizationId
			,OrganizationTypeId
			,OrganizationName
			,OrganizationIdentifier
			,Address1
			,Address2
			,City
			,State
			,ZipCode
			,OfficePhone
			,OfficeEmail
			,ParentOrganizationId
			,OwnedOrAffiliated 
		From Organization 
		Where (@Id Is Null Or Id = @Id)

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
