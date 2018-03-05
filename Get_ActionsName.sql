 
CREATE Procedure [dbo].[Get_ActionsName]
		 @BitMaskId	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_ActionsName
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
		Declare @Table Table ( BitMaskId tinyint, ActionName varchar(150) )

		If @BitMaskId & 1 = 1 -- Respond to Patient
				Insert @Table ( BitMaskId, ActionName )
				Select 1, ActionName From [dbo].[Actions] where  BitMaskId = 1
		If @BitMaskId & 2 = 2 -- Update all Stakeholder(s) w/ Message
				Insert @Table ( BitMaskId, ActionName )
				Select 2, ActionName From [dbo].[Actions] where BitMaskId = 2
		If @BitMaskId & 4 = 4 -- Update Selected Stakeholder(s) w/ Message
				Insert @Table ( BitMaskId, ActionName )
				Select 4, ActionName From [dbo].[Actions] where BitMaskId = 4
		If @BitMaskId & 8 = 8 -- Escalate to Stakeholder
				Insert @Table ( BitMaskId, ActionName )
				Select 8, ActionName From [dbo].[Actions] where BitMaskId = 8
		If @BitMaskId & 16 = 16 -- Setup Live Video Visit  
				Insert @Table ( BitMaskId, ActionName )
				Select 16, ActionName From [dbo].[Actions] where BitMaskId = 16
		If @BitMaskId & 32 = 32 -- Conduct ROM Review
				Insert @Table ( BitMaskId, ActionName )
				Select 32, ActionName From [dbo].[Actions] where BitMaskId = 32
		If @BitMaskId & 64 = 64 -- Do Nothing and Leave Track Item In Task List
				Insert @Table ( BitMaskId, ActionName )
				Select 64, ActionName From [dbo].[Actions] where BitMaskId = 64
		If @BitMaskId & 128 = 128 -- Send To EMR  
				Insert @Table ( BitMaskId, ActionName )
				Select 128, ActionName From [dbo].[Actions] where BitMaskId = 128

				Select * from @Table
	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

