
CREATE Procedure [dbo].[Get_OrderCatalogSearch]
			@OrganizationId			Int,
			@OrderTypeId			Int,
			@StrOrderCategoryId		NVarchar (150) = '',
			@OrderDescription		NVarchar (100) = '',
			@OrderNickname 			NVarchar (100) = '',
			@IsReusable				Tinyint = null
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 6/28/2010
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_Question
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

		SELECT 
			oca.Id OrderVersionId, 
			oca.OrganizationId, 
			oc.Id OrderId,
			oc.[Order],
			oc.OrderTypeId,
			oc.IsReusable,
			oca.OrderDescription,
			oc.OrderCategoryId,
			oca.OrderNickname,
			oc.AnswerInputTypeId,
			oc.AnswerVersionGroupId,
			oca.OrderConfiguration, 
			oca.OrderVersionAttribute
		From dbo.OrderCatalog oc --with(index(idx_OrderCatalog_OrderCategoryId))
		Inner Join dbo.OrderOrganization oca On
			oc.Id = oca.OrderId
		WHERE oc.Id > 0
		AND   oca.OrganizationId = @OrganizationId
		AND   oca.OrderTypeId = @OrderTypeId
		AND ( @StrOrderCategoryId	= '' Or oc.OrderCategoryId in ( Select value from dbo.SplitStrings_Native (@StrOrderCategoryId,',')))
		AND ( @OrderDescription		= '' Or oca.OrderDescription like @OrderDescription + '%' )
		AND ( @OrderNickname		= '' Or oca.OrderNickname like @OrderNickname + '%'  )
		AND ( @IsReusable Is Null		 Or IsReusable = @IsReusable )

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
