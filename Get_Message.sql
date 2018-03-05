
CREATE Procedure [dbo].[Get_Message]
		 	@OrganizationId Int,
			@MessageName	NVarchar (250)
AS
Set Nocount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 6/16/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_MessageInfo
*
*	Description:		
*
*	PARAMETERS: 
*			 @OrganizationId int	
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int
		
			Select 
				Id, OrganizationId, MessageName, TitleSubject, SenderEmail, SenderTitle, Text, IsActive
			From dbo.[Message] m
			Where m.OrganizationId	= @OrganizationId
			And   m.MessageName		= @MessageName

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0
