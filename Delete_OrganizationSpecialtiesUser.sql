CREATE PROCEDURE [dbo].[Delete_OrganizationSpecialtiesUser]
	@SpecialtiesUserIds NVARCHAR(4000)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE	@ids TABLE (item nvarchar(15) NOT NULL)
		INSERT	@ids (item) SELECT value FROM dbo.SplitStrings_Native(@SpecialtiesUserIds, ',')
		DELETE	ur
		FROM	 [dbo].[OrganizationSpecialtiesUser] ur
				inner join @ids i on ur.[Id] = i.[item]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
