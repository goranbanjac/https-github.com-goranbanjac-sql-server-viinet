CREATE PROCEDURE [dbo].[ChangePwd]
	@UserId  INT,
	--@loginId NVARCHAR(50),
	@pwdHash VARBINARY(64),
	@salt VARBINARY(64),
	@changePwd BIT,
	@nextExpire DATETIME = NULL
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	BEGIN TRAN
		IF EXISTS ( Select 1 from [SECU_User] Where [SECU_User_ID] = @UserId and [User_Pwd_Hash] is not null  )
			INSERT	[SECU_User_Pwd_History]
					(
						[SECU_User_ID],
						[User_Pwd_Hash],
						[User_Pwd_Salt],
						[Expiration_Date]
					)
			SELECT	[SECU_User_ID],
					[User_Pwd_Hash],
					[User_Pwd_Salt],
					GETUTCDATE()
			FROM	[SECU_User]
			WHERE	[SECU_User_ID] = @UserId

		UPDATE	[SECU_User]
		SET		[User_Pwd_Hash] = @pwdHash,
                [User_Pwd_Salt] = @salt,
                [Must_Change_Pwd] = @changePwd,
                [Pwd_Expiration_Date] = @nextExpire
		WHERE	[SECU_User_ID] = @UserId
	COMMIT TRAN
END TRY
BEGIN CATCH
	-- Roll back any active or uncommittable transactions before
	If Xact_State() <> 0
		Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


