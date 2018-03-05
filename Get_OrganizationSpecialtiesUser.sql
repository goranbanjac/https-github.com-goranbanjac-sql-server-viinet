
CREATE Procedure [dbo].[Get_OrganizationSpecialtiesUser]
		 @OrganizationId	int
		,@SECU_User_ID		int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/25/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrganizationSpecialtiesUser
*
*	Description:
*			
*
*	PARAMETERS: 
*		@Id					int	= null
*		,@OrganizationId	int
*		,@Specialties		Varchar(100)
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int		
	
			Select ou.Id OrganizationUserSpecialtiesId, OrganizationSpecialtieId, Specialties 
			From dbo.OrganizationSpecialtiesUser ou
			Inner Join dbo.OrganizationSpecialties os On
				ou.OrganizationSpecialtieId = os.Id
			Where ( @OrganizationId Is Null Or os.OrganizationId = @OrganizationId) 
			And (@SECU_User_ID Is Null Or SECU_User_ID = @SECU_User_ID)
				
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
