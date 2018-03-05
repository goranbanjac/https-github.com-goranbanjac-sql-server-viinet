CREATE PROCEDURE [dbo].[GetUserAllRoles]
	@userId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[Role_Name] AS roleName,
				r.[SECU_Role_ID] AS roleId,
				r.Propagate,
				ur.[SECU_User_ID] AS userId,
				[SECU_User_Role_ID] AS userRoleId,
				[OrganizationId] AS orgId,
				o.OrganizationName
		FROM	[SECU_Role] r
				Inner join [SECU_User_Role] ur on ur.[SECU_Role_ID] = r.[SECU_Role_ID] and ur.[SECU_User_ID] = @userId
				Inner Join dbo.Organization o on r.OrganizationId = o.Id
		ORDER BY [Role_Name]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0

