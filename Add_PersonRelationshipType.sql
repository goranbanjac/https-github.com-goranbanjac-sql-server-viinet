CREATE Procedure [dbo].[Add_PersonRelationshipType]
						 @PersonRelationshipTypeId	Int		= null
						,@FirstPersonId				BigInt
						,@SecondPersonId			BigInt
						,@FirstRelationshipId		Tinyint = 10
						,@SecondRelationshipId		Tinyint
						
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 1/12/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonRelationshipType.sql
*
*	Description:
*					 @PersonRelationshipTypeId	Int		= null
*				    ,@FirstPersonId				BigInt
*					,@SecondPersonId			BigInt
*					,@FirstRelationshipId		Tinyint = 10
*					,@SecondRelationshipId		Tinyint
*
*	PARAMETERS:
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
	Declare @i						Int,
			@Id						Int,
			@PersonRelationshipId	Int			

		--Begin Tran

		--	Select @Id = IsNull(@PersonRelationshipTypeId,Id) 
		--		From dbo.PersonRelationshipType 
		--	Where FirstIsToSecondId = @FirstRelationshipId 
		--	And   SecondIsToFirstId = @SecondRelationshipId

		--	Select @PersonRelationshipId  = Id
		--		From dbo.PersonRelationship 
		--	Where FirstPersonId  = @FirstPersonId 
		--	And   SecondPersonId = @SecondPersonId

		--	If @Id Is Null
		--		Begin
		--			Insert dbo.PersonRelationshipType ( FirstIsToSecondId, SecondIsToFirstId )
		--			Values ( @FirstRelationshipId, @SecondRelationshipId )
		--			Select @Id = SCOPE_IDENTITY();

		--			If IsNull(@Id,'') <> ''
		--				Exec  [dbo].[Add_PersonRelationship] @PersonRelationshipId, @FirstPersonId, @SecondPersonId, @Id, ''
		--		End
		--	Else
		--		Begin
		--			If IsNull(@PersonRelationshipTypeId,'') <> ''
		--				Update dbo.PersonRelationshipType 
		--				Set FirstIsToSecondId = @FirstRelationshipId,
		--					SecondIsToFirstId = @SecondRelationshipId,
		--					EditedOn		  = GetDate()
		--				Where Id = @Id

		--			Exec  [dbo].[Add_PersonRelationship] @PersonRelationshipId, @FirstPersonId, @SecondPersonId, @Id, ''
		--		End
		--Commit

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


--exec [dbo].[Add_PersonRelationshipType]
--						 @PersonRelationshipTypeId	= null
--						,@FirstPersonId				= 1020
--						,@SecondPersonId			= 1022
--						,@FirstRelationshipId		= 10
--						,@SecondRelationshipId		= 6

