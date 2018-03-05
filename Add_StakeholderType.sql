
CREATE Procedure [dbo].[Add_StakeholderType]
		 @StakeHolderType	NVarchar(50)	
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_StakeholderType
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @StakeholderType
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Insert dbo.StakeHolderType ( StakeHolderType, CreatedOn )
		Select @StakeHolderType, getdate() 
		Select SCOPE_IDENTITY() StakeHolderTypeId 

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
