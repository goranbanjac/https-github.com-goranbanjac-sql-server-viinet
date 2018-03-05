CREATE PROCEDURE [dbo].[GetPrivOrgList]
		@userId INT,
		@isAdmin BIT,
		@category NVARCHAR(50),
		@ACname NVARCHAR(50),
		@privMask INT,
		@orgTypeId NVARCHAR(50) = NULL,
		@orgNameFilter NVARCHAR(150) = NULL,
		@all BIT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		IF @isAdmin = 1
		BEGIN
			SELECT	org.[Id] AS orgId,
					org.[OrganizationName] AS orgName,
					org.[OrganizationTypeId] AS orgTypeId,
					-1 AS priv,
					ot.[Name] AS orgType
			FROM	[Organization] org
					inner join [OrganizationType] ot on org.[OrganizationTypeId] = ot.[Id]
			WHERE	(ISNULL(@orgTypeId, '') ='' or @orgTypeId = ot.[Id]) 
					and (ISNULL(@orgNameFilter,'') = '' or org.[OrganizationName] like '%'+ @orgNameFilter +'%')
			ORDER BY org.[OrganizationName]
		END
		ELSE
		BEGIN 
			SELECT	org.[Id] AS orgId,
					org.[OrganizationName] AS orgName,
					org.[OrganizationTypeId] AS orgTypeId,
					rap.[Privilege] AS priv,
					ot.[Name] AS orgType
			FROM	[SECU_User_Role] ur
					inner join [SECU_Role] r on ur.[SECU_Role_ID] = r.[SECU_Role_ID]
					inner join [Organization] org on r.[OrganizationId] = org.[Id]
					inner join [OrganizationType] ot on org.[OrganizationTypeId] = ot.[Id]
					inner join [SECU_Role_Access_Privilege] rap on r.[SECU_Role_ID] = rap.[SECU_Role_ID]
					inner join [SECU_Access_Control_Entity] ace on rap.[SECU_Access_Control_Entity_ID] = ace.[SECU_Access_Control_Entity_ID]
			WHERE	((ur.[SECU_User_ID] = @userId and ace.[Category] = @category and ace.[Name] = @ACname and (0 <> (rap.[Privilege] & @privMask))))
					and (ISNULL(@orgTypeId, '') ='' or @orgTypeId = ot.[Id])
					and (ISNULL(@orgNameFilter,'') = '' or org.[OrganizationName] like '%'+ @orgNameFilter +'%')
			ORDER BY org.[OrganizationName]
		END
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


