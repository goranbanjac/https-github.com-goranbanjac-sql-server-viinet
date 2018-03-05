CREATE PROCEDURE [dbo].[GetRole]
	@roleId	INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[SECU_Role_ID] AS roleId,
				r.[OrganizationId] AS orgId,
				[OrganizationName] AS orgName,
				[Role_Name] AS roleName,
				r.[Description] AS descr,
				r.[Create_Date] AS createdDate,
				r.[Propagate] AS Propagate
		FROM	[SECU_Role] r
				inner join [Organization] org on r.[OrganizationId] = org.[Id]
		WHERE	r.[SECU_Role_ID] = @roleId
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


