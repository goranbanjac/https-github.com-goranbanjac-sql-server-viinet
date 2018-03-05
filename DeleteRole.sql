CREATE PROCEDURE [dbo].[DeleteRole]
	@roleId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT

	DELETE	[SECU_Role]
	WHERE	[SECU_Role_ID] = @roleId

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


