
/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/


CREATE GENERATOR GEN_EVENTSTORE_ID;

CREATE TABLE EVENTSTORE (
    EVENTSTOREID   DM_ID NOT NULL /* DM_ID = BIGINT */,
    CORRELATIONID  DM_GUID NOT NULL /* DM_GUID = VARCHAR(100) */,
    CREDTM         DM_DATETIME /* DM_DATETIME = TIMESTAMP */,
    CREBYAPP       DM_A100 /* DM_A100 = VARCHAR(100) */,
    HEADERS        DM_A10000 /* DM_A10000 = VARCHAR(10000) */,
    PAYLOAD        DM_BLOB /* DM_BLOB = BLOB SUB_TYPE BINARY SEGMENT SIZE 80 */,
    EVENTNAME      DM_A100 NOT NULL /* DM_A100 = VARCHAR(100) */
);



/******************************************************************************/
/****                          Unique constraints                          ****/
/******************************************************************************/

ALTER TABLE EVENTSTORE ADD CONSTRAINT UNQ1_EVENTSTORE UNIQUE (CORRELATIONID);


/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/

ALTER TABLE EVENTSTORE ADD CONSTRAINT PK_EVENTSTORE PRIMARY KEY (EVENTSTOREID);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX EVENTSTORE_IDX1 ON EVENTSTORE (CREDTM);


/******************************************************************************/
/****                               Triggers                               ****/
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/****                         Triggers for tables                          ****/
/******************************************************************************/



/* Trigger: EVENTSTORE_AI0 */
CREATE OR ALTER TRIGGER EVENTSTORE_AI0 FOR EVENTSTORE
ACTIVE AFTER INSERT POSITION 0
AS
begin
  /* Trigger event for subscribers. They cleanup after they have processed. */
  /* Note that creator app subscribe themself to what they produce since they
  might want to have the event in other part of the service */
  insert into eventstore_template select * from eventstore where eventstore.eventstoreid = new.eventstoreid;
  insert into eventstore_guardian select * from eventstore where eventstore.eventstoreid = new.eventstoreid;
  insert into eventstore_snapshot select * from eventstore where eventstore.eventstoreid = new.eventstoreid;
end
^

/* Trigger: EVENTSTORE_BI */
CREATE OR ALTER TRIGGER EVENTSTORE_BI FOR EVENTSTORE
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.eventstoreid is null) then
    new.eventstoreid = gen_id(gen_eventstore_id,1);
end
^
SET TERM ; ^



/******************************************************************************/
/****                         Fields descriptions                          ****/
/******************************************************************************/

COMMENT ON COLUMN EVENTSTORE.CORRELATIONID IS
'Created by the generating app';

COMMENT ON COLUMN EVENTSTORE.CREDTM IS
'Timestamp of when it''s created. Refer to the orinator service';

COMMENT ON COLUMN EVENTSTORE.CREBYAPP IS
'Originating app/service';

COMMENT ON COLUMN EVENTSTORE.PAYLOAD IS
'The actual data being sent.';

COMMENT ON COLUMN EVENTSTORE.EVENTNAME IS
'Name of the task/event triggered';



/******************************************************************************/
/****                              Privileges                              ****/
/******************************************************************************/
