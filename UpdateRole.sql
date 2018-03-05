CREATE PROCEDURE [dbo].[UpdateRole]
    @roleId INT,
	@OrganizationId INT,
    @roleName NVARCHAR(50),
    @descr NVARCHAR(500) = NULL,
	@Propagate BIT
AS
BEGIN TRY
DECLARE @i INT

	If Exists ( Select 1 From dbo.SECU_Role where [SECU_Role_ID] = @roleId And [Propagate] <> @Propagate And @Propagate = 1  )
		Begin
			EXEC [dbo].[CreateRole]
				@orgId			= @OrganizationId,
				@roleName		= @roleName,
				@descr			= @descr,
				@Propagate		= @Propagate,
				@UpdatedRoleId	= @roleId

			UPDATE	[SECU_Role]
			SET     [Role_Name] = @roleName,
					[Description] = @descr,
					[Propagate] = @Propagate,
					[EditedOn] = GETUTCDATE(),
					[PropagatedRoleId] = 0
			WHERE	[SECU_Role_ID] = @roleId
		End
	Else
		UPDATE	[SECU_Role]
			SET     [Role_Name] = @roleName,
					[Description] = @descr,
					[Propagate] = @Propagate,
					[EditedOn] = GETUTCDATE()
			WHERE	[SECU_Role_ID] = @roleId

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
