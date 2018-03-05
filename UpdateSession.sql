CREATE PROCEDURE [dbo].[UpdateSession]
	@token				UNIQUEIDENTIFIER,
	@nextExpire			DATETIME,
	@OrganizationId		INT
AS
	UPDATE	[SECU_Session]
	SET		[OrganizationId] = @OrganizationId,
			[Expire_Date] = @nextExpire
	WHERE	[Token] = @token

RETURN @@Error

