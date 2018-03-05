
CREATE Procedure [dbo].[Add_PersonUser]
			 @UserId			Int				
			,@PersonId			Int		
			,@PersonTypeId		Int
			,@OrganizationId	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 4/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonUser
*
*	Description:
*			
*
*	PARAMETERS: 
*			 @UserId			Int				
*			,@PersonId			Int		
*			,@PersonTypeId		Int
*			,@OrganizationId	Int	
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*  
*********************************************************************/
	Begin Try															

		Declare @i Int

			If Not Exists ( Select 1 From dbo.PersonUser Where UserId = @UserId and PersonId = @PersonId And OrganizationId = @OrganizationId )
				Insert dbo.PersonUser ( UserId, PersonId, PersonTypeId, OrganizationId )
				Values ( @UserId, @PersonId, @PersonTypeId, @OrganizationId )

	End Try  
	Begin Catch
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0


