CREATE PROCEDURE [dbo].[DeleteRolePrivileges]
	@rapIds NVARCHAR(4000)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE	@ids TABLE (item nvarchar(15) NOT NULL)
		INSERT	@ids (item) SELECT value FROM dbo.SplitStrings_Native(@rapIds, ',')
		DELETE	rap
		FROM	[SECU_Role_Access_Privilege] rap
				inner join @ids i on rap.[SECU_Role_Access_Privilege_ID] = i.[item]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


