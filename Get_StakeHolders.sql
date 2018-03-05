 
CREATE Procedure [dbo].[Get_StakeHolders]
		 @OrganizationId		Int
		,@StakeHolderTypeMask	Tinyint
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_StakeHolders
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int
		Declare @Table Table ( BitMaskId tinyint, PersonId int )

		If @StakeHolderTypeMask & 1 = 1 -- PATIENT AND PARTNER IN CARE
				Insert @Table ( BitMaskId, PersonId )
				Select 1, PersonId From [dbo].[StakeHolders] where OrganizationId = @OrganizationId And BitMaskId = 1
		If @StakeHolderTypeMask & 2 = 2 -- SURGICAL CARE TEAM
				Insert @Table ( BitMaskId, PersonId )
				Select 2, PersonId From [dbo].[StakeHolders] where OrganizationId = @OrganizationId And BitMaskId = 2
		If @StakeHolderTypeMask & 4 = 4 -- SURGEON TEAM
				Insert @Table ( BitMaskId, PersonId )
				Select 4, PersonId From [dbo].[StakeHolders] where OrganizationId = @OrganizationId And BitMaskId = 4
		If @StakeHolderTypeMask & 8 = 8 -- MEDICAL RECORD (EMR)
				Insert @Table ( BitMaskId, PersonId )
				Select 8, PersonId From [dbo].[StakeHolders] where OrganizationId = @OrganizationId And BitMaskId = 8
		If @StakeHolderTypeMask & 16 = 16 -- MEDICAL EQUIPMENT  
				Insert @Table ( BitMaskId, PersonId )
				Select 16, PersonId From [dbo].[StakeHolders] where OrganizationId = @OrganizationId And BitMaskId = 16

				Select * from @Table
	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

