
CREATE Procedure [dbo].[Delete_StakeHolderToGroup]
		@Id Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_StakeHolderGroup
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		@OrganizationId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Delete dbo.StakeHolderToGroup where Id = @Id

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
