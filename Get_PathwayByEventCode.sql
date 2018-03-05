 
CREATE Procedure [dbo].[Get_PathwayByEventCode]
				@EventCodeId Int,
				@OrganizationId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/26/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PathwayByEventCode
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*		@EventCode varchar(50)
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int;

		With cte as 
			(
				Select PathwayId From dbo.PathwayToEventCode p
				Inner Join dbo.EventCode ec On
					p.EventCode = ec.EventCode
				Where ec.Id = @EventCodeId
			)

			Select  oc.Id,OrderId,oca.OrganizationId,[Order], oc.OrderTypeId,IsReusable,OrderDescription,OrderCategoryId,OrderNickname,AnswerInputTypeId,
			   AnswerVersionGroupId,OrderConfiguration, oca.Id OrderVersionId, oca.OrderVersionAttribute,OrderConfiguration
			From dbo.OrderCatalog oc
			Inner Join dbo.OrderOrganization oca On
				oc.Id = oca.OrderId
			And oca.OrganizationId = @OrganizationId
			Inner Join cte On
				oca.Id = cte.PathwayId
			--Where Exists ( Select 1 From cte where cte.PathwayId = oc.Id  )

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
