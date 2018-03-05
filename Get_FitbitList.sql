 
Create Procedure [dbo].[Get_FitbitList]
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 1/16/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_FitbitList
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

			Select
				 oo.id OrderVerzionId, oc.[Order], oc.OrderTypeId
			From OrderOrganization oo
			Inner Join dbo.OrderCatalog oc On
				oo.OrderId = oc.Id
			Where OrganizationId = 1
			And   oo.OrderTypeId in ( 2,4 )
			And OrderCategoryId = 9

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

