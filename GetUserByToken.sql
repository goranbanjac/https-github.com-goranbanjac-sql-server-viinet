CREATE PROCEDURE [dbo].[GetUserByToken]
		@Token uniqueidentifier
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT  [OrganizationId],
				[SECU_User_ID],
				[Expire_Date]
		FROM	[dbo].[SECU_Session] bu
		WHERE	[Token] = @Token

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
