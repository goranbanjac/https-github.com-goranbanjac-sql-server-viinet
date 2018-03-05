CREATE PROCEDURE [dbo].[Add_User]
			@User_Login_ID		NVARCHAR(50),
			@pwdHash			BINARY(64) = NULL,
			@pwdSalt			BINARY(64) = NULL,
			@pwdExp				DATETIME = NULL,
			@firstName			NVARCHAR(50),
			@lastName			NVARCHAR(50),
			@email				NVARCHAR(150),
			@altEmail			NVARCHAR(150) = NULL,
			@isAdmin			BIT,
			@isLocked			BIT,
			@changePwd			BIT,
			@badLogins			INT,
			@createdDate		DATETIME,
			@validDate			DATETIME,
			@endDate			DATETIME = NULL,
			@homeorgId			INT,
			@homePage			NVARCHAR(250) = NULL,
			@NPI				NVARCHAR(50)  = NULL,
			@User_Attributes	NVARCHAR(2000) = '',
			@Gender				CHAR(1),
			@Email_Token		NVARCHAR(50)                                                                         
AS
SET NOCOUNT ON
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 4/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_User
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
* Test Case:
*
*	DBCC CHECKIDENT ('[SECU_User]', RESEED, 1);
*	GO
*	Exec [dbo].[Add_User]
*			@User_Login_ID		= 'gbanjac@viimed.com',
*			@pwdHash  = null,
*			@pwdSalt  = null,
*			@pwdExp	 = NULL,
*			@firstName = 'David' ,
*			@lastName = 'Beckham',
*			@email  = 'gbanjac@viimed.com',
*			@altEmail  = NULL,
*			@isAdmin = 0,
*			@isLocked  = 0,
*			@changePwd = 0,
*			@badLogins = 0 ,
*			@createdDate = '2017-06-23 22:03:49.813' ,
*			@validDate = '2017-06-23 22:04:05.467'  ,
*			@endDate  = NULL,
*			@homeorgId = 1 ,
*			@homePage  = NULL,
*			@NPI = 3425167,
*			@User_Attributes = '',
*			@Gender = 'M'

*********************************************************************/
BEGIN TRY
	DECLARE @i INT
	SELECT @validDate = GETDATE();

		If Exists ( Select 1 From dbo.SECU_User  Where home_org_Id = @homeorgId And email = @email)
				Throw 50001, N'This email already exist for given Organization', 1


			INSERT dbo.SECU_User 
					(
					User_Login_ID,
					User_Pwd_Hash,
					User_Pwd_Salt,
					Pwd_Expiration_Date,
					First_Name,
					Last_Name,
					email,
					alt_Email,
					Is_Sys_Admin,
					Is_Locked,
					Must_Change_Pwd,
					Failed_Logins,
					created_Date,
					valid_Date,
					end_Date,
					home_org_Id,
					home_Page,
					NPI,
					User_Attributes,
					Gender,
					Email_Token
					)
			SELECT 
					@User_Login_ID,
					@pwdHash,
					@pwdSalt,
					@pwdExp,
					@firstName,
					@lastName,
					@email,
					@altEmail,
					@isAdmin,
					@isLocked,
					@changePwd,
					@badLogins,
					@createdDate,
					@validDate,
					@endDate,
					@homeorgId,
					@homePage,
					@NPI,
					@User_Attributes,
					@Gender,
					@Email_Token
				
					SELECT CAST(SCOPE_IDENTITY() AS INT) AS userId

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

	

