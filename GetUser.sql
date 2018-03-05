CREATE Procedure [dbo].[GetUser]
	@SECU_User_ID INT = NULL,
	@LoginID NVarchar (50) = ''
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT

		If @SECU_User_ID Is Null
			Select @SECU_User_ID = SECU_User_ID From dbo.SECU_User where User_Login_ID = @LoginID

				Exec [dbo].[GetUserByUserId]
						@SECU_User_ID = @SECU_User_ID

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
