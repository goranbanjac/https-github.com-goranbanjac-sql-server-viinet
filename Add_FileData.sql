
CREATE Procedure [dbo].[Add_FileData]
			 @Id				Int = null
			,@FileName			Nvarchar( 1000 ) 
			,@Location			NVarchar( 1000 )
			,@MimeType			NVarchar( 1000 )
			,@Details			NVarchar( 1000 )
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 02/08/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_OrderVerzionTracks
*
*	Description:
*			
*
*	PARAMETERS: 
*
* [dbo].[Add_OrderVersionG]
*			 @OrderVersionId		Int
*			,@ConditionOrderIds		Nvarchar( 1000 ) 
*			,@Expression			NVarchar( 1000 )
*			,@TrackItem				NVarchar( 4000 )
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i					Int,
				@LocationCheckSum	Int

			Select @LocationCheckSum = CheckSum (@Location)
				If Exists ( Select 1 From dbo.FileData where LocationCheckSum = @LocationCheckSum And Id <> IsNull(@Id,0))
					Throw 50001, N'This Location already exist', 1
			
			Merge dbo.FileData q
			Using	(	select	 @Id, @FileName, @Location, @MimeType, @Details, @LocationCheckSum ) s 
					(	Id, [FileName], [Location], MimeType, Details, LocationCheckSum)  on 
						q.Id = s.Id
			When Matched 
				Then Update Set 	
								q.[FileName]	= s.[FileName],
								q.[Location]	= s.[Location],
								q.MimeType		= s.MimeType,
								q.Details		= s.Details,
								q.EditedOn		= getdate()
			When Not Matched 
				Then Insert ( [FileName], [Location], MimeType, Details, LocationCheckSum)
					Values ( s.[FileName], s.[Location], s.MimeType, s.Details, s.LocationCheckSum);

					Select IsNull(@Id,SCOPE_IDENTITY())  FileDataId

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch