
CREATE Procedure [dbo].[Add_PersonInfo]
					 @PersonId					BIGINT		   = null
					,@UserId					BIGINT		   = null
					,@PersonOrganizationId		BIGINT		   = null
					,@PersonEncounterId			BIGINT		   = null	
					,@PersonSearchId			BIGINT		   = null
					,@OrganizationId			INT					
					,@PersonTypeId				INT
					,@MRN						NVARCHAR (50)   = ''	
					,@EncounterId				NVARCHAR (50)   = ''	
					,@Gender					NVARCHAR (50)   = ''     
					,@DateOfBirth				DATETIME       = null
					,@FirstName					NVARCHAR (50)   = '' 
					,@MiddleName				NVARCHAR (50)   = ''
					,@LastName					NVARCHAR (50)   = ''
					,@AdmitDateTime				DATETIME	   = null 
					,@DischargeDateTime			DATETIME	   = null 
					,@ProcedureDateTime			DATETIME	   = null 
					,@ProcedureCode				NVARCHAR(255)   = '' 
					,@PhysicianId				NVARCHAR (50)   = ''
					,@PhysicianName				NVARCHAR (50)   = ''
					,@PersonEncounterAttributes	NVARCHAR (4000) = ''
					,@User_Attributes			NVARCHAR (2000) = ''
					,@PrimaryEmailAddress		NVARCHAR (100)  = ''	

As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/9/2016
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonInfo
*
*	Description:
*			
*		 @PersonId					BIGINT		   = null
*		,@UserId					BIGINT		   = null
*		,@PersonOrganizationId		BIGINT		   = null
*		,@PersonEncounterId			BIGINT		   = null	
*		,@PersonSearchId			BIGINT		   = null
*		,@OrganizationId			INT					
*		,@PersonTypeId				INT
*		,@MRN						VARCHAR (50)   = ''	
*		,@EncounterId				VARCHAR (50)   = ''	
*		,@Gender					VARCHAR (50)   = ''     
*		,@DateOfBirth				DATETIME       = null
*		,@FirstName					VARCHAR (50)   = '' 
*		,@MiddleName				VARCHAR (50)   = ''
*		,@LastName					VARCHAR (50)   = ''
*		,@AdmitDateTime				DATETIME	   = null 
*		,@DischargeDateTime			DATETIME	   = null 
*		,@ProcedureDateTime			DATETIME	   = null 
*		,@ProcedureCode				VARCHAR(255)   = '' 
*		,@PhysicianId				VARCHAR (50)   = ''
*		,@PhysicianName				VARCHAR (50)   = ''
*		,@PersonEncounterAttributes	VARCHAR (5000) = ''
*		,@User_Attributes			VARCHAR (2000) = ''
*		,@PrimaryEmailAddress		VARCHAR (100)  = ''	
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*  
*********************************************************************/
Begin Try
	Declare 
		  @i						Int	
		 ,@Exec						Int
		 ,@PersonOrganizationIdOut	BigInt
		 ,@PersonIdOut				BigInt
		 ,@PersonEncounterIdOut		BigInt

		Begin Tran
			
				If @PersonTypeId in (1, 2)
					Begin
						Select @PersonId = PersonId From dbo.PersonUser where UserId = @UserId 
							If @PersonId Is Not Null
							-- Update Person  
								Exec @Exec = dbo.Add_Person @PersonId, @PersonTypeId, @FirstName, @MiddleName, @LastName, @Gender, @DateOfBirth, @User_Attributes, @PrimaryEmailAddress, @PersonIdOut Out
							Else
							-- Add Person - User 
								Begin
									Exec @Exec = dbo.Add_Person null, @PersonTypeId, @FirstName, @MiddleName, @LastName, @Gender, @DateOfBirth, @User_Attributes, @PrimaryEmailAddress, @PersonIdOut Out
									Exec @Exec = dbo.Add_PersonUser @UserId, @PersonIdOut, @PersonTypeId, @OrganizationId 	
								End

							Commit Tran
								Return 0
					End
			-- Add Person 
					Exec @Exec = dbo.Add_Person @PersonId, @PersonTypeId, @FirstName, @MiddleName, @LastName, @Gender, @DateOfBirth, @User_Attributes, @PrimaryEmailAddress, @PersonIdOut Out
			-- Add Person Organization 
				If Not Exists ( Select 1 From dbo.PersonOrganization Where OrganizationId = @OrganizationId And PersonId = @PersonId )
					Exec @Exec =  dbo.Add_PersonOrganization @PersonOrganizationId, @OrganizationId, @PersonIdOut, @PersonOrganizationIdOut Out	
			-- Add Person Encounter
				--If @PersonTypeId = 1
				--	Begin
				--		Exec @Exec = dbo.Add_PersonEncounter @PersonEncounterId, @PersonOrganizationIdOut, @MRN, @EncounterId, @AdmitDateTime, @DischargeDateTime, @ProcedureDateTime, @ProcedureCode, @PersonEncounterAttributes, @PersonEncounterIdOut Out	
					-- Add Person Search 
						--If Not Exists ( Select 1 From dbo.PersonSearch Where Id = @PersonSearchId And LastName = @LastName And MRN = @MRN )
						--	Exec @Exec = dbo.Add_PersonSearch @PersonSearchId, @PersonIdOut, @PersonOrganizationIdOut, @PersonEncounterIdOut, @OrganizationId, @LastName, @MRN
					--End
		Commit
End Try
Begin Catch
	-- Roll back any active or uncommittable transactions before
	If Xact_State() <> 0
		Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
End Catch
RETURN 0
