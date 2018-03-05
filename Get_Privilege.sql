CREATE PROCEDURE [dbo].[Get_Privilege]
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT

	Select * From SECU_Privilege
	Where Id > 0

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
