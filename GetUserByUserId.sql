CREATE PROCEDURE [dbo].[GetUserByUserId]
	@SECU_User_ID INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT


		SELECT	u.[SECU_User_ID] AS userId,
				[User_Login_ID] AS loginId,
				[User_Pwd_Hash] AS pwdHash,
				[User_Pwd_Salt] AS pwdSalt,
				[Pwd_Expiration_Date] AS pwdExp,
				[First_Name] AS firstName,
				[Last_Name] AS lastName,
				[Email] AS email,
				[Alt_Email] AS altEmail,
				[Is_Sys_Admin] AS isAdmin,
				[Is_Locked] AS isLocked,
				[Must_Change_Pwd] AS changePwd,
				[Failed_Logins] AS badlogins,
				u.[Created_Date] AS createdDate,
				u.[Valid_Date] AS validDate,
				u.[End_Date] AS endDate,
				[Home_Org_ID] AS homeorgId,
				[Home_Page] as homePage,
				og.[OrganizationName] AS homeorgName,
				u.NPI,
				u.User_Attributes,
				u.Gender,
				u.Email_Token,
				ou.UserTypeId 
		FROM	[SECU_User] u
				left join [Organization] og on u.[Home_Org_ID] = og.[Id]
				left join [SECU_Organization_User] ou on ou.[SECU_User_ID] = u.[SECU_User_ID]
		WHERE	u.[SECU_User_ID] = @SECU_User_ID 
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
