CREATE PROCEDURE [dbo].[GetUsersFromRole]
	@roleId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT  u.[SECU_User_ID] AS userId,
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
				[Valid_Date] AS validDate,
				[End_Date] AS endDate,
				[Home_Org_ID] AS homeorgId,
				[Home_Page] as homePage
		FROM	[SECU_User] u
				inner join [SECU_User_Role] ur on u.[SECU_User_ID] = ur.[SECU_User_ID]
		WHERE	ur.[SECU_Role_ID] = @roleId
		ORDER BY [Last_Name], [First_Name]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


