Create Procedure Load_CatalogFromXlcs
AS
SET NOCOUNT ON


DECLARE @OrderCatalogExcel TABLE
(
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [OrderSetType] [nvarchar](255) NULL,
	[OrderSetName] [nvarchar](255) NULL,
	[OrderSetNickName] [nvarchar](255) NULL,
	[Order] [nvarchar](1000) NULL,
	[OrderSequenceID] [nvarchar](255) NULL,
	[AnswerOptionGroup] [nvarchar](255) NULL,
	[OptionChoicesName] [nvarchar](255) NULL,
	[Score] [nvarchar](100) NULL ,
	[SortOrder] [nvarchar](10) NULL,
	[AnswerInputTypeName] [nvarchar](255) NULL
)

Declare @files table (ID int IDENTITY, FileName varchar(100), depth int, file1 int)
Declare @Sql Nvarchar(max)
Declare @xlsx Nvarchar(100)
Declare @Id Int = null


	Insert Into @files 
	EXEC Master.dbo.xp_DirTree 'C:/R',1,1

		Select Top 1
				@Id		= Id,
				@xlsx	= FileName	 
		From @files
		
While @Id Is Not Null
	Begin

			Select @Sql = '
			 sp_execute_external_script
			 @language = N''R''
			,@script = N''library("readxl");
						  library("Rcpp");
						  library("cellranger");
						  setwd("C:/R");
						  mytextvariable <- read_excel("' + @xlsx + '", sheet=1, col_names=TRUE);
						  OutputDataSet <- as.data.frame(mytextvariable);''
			,@input_data_1 = N'' ;''
			WITH RESULT SETS ((
								[OrderSetType] [nvarchar](255) NULL,
								[OrderSetName] [nvarchar](255) NULL,
								[OrderSetNickName] [nvarchar](255) NULL,
								[Order] [nvarchar](1000) NULL,
								[OrderSequenceID] [nvarchar](255) NULL,
								[AnswerOptionGroup] [nvarchar](255) NULL,
								[OptionChoicesName] [nvarchar](255) NULL,
								[Score] [nvarchar](100) NULL ,
								[SortOrder] [nvarchar](10) NULL,
								[AnswerInputTypeName] [nvarchar](255) NULL
							));'
			Insert into @OrderCatalogExcel
			exec (@Sql)
			Delete @OrderCatalogExcel Where OrderSetType Is Null
		--======================================================
		-- TO DO 
			Select * From @OrderCatalogExcel;
			Delete  @OrderCatalogExcel;
		--======================================================

		Delete @files Where Id = @Id
		Set @Id = null
		Set @xlsx = null

				Select Top 1
						@Id		= Id,
					    @xlsx	= FileName	 
				From @files
	End