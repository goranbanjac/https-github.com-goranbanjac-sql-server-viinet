CREATE PROCEDURE [dbo].[LockUser]
	@userId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		UPDATE	[SECU_User]
		SET		[Is_Locked] = 1
		WHERE	[SECU_User_ID] = @userId
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


