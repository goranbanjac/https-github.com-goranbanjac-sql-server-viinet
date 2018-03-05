
CREATE Procedure [dbo].[Add_StakeHolderToGroup]
		 @OrganizationId		Int
		,@StrPersonId			NVarchar (1000)	
		,@StakeHolderGroupId	Int	
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/7/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_StakeHolderToGroup
*
*	Description:
*	
*		,@OrganizationId	Int
*		,@PersonId			Bigint	
*		,@StakeHolderTypeId	Int	
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

			Insert dbo.StakeholderToGroup
				( OrganizationId, PersonId, StakeHolderGroupId )
			Select @OrganizationId, s.value, @StakeHolderGroupId 
			From [dbo].[SplitStrings_Native] (@StrPersonId, ',') s
			Left Outer Join dbo.StakeholderToGroup sg On
				s.value = sg.PersonId
			And @OrganizationId = sg.OrganizationId
			And @StakeHolderGroupId = sg.StakeHolderGroupId
			Where sg.PersonId			Is Null
			And   sg.OrganizationId		Is Null
			And   sg.StakeHolderGroupId Is NUll

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
