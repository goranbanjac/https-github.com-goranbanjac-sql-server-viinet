CREATE PROCEDURE [dbo].[GetUserOrganizationsByIds]
	@orgUserIds NVARCHAR(4000)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE	@ids TABLE (item nvarchar(15) NOT NULL)
		INSERT @ids (item) SELECT value FROM dbo.SplitStrings_Native(@orgUserIds, ',')
		SELECT  org.[Id] AS orgId,
				[OrganizationName] AS orgName,
				bu.[Created_Date] AS createdDate,
				[SECU_Organization_User_ID] AS orgUserId,
				[SECU_User_ID] AS userId
		FROM	[SECU_Organization_User] bu
				inner join [Organization] org on bu.[OrganizationId] = org.[Id]
				inner join @ids i on bu.[SECU_Organization_User_ID] = i.[item]
		ORDER BY [OrganizationName]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


