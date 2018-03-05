CREATE PROCEDURE [dbo].[IsDuplicateRole]
	@orgId	INT,
	@name	NVARCHAR(50)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	CAST(
					CASE WHEN EXISTS (SELECT 1 FROM	[SECU_Role] WHERE	[OrganizationId] = @orgId and [Role_Name] = @name)
					THEN 1	ELSE 0	END
				AS BIT
				)
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


