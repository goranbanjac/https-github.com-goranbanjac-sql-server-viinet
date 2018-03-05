CREATE PROCEDURE [dbo].[AddUserRole]
	@userId INT,
	@roleId INT,
	@Propagate BIT
AS
SET NOCOUNT ON
Begin Try

	DECLARE @i	Int
	DECLARE @Role Table ( RoleId int );

		If Exists ( Select 1 From dbo.SECU_User_Role where SECU_User_ID = @userId And SECU_Role_ID = @roleId )
			Throw 50001, N'User already belongs to given role', 1;

		If @Propagate = 1
			Begin
				-- Find all propagated role 	
					INSERT @Role ( RoleId )
					SELECT @roleId
					UNION ALL
					SELECT SECU_Role_ID FROM dbo.SECU_Role WHERE PropagatedRoleId = @roleId

				-- If role doesn't exist add	
					INSERT dbo.SECU_User_Role ( SECU_User_ID, SECU_Role_ID, Created_Date )
					SELECT @userId, RoleId,  GETUTCDATE()
					FROM @Role r
					LEFT OUTER JOIN dbo.SECU_User_Role s ON
						r.RoleId = s.SECU_Role_ID
					AND s.SECU_User_ID = @userId
					WHERE s.SECU_Role_ID IS NULL
					AND s.SECU_User_ID IS NULL
			End
		Else
			
					INSERT dbo.SECU_User_Role
							(
								[SECU_User_ID],
								[SECU_Role_ID],
								[Created_Date]
							)
							VALUES
							(
								@userId,
								@roleId,
								GETUTCDATE()
							);
End Try
Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
End Catch
RETURN 0
