/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/



CREATE TABLE EVENTSTORESS (
    SNAPDTE    DM_DATE DEFAULT 'TODAY' NOT NULL /* DM_DATE = DATE */,
    CREDTM     DM_DATETIME DEFAULT 'NOW' NOT NULL /* DM_DATETIME = TIMESTAMP */,
    EVENTNAME  DM_A100 NOT NULL /* DM_A100 = VARCHAR(100) */,
    HEADERS    DM_A10000 /* DM_A10000 = VARCHAR(10000) */,
    PAYLOAD    DM_BLOB /* DM_BLOB = BLOB SUB_TYPE BINARY SEGMENT SIZE 80 */
);



/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/

ALTER TABLE EVENTSTORESS ADD CONSTRAINT PK_EVENTSTORESS_1 PRIMARY KEY (SNAPDTE);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX IDX_EVENTSTORESS_1 ON EVENTSTORESS (CREDTM);


/******************************************************************************/
/****                             Descriptions                             ****/
/******************************************************************************/

COMMENT ON TABLE EVENTSTORESS IS
'Table for storing daily snapshot';



/******************************************************************************/
/****                         Fields descriptions                          ****/
/******************************************************************************/

COMMENT ON COLUMN EVENTSTORESS.CREDTM IS
'Timestamp of when it''s created. Refer to the orinator service';

COMMENT ON COLUMN EVENTSTORESS.EVENTNAME IS
'Name of the task/event triggered';

COMMENT ON COLUMN EVENTSTORESS.PAYLOAD IS
'The actual data being sent.';


