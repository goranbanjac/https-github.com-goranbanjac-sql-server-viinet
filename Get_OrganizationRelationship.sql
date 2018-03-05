
CREATE Procedure [dbo].[Get_OrganizationRelationship]
			@QOIdP			int = null,
			@QOIdC			int = null,
			@Level			int = null
AS
Set Nocount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/24/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_CatalogRelationship
*
*	Description:
*			
*	PARAMETERS: 
*			@OrganizationId int ,
*			@QOIdP			int = null,
*			@QOIdC			int  = null
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
Declare @i int
	Begin Try

			WITH DirectReports (OrganizationId,OrganizationName,OrganizationTypeId, Address1,Address2,City,State,ZipCode,OfficePhone,OfficeEmail,OwnedOrAffiliated,ParentOrganizationId,Level)
			AS
				(
				-- Anchor member definition
					SELECT Id OrganizationId,OrganizationName,OrganizationTypeId,Address1,Address2,City,State,ZipCode,OfficePhone,OfficeEmail,OwnedOrAffiliated,ParentOrganizationId, 0 AS Level
					FROM dbo.Organization
					WHERE Id = IsNull(@QOIdP,@QOIdC)
				UNION ALL
				-- Recursive member definition
					SELECT e.Id OrganizationId,e.OrganizationName,e.OrganizationTypeId,e.Address1,e.Address2,e.City,e.State,e.ZipCode,e.OfficePhone,e.OfficeEmail,e.OwnedOrAffiliated,e.ParentOrganizationId,Level + 1
					FROM dbo.Organization AS e --WITH (INDEX(idx_OrganizationRelationshipId))
					INNER JOIN DirectReports AS d  ON 
					Case
							When @QOIdP Is Null And e.Id					= d.ParentOrganizationId Then 1
							When @QOIdC Is Null And e.ParentOrganizationId	= d.OrganizationId Then 1
						Else 0
					END = 1
				)

				SELECT * FROM DirectReports d 
				WHERE d.OrganizationId <> IsNull(@QOIdP,@QOIdC)
				AND (@Level Is Null Or Level = @Level)
	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0


