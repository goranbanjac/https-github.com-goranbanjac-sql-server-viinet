CREATE PROCEDURE [dbo].[GetUserPwdHistories]
	@userId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[SECU_User_Pwd_History_ID] AS pedHistId,
				[SECU_User_ID] AS userId,
				[User_Pwd_Hash] AS pwdHash,
				[User_Pwd_Salt] AS pwdSalt,
				[Expiration_Date] AS expDate
		FROM	[SECU_User_Pwd_History]
		WHERE	[SECU_User_ID] = @userId
		ORDER BY [Expiration_Date] DESC
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


