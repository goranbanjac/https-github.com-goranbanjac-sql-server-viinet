CREATE PROCEDURE [dbo].[ExpireToken]
	@token UNIQUEIDENTIFIER
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		UPDATE	[SECU_Session]
		SET		[Expire_Date] = GETUTCDATE()
		WHERE	Token = @token
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


