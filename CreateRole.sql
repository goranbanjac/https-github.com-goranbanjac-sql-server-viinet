CREATE PROCEDURE [dbo].[CreateRole]
    @orgId INT,
    @roleName NVARCHAR(50),
    @descr NVARCHAR(500) = NULL,
	@Propagate BIT,
	@UpdatedRoleId INT = NULL
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
	DECLARE	@roleId INT
	DECLARE @OrganizationId Table ( OrganizationId int );

		WITH DirectReports (OrganizationId)
				AS
					(
					-- Anchor member definition
						SELECT Id OrganizationId
						FROM dbo.Organization
						WHERE Id = @orgId -- parent
					UNION ALL
					-- Recursive member definition
						SELECT e.Id OrganizationId
						FROM dbo.Organization AS e --WITH (INDEX(idx_OrganizationRelationshipId))
						INNER JOIN DirectReports AS d  ON 
						e.ParentOrganizationId	= d.OrganizationId
					)
					INSERT	@OrganizationId ( OrganizationId )
					SELECT OrganizationId FROM DirectReports

	If @UpdatedRoleId IS NOT NULL
		GOTO UpdateRole

		If Exists ( Select 1 From [SECU_Role] where Role_Name = @roleName And OrganizationId in ( Select OrganizationId From @OrganizationId ) )
			Throw 50001, N'Role name for this organization or chiled organization already exist', 1

	If @Propagate = 1
		Begin
				INSERT	[SECU_Role]
					(
						[OrganizationId],
						[Role_Name],
						[Description],
						[Create_Date],
						[Propagate],
						[PropagatedRoleId]
					)
				VALUES
					(
						@orgId,
						@roleName,
						@descr,
						GETUTCDATE(),
						@Propagate,
						0
					)
				SET @roleId = SCOPE_IDENTITY()
				SELECT @roleId AS roleId;

					INSERT	[SECU_Role]
						( [OrganizationId], [Role_Name], [Description], [Create_Date], [Propagate], [PropagatedRoleId] )
					SELECT OrganizationId, @roleName, @descr, GETUTCDATE(), 0, @roleId  FROM @OrganizationId WHERE OrganizationId <> @orgId
				
			End
		Else
			Begin
				INSERT	[SECU_Role]
				(
					[OrganizationId],
					[Role_Name],
					[Description],
					[Create_Date],
					[Propagate],
					[PropagatedRoleId]
				)
				VALUES
				(
					@orgId,
					@roleName,
					@descr,
					GETUTCDATE(),
					@Propagate,
					null
				)

				SET @roleId = SCOPE_IDENTITY()
				SELECT @roleId AS roleId
			End

	If @UpdatedRoleId IS NULL
		Return 0

	UpdateRole:
				Begin
					INSERT	[SECU_Role]
						( [OrganizationId], [Role_Name], [Description], [Create_Date], [Propagate], [PropagatedRoleId] )
					SELECT o.OrganizationId, @roleName, @descr, GETUTCDATE(), 0, @UpdatedRoleId  FROM @OrganizationId o
					LEFT OUTER JOIN dbo.SECU_ROLE s On  s.SECU_Role_ID = @UpdatedRoleId AND o.OrganizationId = s.OrganizationId WHERE s.SECU_Role_ID IS NULL AND s.OrganizationId IS NULL 
				End

END TRY
BEGIN CATCH
	-- Roll back any active or uncommittable transactions before
	If Xact_State() <> 0
		Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
