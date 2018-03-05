
 
CREATE Procedure [dbo].[Get_PersonById]
			@PersonId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 7/29/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PersonType
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
					 Id
					,FirstName
					,LastName
					,Gender
					,DateOfBirth
					,MiddleName
					,PersonAttributes
					,PrimaryEmailAddress
				From dbo.Person
				Where Id = @PersonId
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
