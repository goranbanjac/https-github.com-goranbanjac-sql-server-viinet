CREATE PROCEDURE [dbo].[GetRoleList]
	@orgId INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[SECU_Role_ID] AS roleId,
				[OrganizationId] AS orgId,
				[Role_Name] AS roleName,
				[Description] AS descr,
				[Create_Date] AS createdDate,
				[Propagate] AS Propagate
		FROM	[SECU_Role]
		where	[OrganizationId] = @orgId
		ORDER BY Role_Name
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


