CREATE Procedure [dbo].[Get_PasswordPolicy]
			@OrganizationId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 7/29/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PasswordPolicy]
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*		OrganizationId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Select 
			 Id 
			,OrganizationId
			,MinLength		
			,MinUppercase		
			,MinSymbol			
			,MinNumber			
			,NotPriorPasswords	
			,ExpireDays			
			,MaxFailedLogin		
			,Challanges			
			,IdleMinutes 
		From dbo.PasswordPolicy 
		Where OrganizationId = @OrganizationId
	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		--If Xact_State() <> 0
		--	Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --ErrorLogID = ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
