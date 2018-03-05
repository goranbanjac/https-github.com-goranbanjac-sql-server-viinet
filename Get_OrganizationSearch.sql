
CREATE Procedure [dbo].[Get_OrganizationSearch]
		 @OrganizationName		NVarchar(50) = ''
		,@OrganizationTypeId	Int = Null
		,@ParentOrganizationId	Int = Null
AS
DECLARE	@i Int

	Begin Try
				Select 
					 o.Id OrganizationId
					,OrganizationTypeId
					,OrganizationName
					,Address1
					,Address2
					,City
					,State
					,ZipCode
					,OfficePhone
					,OfficeEmail
				--	,os.Specialties
				--	,s.Role_Name
					,OwnedOrAffiliated
					,ParentOrganizationId
				From dbo.Organization o
				--Left Outer Join dbo.OrganizationSpecialties os With(Index(idx_OrganizationSpecialties_OrganizationId)) On o.Id = os.OrganizationId
				--Left Outer Join dbo.SECU_Role s With(Index(idx_SECU_Role_OrganizationId)) On o.Id = s.OrganizationId
				Where o.Id > 0
				And	  ( @OrganizationTypeId Is Null Or OrganizationTypeId = @OrganizationTypeId )
				And   ( @OrganizationName = '' Or OrganizationName like @OrganizationName + '%')
				And	  ( @ParentOrganizationId is Null Or ParentOrganizationId = @ParentOrganizationId)

	End Try 
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0
