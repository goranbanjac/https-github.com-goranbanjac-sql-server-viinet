CREATE PROCEDURE [dbo].[FindLoginId]
	@firstName NVARCHAR(50),
	@lastName NVARCHAR(50),
	@email NVARCHAR(150)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[User_Login_ID] AS loginId
		FROM	[SECU_User]
		Where	[First_Name] = @firstName and [Last_Name] = @lastName and [Email] = @email
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


