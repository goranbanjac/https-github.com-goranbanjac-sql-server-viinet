
CREATE PROCEDURE [dbo].[Add_PersonOrganization]  
					 @Id						BigInt = Null
					,@OrganizationId			Int 
					,@PersonId					BigInt
				    ,@PersonOrganizationIdOut	BigInt Output
As
Set NoCount On;
/*********************************************************************
--* ======================================================================
--*  Author: Goran Banjac
--*  Date Created: 04/10/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonOrganization
*
*	Description:	
*
*	PARAMETERS: 
*		 @Id						BigInt = Null
*		,@OrganizationId			Int 
*		,@PersonId					BigInt
*		,@PersonOrganizationIdOut	BigInt Output
*				
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text	
*												
*********************************************************************/
	Declare @i Int

	Begin Try

			Merge dbo.PersonOrganization o 
			Using  (Select @Id, @OrganizationId, @PersonId) s 
				   (Id, OrganizationId, PersonId) 
				On o.Id = s.Id 
			When Matched Then 
				Update Set o.OrganizationId	= s.OrganizationId,
						   o.PersonId		= s.PersonId,
						   o.EditedOn		= GetDate()
			When Not Matched Then
				Insert (OrganizationId, PersonId)
				Values (s.OrganizationId, s.PersonId);

			Select @PersonOrganizationIdOut = IsNull(@Id,SCOPE_IDENTITY()) 

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

