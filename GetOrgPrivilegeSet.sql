CREATE PROCEDURE [dbo].[GetOrgPrivilegeSet]
		@userId	INT,
		@orgId	INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT  [OrganizationName] AS orgName,
                r.[OrganizationId] AS orgId,
                ot.[Name] AS orgType,
				ace.[Name] AS acName,
				[Privilege] AS priv
		FROM	[SECU_User_Role] ur
                inner join [SECU_Role] r on ur.[SECU_Role_ID] = r.[SECU_Role_ID]
				inner join [Organization] org on r.[OrganizationId] = org.[Id]
                inner join [SECU_Role_Access_Privilege] rap on r.[SECU_Role_ID] = rap.[SECU_Role_ID]
				inner join [OrganizationType] ot on org.[OrganizationTypeId] = ot.[Id]
                inner join [SECU_Access_Control_Entity] ace on rap.[SECU_Access_Control_Entity_ID] = ace.[SECU_Access_Control_Entity_ID]
        WHERE	ur.[SECU_User_ID] = @userId and r.[OrganizationId] = @orgId
        ORDER BY acName
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
