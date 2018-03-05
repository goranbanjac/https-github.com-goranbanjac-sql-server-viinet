CREATE PROCEDURE [dbo].[CreateSession]
	@userId INT,
	@nextExpire DATETIME,
	@OrganizationId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE @token UNIQUEIDENTIFIER

	-- Remove expired tokens
	EXEC [dbo].[Delete_SECU_Session]

	IF EXISTS( SELECT 1 FROM [SECU_User] WHERE [SECU_User_ID] = @userId)
	BEGIN
		SET @token = NEWID()
		INSERT	[SECU_Session]
				(
					[Token],
					[SECU_User_ID],
					[Created_Date],
					[Expire_Date],
					[OrganizationId]
				)
		VALUES
				(
					@token,
					@userId,
					GETUTCDATE(),
					@nextExpire,
					@OrganizationId
				)
	END
	SELECT	@token AS token
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


