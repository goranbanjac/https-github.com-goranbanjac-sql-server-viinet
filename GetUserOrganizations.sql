CREATE PROCEDURE [dbo].[GetUserOrganizations]
	@userId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT  org.[Id] AS orgId,
				[OrganizationName] AS orgName,
				bu.[Created_Date] AS createdDate,
				[SECU_Organization_User_ID] AS orgUserId,
				[SECU_User_ID] AS userId
		FROM	[SECU_Organization_User] bu
				inner join [Organization] org on bu.[OrganizationId] = org.[Id]
		WHERE	[SECU_User_ID] = @userId
		ORDER BY [OrganizationName]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


