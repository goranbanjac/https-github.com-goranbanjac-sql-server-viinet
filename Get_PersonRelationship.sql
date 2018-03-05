
CREATE Procedure [dbo].[Get_PersonRelationship]
			@OrganizationId			Int,
			@PersonId				BigInt,
			@RelatedPersonTypeId    Int -- target person type related to @PersonId
AS
Set Nocount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 1/12/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PersonRelationship
*
*	Description:
*			
*	PARAMETERS: 
*			@PersonId	BigInt,
*			@EntityType Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
Declare @i			int
	Begin Try
			
				Select 
						 pr.Id
						,pr.FirstName
						,pr.LastName
						,pr.Gender
						,pr.DateOfBirth
						,pr.MiddleName
						,pr.PersonAttributes
						,pr.PrimaryEmailAddress
						,@RelatedPersonTypeId PersonTypeId
				From Person pr
				Inner Join
					(
					SELECT PersonRelationshipId as PersonId
						FROM dbo.PersonRelationship
						WHERE PersonId = @PersonId
					UNION ALL
					SELECT PersonId 
						FROM dbo.PersonRelationship 
						WHERE PersonRelationshipId = @PersonId
					)x On
					pr.id = x.PersonId
				Inner Join dbo.PersonUser pu On
					x.PersonId = pu.PersonId
				Where pu.OrganizationId = @OrganizationId
				And   pu.PersonTypeId	= @RelatedPersonTypeId

	-- VERSION 2.0
				--with cte as
				--	(
				--	SELECT PersonRelationshipId as PersonId
				--	FROM dbo.PersonRelationship with (index(idx_PersonRelationship_PersonId))
				--	WHERE PersonId = @PersonId
				--	UNION ALL
				--	SELECT PersonId 
				--	FROM dbo.PersonRelationship 
				--	WHERE PersonRelationshipId = @PersonId
				--	),
				--cte1 as
				--	(
				--		Select c.PersonId from cte c
				--		Where exists ( Select PersonId From dbo.PersonUser where PersonId = c.PersonId 
				--		And OrganizationId  = @OrganizationId 
				--		And PersonTypeId	= @RelatedPersonTypeId)
				--	)

				--Select 
				--		 pr.Id
				--		,pr.FirstName
				--		,pr.LastName
				--		,pr.Gender
				--		,pr.DateOfBirth
				--		,pr.MiddleName
				--		,pr.PersonAttributes
				--		,pr.PrimaryEmailAddress
				--From Person pr
				--Where exists ( Select PersonId from cte1 where PersonId = pr.Id )
			
	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0
exec [Get_PersonRelationship]
           @OrganizationId            = 1,
           @PersonId               = 36,
           @RelatedPersonTypeId   = 1
