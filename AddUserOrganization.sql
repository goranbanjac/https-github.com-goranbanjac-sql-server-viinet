CREATE PROCEDURE [dbo].[AddUserOrganization]
	@userId	INT,
	@orgId INT,
	@UserTypeId INT
AS
SET NOCOUNT ON
Begin Try

	DECLARE @i	Int

	If Not Exists ( Select 1 From dbo.SECU_Organization_User Where [OrganizationId] = @orgId And [SECU_User_ID] = @userId And UserTypeId = @UserTypeId)
		INSERT	[SECU_Organization_User]
				(
					[OrganizationId],
					[Created_Date],
					[SECU_User_ID],
					[UserTypeId]
				)
		SELECT	@orgId, GETUTCDATE(), @userId, @UserTypeId

End Try
Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
End Catch
RETURN 0
