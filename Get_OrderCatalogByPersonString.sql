 
CREATE Procedure [dbo].[Get_OrderCatalogByPersonString]
				@StrPersonId NVarchar ( 500 ),
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
*			@StrPersonId NVarchar ( 500 ),
*			@OrganizationId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int
			Return 0
		Select 
				pa.Id, 
				OrganizationId, 
				PathwayId, 
				PersonId, 
				EncounterId, 
				IsCompleted, 
				AssignmentAttributes, 
				Activities, 
				AnswerGroups, 
				Results, 
				Pathways, 
				Progress,
				ActivityId,			
				OrderSetId,
				Section,
				OutcomeScore
		From dbo.PersonAssignment pa
		Left Outer Join dbo.PersonAssignmentScore pas with(index(idx_PersonAssignmentScore_PersonAssignmentId)) On
			pa.Id = pas.PersonAssignmentId
		Where OrganizationId = @OrganizationId 
		And PersonId in (Select Value From dbo.SplitStrings_Native (@StrPersonId, ','))

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
