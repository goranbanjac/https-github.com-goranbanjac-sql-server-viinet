
CREATE Procedure [dbo].[Copy_Pathway]
				@OrganizationId		Int,
				@PathwayVersionId	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Copy_Pathway
*
*	Description:
*			
*
*	PARAMETERS: 
*			@OrganizationId		Int,
*			@PathwayVerzionId	Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i			Int,
				@DateTime	DateTime

		Select @DateTime = GetDate()

		Declare @P Table (  NewPathwayVersionId Int, NewActivityVersionId Int, NewOrderSetVersionId Int, NewOrderVersionId Int )

		Declare @T Table (
						OrganizationId int NOT NULL,
						OrderVersionId int NOT NULL,
						OrderTypeId int NULL,
						OrderId int NOT NULL,
						[Order] nvarchar ( 1000 ) NOT NULL,
						IsReusable	tinyint NOT NULL,
						OrderDescription nvarchar( 1000 ) NULL,
						OrderCategoryId tinyint ,
						OrderNickname nvarchar( 1000 ) NULL,
						AnswerInputTypeId tinyint ,
						AnswerVersionGroupId int,
						OrderConfiguration nvarchar(max) NULL,
						OrderVersionAttribute nvarchar(max) NULL,
						SortOrder			  int NULL
					)

	-- Generate pathway body 
			Insert @t 
			(
			OrganizationId,OrderVersionId,OrderTypeId,OrderId,[Order],IsReusable,OrderDescription,OrderCategoryId,OrderNickname,AnswerInputTypeId,AnswerVersionGroupId,OrderConfiguration,OrderVersionAttribute,SortOrder
			)
			Exec [dbo].[Get_SetByVersionAndTypeId] @PathwayVersionId, 1  

	-- Create new instance of pathway body 
			Insert dbo.OrderOrganization 
						( OrganizationId, OrderId, OrderVersionAttribute, OrderTypeId, OrderDescription, OrderNickname, OrderConfiguration , CreatedOn )
			Select
				@OrganizationId, OrderId, OrderVersionAttribute, OrderTypeId, OrderDescription, OrderNickname, OrderConfiguration , @DateTime
			From @t

	-- Take newly created instance of whole pathway using timestump
			Declare @S Table ( Id int, OrderId int )

			Insert @S ( Id, OrderId )
			Select Id, OrderId from dbo.OrderOrganization where CreatedOn = @DateTime;

	-- Build copied pathway relatioship as template to put new instances into relatioship
			with cte as
			(
			select p.PathwayId PathwayVersionId,a.ActivitySetId ActivitySetVersionId,os.OrderSetId OrderSetVerzionId,os.OrderId OrderVerzionId,o1.OrderId PathwayOrderId,o2.OrderId ActivityOrderId, o3.OrderId OrderSetOrderId, o4.OrderId
			from dbo.PathwaySet p
			inner join dbo.ActivitySet a On
				p.ActivityId = a.ActivitySetId
			inner join OrderSet os On
				a.OrderSetId = os.OrderSetId
			inner join dbo.OrderOrganization o1 On
				p.PathwayId = o1.Id
			inner join dbo.OrderOrganization o2 On
				a.ActivitySetId = o2.Id
			inner join dbo.OrderOrganization o3 On
				os.OrderSetId = o3.Id
			inner join dbo.OrderOrganization o4 On
				os.OrderId = o4.Id
			Where p.PathwayId = @PathwayVersionId
			)

	-- Build new instance relationship template
			Insert @P (  NewPathwayVersionId, NewActivityVersionId, NewOrderSetVersionId, NewOrderVersionId )
			select o1.Id NewPathwayVersionId, o2.Id NewActivityVersionId, o3.Id NewOrderSetVersionId, o4.Id NewOrderVersionId--, cte.PathwayOrderId, cte.ActivityOrderId, cte.OrderSetOrderId, cte.OrderId
			from @S o1
			Inner Join cte cte On
				o1.OrderId = cte.PathwayOrderId
			Inner Join @S o2 On
				o2.OrderId = cte.ActivityOrderId
			Inner Join @S o3 On
				o3.OrderId = cte.OrderSetOrderId
			Inner Join @S o4 On
				o4.OrderId = cte.OrderId
	
	-- Add new instances relationships 	
			insert dbo.PathwaySet ( PathwayId, ActivityId )
			select distinct NewPathwayVersionId, NewActivityVersionId from @P

			insert dbo.ActivitySet( ActivitySetId, OrderSetId )
			select distinct NewActivityVersionId, NewOrderSetVersionId from @P

			Insert OrderSet ( OrderSetId, OrderId )
			select distinct NewOrderSetVersionId, NewOrderVersionId from @P

			Select Distinct NewPathwayVersionId from @P

			--select p.PathwayId PathwayVersionId,a.ActivitySetId ActivitySetVersionId,os.OrderSetId OrderSetVerzionId,os.OrderId OrderVerzionId,o1.OrderId PathwayOrderId,o2.OrderId ActivityOrderId, o3.OrderId OrderSetOrderId, o4.OrderId
			--from dbo.PathwaySet p
			--inner join dbo.ActivitySet a On
			--	p.ActivityId = a.ActivitySetId
			--inner join OrderSet os On
			--	a.OrderSetId = os.OrderSetId
			--inner join dbo.OrderOrganization o1 On
			--	p.PathwayId = o1.Id
			--inner join dbo.OrderOrganization o2 On
			--	a.ActivitySetId = o2.Id
			--inner join dbo.OrderOrganization o3 On
			--	os.OrderSetId = o3.Id
			--inner join dbo.OrderOrganization o4 On
			--	os.OrderId = o4.Id
			--Where p.PathwayId = @PathwayVerzionId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch	
	

	
