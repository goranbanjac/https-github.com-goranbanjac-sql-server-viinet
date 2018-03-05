 
CREATE Procedure [dbo].[Get_ProviderAssignmentByPersonString]
				@StrPersonId NVarchar ( 1000 ),
				@OrganizationId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/10/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_OrderCatalogByPersonString
*
*	Description:
*			
*
*	PARAMETERS:
* 
*			@StrPersonId Varchar ( 500 ),
*			@OrganizationId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Select 
				pa.PersonId, 
				pa.PersonAssignmentId, 
				pa.PersonAttribute, 
				pa.RiskLevel, 
				pa.ActivityStatus, 
				pa.Notes,
				pa.ProviderActivity--,
				--pas.ActivityId,			
				--pas.OrderSetId,
				--pas.Section,
				--pas.OutcomeScore
		FROM  dbo.SplitStrings_Native (@StrPersonId, ',') s 
		Inner Join dbo.ProviderAssignment pa On
			s.value = pa.PersonId
		--Left Outer Join dbo.PersonAssignmentScore pas On 
		--	pa.PersonAssignmentId = pas.PersonAssignmentId
		--And pas.PersonAssignmentId > 0


		--From dbo.ProviderAssignment pa
		--Inner Join dbo.SplitStrings_Native (@StrPersonId, ',') s On
		--	pa.PersonId = s.value
		--Left Outer Join dbo.PersonAssignmentScore pas On 
		--	pa.PersonAssignmentId = pas.PersonAssignmentId
		--Where pa.PersonId in (Select Value From dbo.SplitStrings_Native (@StrPersonId, ','))
		--And   pa.PersonAssignmentId > 0

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
