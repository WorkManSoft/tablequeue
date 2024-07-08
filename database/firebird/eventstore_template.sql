/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/



CREATE TABLE EVENTSTORE_TEMPLATE (
    EVENTSTOREID   DM_ID NOT NULL /* DM_ID = BIGINT */,
    CORRELATIONID  DM_GUID NOT NULL /* DM_GUID = VARCHAR(100) */,
    CREDTM         DM_DATETIME /* DM_DATETIME = TIMESTAMP */,
    CREBYAPP       DM_A100 /* DM_A100 = VARCHAR(100) */,
    HEADERS        DM_A10000 /* DM_A10000 = VARCHAR(10000) */,
    PAYLOAD        DM_BLOB /* DM_BLOB = BLOB SUB_TYPE BINARY SEGMENT SIZE 80 */,
    EVENTNAME      DM_A100 NOT NULL /* DM_A100 = VARCHAR(100) */
);



/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/

ALTER TABLE EVENTSTORE_TEMPLATE ADD CONSTRAINT PK_EVENTSTORE_TEMPLATE_1 PRIMARY KEY (EVENTSTOREID);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX IDX_EVENTSTORE_TEMPLATE_1 ON EVENTSTORE_TEMPLATE (CREDTM);


/******************************************************************************/
/****                         Fields descriptions                          ****/
/******************************************************************************/

COMMENT ON COLUMN EVENTSTORE_TEMPLATE.CORRELATIONID IS
'Created by the generating app';

COMMENT ON COLUMN EVENTSTORE_TEMPLATE.CREDTM IS
'Timestamp of when it''s created. Refer to the orinator service';

COMMENT ON COLUMN EVENTSTORE_TEMPLATE.CREBYAPP IS
'Originating app/service';

COMMENT ON COLUMN EVENTSTORE_TEMPLATE.PAYLOAD IS
'The actual data being sent.';

COMMENT ON COLUMN EVENTSTORE_TEMPLATE.EVENTNAME IS
'Name of the task/event triggered';



/******************************************************************************/
/****                              Privileges                              ****/
/******************************************************************************/
