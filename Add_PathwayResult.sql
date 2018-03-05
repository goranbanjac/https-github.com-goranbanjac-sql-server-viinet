CREATE Procedure [dbo].[Add_PathwayResult]
		  @Organizationid Int,
		  @PersonId BigInt,
		  @Gender NVarchar(5),
		  @DOB DateTime,
		  @PathwayId int , 
		  @PathwayName NVarchar(255), 
		  @ActivityId int , 
		  @ActivityName NVarchar(255) ,
		  @OrderSetId Int , 
		  @OrderSetName NVarchar(255) , 
		  @OrderId int , 
		  @OrderName NVarchar(255) , 
		  @AnswerOptionGroupId Int , 
		  @AnswerVersionGroup NVarchar(100) , 
		  @VersionChoicesName NVarchar(250) , 
		  @Score Int = null,
		  @PathwaySpecialty NVarchar(50) 
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/30/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PathwayResult
*
*	Description:
*			
*
*	PARAMETERS: 
*
*			  @Organizationid Int,
*			  @PersonId BigInt,
*			  @Gender NVarchar(5),
*			  @DOB DateTime,
*			  @PathwayId int , 
*			  @PathwayName NVarchar(255), 
*			  @ActivityId int , 
*			  @ActivityName NVarchar(255) ,
*			  @OrderSetId Int , 
*			  @OrderSetName NVarchar(255) , 
*			  @OrderId int , 
*			  @OrderName NVarchar(255) , 
*			  @AnswerOptionGroupId Int , 
*			  @AnswerVersionGroup NVarchar(100) , 
*			  @VersionChoicesName NVarchar(250) , 
*			  @Score Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i					Int,
				@PersonAssignmentId  Int

			Insert dbo.PathwayResult
				   (
					 Organizationid,
					 PersonId ,
					 Gender ,
					 DOB ,
					 PathwayId, 
					 PathwayName, 
					 ActivityId, 
					 ActivityName,
					 OrderSetId,
					 OrderSetName,
					 OrderId,
					 OrderName,
					 AnswerOptionGroupId,
					 AnswerVersionGroup,
					 VersionChoicesName,
					 Score,
					 PathwaySpecialty
				   )
			Values (
					  @Organizationid ,
					  @PersonId ,
					  @Gender ,
					  @DOB ,
					  @PathwayId  , 
					  @PathwayName , 
					  @ActivityId  , 
					  @ActivityName  ,
					  @OrderSetId  , 
					  @OrderSetName  , 
					  @OrderId  , 
					  @OrderName  , 
					  @AnswerOptionGroupId  , 
					  @AnswerVersionGroup  , 
					  @VersionChoicesName  , 
					  @Score ,
					  @PathwaySpecialty
				  )

	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		If Xact_State() <> 0
			Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
