CREATE PROCEDURE [dbo].[UpdateUser]
		@userId					INT,
		@homeorgId				INT,
		@User_Pwd_Hash			VARBINARY(128)		= null,
		@User_Pwd_Salt			VARBINARY(128)		= null,
		@Pwd_Expiration_Date	DATETIME			= null,
		@First_Name				NVARCHAR(50),
		@Last_Name				NVARCHAR(50),
		@Email					NVARCHAR(150),
		@Alt_Email				NVARCHAR(150) = NULL,
		@Is_Sys_Admin			BIT,
		@Is_Locked				BIT,
		@Must_Change_Pwd		BIT,
		@End_Date				DATETIME = NULL,
		@Home_Page				NVARCHAR(250) = NULL,
		@NPI					NVARCHAR(50) ,
		@User_Attributes		NVARCHAR(2000),
		@Gender					CHAR (1),
		@DOB					NVARCHAR(50) = NULL,
		@Email_Token			NVARCHAR(50)   ,
		@PersonTypeId			INT
AS
SET NOCOUNT ON
/*********************************************************************
--* ==================================================================
--*  Author: Gran Banjac 
--*  Date Created: 4/20/2017
--*  VSS: 
--*===================================================================
*
*	File Name:	UpdateUser
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
DECLARE @i				INT,
		@DateOfBirth	DATETIME

		Select @DateOfBirth = cast(@DOB As DATETIME)

	BEGIN TRY
		Begin Tran
			UPDATE	[SECU_User]
			SET		
				 User_Pwd_Hash			= @User_Pwd_Hash 
				,User_Pwd_Salt			= @User_Pwd_Salt 
				,Pwd_Expiration_Date	= @Pwd_Expiration_Date
				,First_Name				= @First_Name
				,Last_Name				= @Last_Name
				,Email					= @Email
				,Alt_Email				= @Alt_Email
				,Is_Sys_Admin			= @Is_Sys_Admin
				,Is_Locked				= @Is_Locked
				,Must_Change_Pwd		= @Must_Change_Pwd
				,End_Date				= @End_Date
				,Home_Page				= @Home_Page
				,NPI					= @NPI
				,User_Attributes		= @User_Attributes
				,Gender					= @Gender
				,Email_Token			= @Email_Token
				,EditedOn				= GetDate()
			WHERE	[SECU_User_ID]		= @userId

		
		-- Create entry in AddUserOrganization	
				Exec [dbo].[AddUserOrganization]
							@userId		= @userId,
							@orgId		= @homeorgId,
							@UserTypeId	= @PersonTypeId

			-- Create person from User
			Exec [dbo].[Add_PersonInfo]
							null	-- @PersonId
							,@userId								
							,null	-- @PersonOrganizationId		
							,null	-- @PersonEncounterId			
							,null	-- @PersonSearchId		
							,@homeorgId								
							,@PersonTypeId		-- Person Type
							,''		-- MRN	
							,''		-- EncounterId
							,@Gender
							,@DateOfBirth
							,@First_Name
							,''		-- MiddleName
							,@Last_Name
							,null	-- AdmitDateTime
							,null	-- DischargeDateTime
							,null	-- ProcedureDateTime
							,''		-- ProcedureCode
							,''		-- PhysicianId
							,''		-- PhysicianName
							,''		-- PersonEncounterAttributes
							,@User_Attributes
							,@Email
			Commit
END TRY
BEGIN CATCH
	-- Roll back any active or uncommittable transactions before
	If Xact_State() <> 0
		Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
