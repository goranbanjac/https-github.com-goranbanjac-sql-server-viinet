CREATE PROCEDURE [dbo].[Delete_SECU_Session]
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT,
			@Expire_Date DATETIME = GetDate()

	DELETE	[SECU_Session] WHERE [Expire_Date] <  @Expire_Date

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0

