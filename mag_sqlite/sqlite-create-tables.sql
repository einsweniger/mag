PRAGMA foreign_keys = ON;
-- w/o references/primary keys
-- 161 GiB database
-- real	73m26.921s
-- user	86m6.667s
-- sys	6m47.853s

-- w/ references/primary keys
-- 214 GiB database
-- real	96m44.397s
-- user	102m58.294s
-- sys	9m26.875s
create table Affiliations
(
    AffiliationId  integer PRIMARY KEY,
    Rank           integer,
    NormalizedName text,
    DisplayName    text,
    GridId         text,
    OfficialPage   text,
    WikiPage       text,
    PaperCount     integer,
    CitationCount  integer,
--     Latitude       real,
--     Longitude      real,
    CreatedDate    text
);
create table Authors
(
    AuthorId               integer PRIMARY KEY,
    Rank                   integer,
    NormalizedName         text,
    DisplayName            text,
    LastKnownAffiliationId integer,
    PaperCount             integer,
    CitationCount          integer,
    CreatedDate            text
);

create table Journals
(
    JournalId      integer PRIMARY KEY,
    Rank           integer,
    NormalizedName text,
    DisplayName    text,
    Issn           text,
    Publisher      text,
    Webpage        text,
    PaperCount     integer,
    CitationCount  integer,
    CreatedDate    text
);

create table ConferenceSeries
(
    ConferenceSeriesId integer PRIMARY KEY,
    Rank               integer,
    NormalizedName     text,
    DisplayName        text,
    PaperCount         integer,
    CitationCount      integer,
    CreateDate         text
);

create table FieldsOfStudy
(
    FieldOfStudyId integer PRIMARY KEY,
    Rank           integer,
    NormalizedName text,
    DisplayName    text,
    MainType       text,
    Level          integer,
    PaperCount     integer,
    CitationCount  integer,
    CreatedDate    text
);

create table ConferenceInstances
(
    ConferenceInstanceId     integer PRIMARY KEY,
    NormalizedName           text,
    DisplayName              text,
    ConferenceSeriesId       integer REFERENCES ConferenceSeries (ConferenceSeriesId),
    Location                 text,
    OfficialUrl              text,
    StartDate                text,
    EndDate                  text,
    AbstractRegistrationDate text,
    SubmissionDeadlineDate   text,
    NotificationDueDate      text,
    FinalVersionDueDate      text,
    PaperCount               integer,
    CitationCount            integer,
-- Latitude 	real?,
-- Longitude 	real?,
    CreatedDate              text
);

create table Papers
(
    PaperId              integer PRIMARY KEY,
    Rank                 integer,
    Doi                  text,
    DocType              text,
    PaperTitle           text,
    OriginalTitle        text,
    BookTitle            text,
    Year                 int,
    Date                 text,
    Publisher            text,
    JournalId            integer REFERENCES Journals (JournalId),
    ConferenceSeriesId   integer REFERENCES ConferenceSeries (ConferenceSeriesId),
    ConferenceInstanceId integer REFERENCES ConferenceInstances (ConferenceInstanceId),
    Volume               text,
    Issue                text,
    FirstPage            text,
    LastPage             text,
    ReferenceCount       integer,
    CitationCount        integer,
    EstimatedCitation    integer,
    OriginalVenue        text,
    CreatedDate          text
);

create table PaperReferences
(
    PaperId          integer REFERENCES Papers (PaperId),
    PaperReferenceId integer REFERENCES Papers (PaperId),
    PRIMARY KEY (PaperId, PaperReferenceId)
);

create table PaperAuthorAffiliations
(
    PaperId              integer REFERENCES Papers (PaperId),
    AuthorId             integer REFERENCES Authors (AuthorId),
    AffiliationId        integer REFERENCES Affiliations (AffiliationId),
    AuthorSequenceNumber integer,
    OriginalAuthor       text,
    OriginalAffiliation  text
);

create table PaperUrls
(
    PaperId    integer REFERENCES Papers (PaperId),
    SourceType integer,
    SourceUrl  text,
    PRIMARY KEY(PaperId, SourceUrl)
);

create table PaperResources
(
    PaperId          integer REFERENCES Papers (PaperId),
    ResourceType     integer,
    ResourceUrl      text,
    SourceUrl        text,
    RelationshipType integer
);

