CREATE PROCEDURE [dbo].[GetSessionUser]
	@token UNIQUEIDENTIFIER
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	u.[SECU_User_ID] AS userId,
				[User_Login_ID] AS loginId,
				[User_Pwd_Hash] AS pwdHash,
				[User_Pwd_Salt] AS pwdSalt,
				[Pwd_Expiration_Date] AS expDate,
				[First_Name] AS firstName,
				[Last_Name] AS lastName,
				[Email] AS email,
				[Alt_Email] AS altEmail,
				[Is_Sys_Admin] AS isAdmin,
				[Is_Locked] AS isLocked,
				[Must_Change_Pwd] AS pwdChage,
				[Failed_Logins] AS badLogins,
				u.[Created_Date] AS createdDate,
				u.[Valid_Date] AS validDate,
				u.[End_Date] AS endDate,
				[Home_Org_ID] AS homeorgId,
				[Home_Page] AS homePage,
				s.[Expire_Date] AS tokenExpDate,
				s.OrganizationId
		FROM	[SECU_Session] s
				inner join [SECU_User] u on u.[SECU_User_ID] = s.[SECU_User_ID]
		WHERE	s.[Token] = @token
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


