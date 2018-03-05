CREATE PROCEDURE [dbo].[SaveRolePrivilege]
	@roleId INT,
	@entityId INT, 
	@priv INT,
	@Propagate BIT
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE @Role Table ( RoleId int );

		If @Propagate = 1
			Begin
				-- Find all propagated role 	
					INSERT @Role ( RoleId )
					SELECT @roleId
					UNION ALL
					SELECT SECU_Role_ID FROM dbo.SECU_Role WHERE PropagatedRoleId = @roleId
	
				-- If role already exist update permission 
					UPDATE s 
					SET [Privilege] = @priv,
					EditedOn = GETUTCDATE()
					FROM dbo.SECU_Role_Access_Privilege s
					INNER JOIN @Role r ON
						s.SECU_Role_ID = r.RoleId
					AND s.SECU_Access_Control_Entity_ID   = @entityId

				-- If role doesn't exist add	
					INSERT dbo.SECU_Role_Access_Privilege ( SECU_Role_ID, SECU_Access_Control_Entity_ID, Privilege, CreatedOn )
					SELECT RoleId, @entityId, @priv, GETUTCDATE()
					FROM @Role r
					LEFT OUTER JOIN dbo.SECU_Role_Access_Privilege s ON
						r.RoleId = s.SECU_Role_ID
					AND s.SECU_Access_Control_Entity_ID = @entityId
					WHERE s.SECU_Role_ID IS NULL
					AND s.SECU_Access_Control_Entity_ID IS NULL
			End
		Else
				MERGE	dbo.SECU_Role_Access_Privilege T
				Using	(SELECT @roleId AS roleId, @entityId AS CategoryId, @priv AS priv, GETUTCDATE() AS CreatedOn) S
				ON		T.SECU_Role_ID = S.roleId and T.SECU_Access_Control_Entity_ID = S.CategoryId
				WHEN	NOT MATCHED BY TARGET
				THEN	INSERT
							(
								SECU_Role_ID,
								SECU_Access_Control_Entity_ID,
								Privilege,
								CreatedOn
							)
						VALUES
							(
								@roleId,
								@entityId,
								@priv,
								CreatedOn
							)
				WHEN MATCHED THEN	UPDATE
						SET [Privilege] = @priv,
						EditedOn		= GETUTCDATE();
				
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
