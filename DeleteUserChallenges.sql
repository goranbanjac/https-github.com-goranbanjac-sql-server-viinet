CREATE PROCEDURE [dbo].[DeleteUserChallenges]
	@userId	INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		DELETE	[SECU_User_Challenge]
		WHERE	[SECU_User_ID] = @userId
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


