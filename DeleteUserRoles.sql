CREATE PROCEDURE [dbo].[DeleteUserRoles]
	@useRoleIds NVARCHAR(4000)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE	@ids TABLE (item nvarchar(15) NOT NULL)
		INSERT	@ids (item) SELECT value FROM dbo.SplitStrings_Native(@useRoleIds, ',')
		DELETE	ur
		FROM	[SECU_User_Role] ur
				inner join @ids i on ur.[SECU_User_Role_ID] = i.[item]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
