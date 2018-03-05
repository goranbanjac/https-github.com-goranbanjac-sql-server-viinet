CREATE PROCEDURE [dbo].[GetRolePrivileges]
	@roleId	INT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[SECU_Role_Access_Privilege_ID] AS rapId,
				e.SECU_Access_Control_Entity_ID ,
				[Category] AS cat,
				[Name] AS name,
				[Privilege] AS priv,
				r.[SECU_Role_ID] AS roleId,
				r.[Propagate] AS Propagate
		FROM	[SECU_Access_Control_Entity] e
				inner join [SECU_Role_Access_Privilege] rp on rp.SECU_Access_Control_Entity_ID = e.SECU_Access_Control_Entity_ID and rp.[SECU_Role_ID] = @roleId
				inner join [SECU_Role] r on r.[SECU_Role_ID] = rp.[SECU_Role_ID]
		WHERE e.SECU_Access_Control_Entity_ID > 0 -- for index hint
		ORDER BY e.Category, e.Name
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
