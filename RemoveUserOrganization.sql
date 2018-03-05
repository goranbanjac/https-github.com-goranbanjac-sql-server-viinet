CREATE PROCEDURE [dbo].[RemoveUserOrganization]
	@orgUserIds NVARCHAR(4000)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE	@ids TABLE (item nvarchar(15) NOT NULL)
		INSERT	@ids (item) SELECT value FROM dbo.SplitStrings_Native(@orgUserIds, ',')
		DELETE	bu
		FROM	[SECU_Organization_User] bu
				inner join @ids i on bu.[SECU_Organization_User_ID] = i.[item]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


