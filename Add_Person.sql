
CREATE Procedure [dbo].[Add_Person]
			 @Id					Int				= NULL
			,@PersonTypeId			Int
			,@FirstName				NVarchar(50)		
		    ,@MiddleName			NVARCHAR (50)	= ''
			,@LastName				NVarchar(50)		
			,@Gender				NVarchar(50)		
			,@DateOfBirth			Datetime		
			,@User_Attributes		NVarchar(2000)	= ''
			,@PrimaryEmailAddress	NVarchar(100)	= ''
			,@PersonIdOut			BigInt Output
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 4/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_Person
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*  
*********************************************************************/
	Begin Try

		Declare  @i						Int
				,@PersonAssignmentId	BigInt
				,@PersonAttribute		NVarchar (1000)

			If @Id Is Not Null
			And @PersonTypeId = 1 -- Registered Patient
				Begin
					Select @PersonAssignmentId = PersonAssignmentId From dbo.ProviderAssignment Where PersonId = @Id
						If @PersonAssignmentId Is Not Null
							Begin
								Set @PersonAttribute = ( SELECT @FirstName FirstName, 
																@MiddleName MiddleName, 
																@LastName LastName, 
																@Gender Gender, 
																@DateOfBirth DateOfBirth, 
																@PrimaryEmailAddress  PrimaryEmailAddress
														FOR JSON PATH ) 

								Exec[dbo].[Add_ProviderAssignment]
									 @PersonId				= @Id	
									,@PersonAssignmentId	= @PersonAssignmentId	
									,@PersonAttribute		= @PersonAttribute
							End
				End

				merge	dbo.Person p
				using	(	select	@Id, @FirstName, @MiddleName, @LastName, @Gender, @DateOfBirth, @User_Attributes, @PrimaryEmailAddress ) s 
						(	Id, FirstName, MiddleName, LastName, Gender, DateOfBirth, PersonAttributes, PrimaryEmailAddress ) on 
							p.Id = s.Id 
				when matched 
					then update set 
									 p.FirstName			= s.FirstName
									,p.MiddleName			= s.MiddleName
									,p.LastName				= s.LastName
									,p.Gender				= s.Gender
									,p.DateOfBirth			= s.DateOfBirth
									,p.PersonAttributes		= s.PersonAttributes
									,p.PrimaryEmailAddress	= s.PrimaryEmailAddress
									,p.EditedOn				= getdate()
				when not matched 
					then insert (FirstName, MiddleName, LastName, Gender, DateOfBirth, PersonAttributes, PrimaryEmailAddress )
						values (s.FirstName, s.MiddleName, s.LastName, s.Gender, s.DateOfBirth, s.PersonAttributes, s.PrimaryEmailAddress);

				Select @PersonIdOut = IsNull(@Id,SCOPE_IDENTITY()) 

	End Try  
	Begin Catch
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0