

CREATE Procedure [dbo].[Add_PasswordPolicy]
		@Id					Int = null,
		@OrganizationId		Int,
		@MinLength			Int,
		@MinUppercase		Tinyint,
		@MinSymbol			Tinyint,
		@MinNumber			Tinyint,
		@NotPriorPasswords	Tinyint,
		@ExpireDays			Smallint,
		@MaxFailedLogin		Tinyint,
		@Challanges			Tinyint,
		@IdleMinutes		Tinyint
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/07/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PasswordPolicy
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		Id					int ,
*		OrganizationId		Int,
*		MinLength			Int,
*		MinUppercase		Tinyint,
*		MinSymbol			Tinyint,
*		MinNumber			Tinyint,
*		NotPriorPasswords	Tinyint,
*		ExpireDays			Tinyint,
*		MaxFailedLogin		Tinyint,
*		Challanges			Tinyint,
*		idleMinutes		Tinyint
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				merge	dbo.PasswordPolicy p
				using	(	select	@Id, @OrganizationId, @MinLength, @MinUppercase, @MinSymbol, @MinNumber, @NotPriorPasswords, @ExpireDays, @MaxFailedLogin, @Challanges, @IdleMinutes  ) s 
						(	Id, OrganizationId, MinLength, MinUppercase, MinSymbol, MinNumber, NotPriorPasswords, ExpireDays, MaxFailedLogin, Challanges, IdleMinutes  ) on 
							p.Id = s.Id 
				when matched 
					then update set 
									 p.MinLength			= s.MinLength, 
									 p.MinUppercase			= s.MinUppercase, 
									 p.MinSymbol			= s.MinSymbol, 
									 p.MinNumber			= s.MinNumber, 
									 p.NotPriorPasswords	= s.NotPriorPasswords, 
									 p.ExpireDays			= s.ExpireDays,
									 p.MaxFailedLogin		= s.MaxFailedLogin,
									 p.Challanges			= s.Challanges,
									 p.IdleMinutes			= s.IdleMinutes,
									 p.EditedOn				= getdate()
				when not matched 
					then insert ( OrganizationId, MinLength, MinUppercase, MinSymbol, MinNumber, NotPriorPasswords, ExpireDays, MaxFailedLogin, Challanges, IdleMinutes )
						values (s.OrganizationId, s.MinLength, s.MinUppercase, s.MinSymbol, s.MinNumber, s.NotPriorPasswords, s.ExpireDays, s.MaxFailedLogin, s.Challanges, s.IdleMinutes);

				Select IsNull(@Id,SCOPE_IDENTITY()) PasswordPolicyId

	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		If Xact_State() <> 0
			Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --ErrorLogID = ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
