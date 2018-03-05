CREATE PROCEDURE [dbo].[Get_SECU_Access_Control_Entity]
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT

		SELECT	*
		FROM	[dbo].[SECU_Access_Control_Entity]
		Where SECU_Access_Control_Entity_ID > 0
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
