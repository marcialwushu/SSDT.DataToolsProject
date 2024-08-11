--This creates a FULLTEXT INDEX on ProductReview table. The index will cover the column 'Comments' which contains plain text data.

CREATE FULLTEXT INDEX ON Production.ProductReview(Comments) KEY INDEX PK_ProductReview_ProductReviewID;
GO
--This creates a FULLTEXT INDEX on JobCandidate table. The index will cover the column 'Resume' which contains XML data related with the candidates
--resumes.This is a good example of how iFTS will automatically call the XML filter in order to parse the data and store the information into the FTIndex
--created. No data type column is needed in this case as the datatype already provides the needed information

CREATE FULLTEXT INDEX ON HumanResources.JobCandidate(Resume) KEY INDEX PK_JobCandidate_JobCandidateID;
GO
--This creates a FULLTEXT INDEX on Document table. The index will cover the columns 'Document' and ‘DocumentSummary’. Note that the column ‘Document’
--contains binary data on a format specified by the 'FileExtension' column.This is a good example of how iFTS will automatically call the need 
--iFilter associated with the 'FileExtension'associated with each row/document (in this case, all are .doc, which should be loaded into SQL from the OS by default)

CREATE FULLTEXT INDEX ON Production.Document(Document TYPE COLUMN FileExtension, DocumentSummary) KEY INDEX PK_Document_DocumentNode;