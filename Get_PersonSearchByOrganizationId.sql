
CREATE PROCEDURE [dbo].[Get_PersonSearchByOrganizationId]
	 @OrganizationId	Int
    ,@PersonTypeId		Int 
AS
DECLARE	@i Int

	Begin Try

		;with a as
			(
				select PersonId from dbo.PersonUser Where OrganizationId = @OrganizationId And PersonTypeId = @PersonTypeId
			)
				Select 
					Id
					,@PersonTypeId PersonTypeId
					,FirstName
					,LastName
					,Gender
					,DateOfBirth
					,MiddleName
					,PersonAttributes
					,PrimaryEmailAddress
				From dbo.Person
				Where Id in ( Select PersonId from a )

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
RETURN 0


