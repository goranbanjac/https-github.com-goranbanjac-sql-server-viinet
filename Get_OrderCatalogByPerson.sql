 
CREATE Procedure [dbo].[Get_OrderCatalogByPerson]
				@PersonId Int,
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
*	File Name:	Get_OrderCatalogByPerson
*
*	Description:
*			
*
*	PARAMETERS:
* 
*			@PersonId Int,
*			@OrganizationId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

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
			VideoFileName,
			ActivityId,			
			OrderSetId,
			Section,
			OutcomeScore
		From dbo.PersonAssignment pa
		Left Outer Join dbo.PersonAssignmentScore pas On --with(index(idx_PersonAssignmentScore_PersonAssignmentId)) On
			pa.Id = pas.PersonAssignmentId
		Left Outer Join dbo.PersonAssignmentVideo pv On
			pa.Id = pv.PersonAssignmentId
		And pv.PersonAssignmentId > 0
		Where OrganizationId = @OrganizationId And PersonId = @PersonId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
