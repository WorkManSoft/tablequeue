# TableQueue

TableQueue (TQ for short) is a simple table based queue module. It's ment to be used where full blown messagingsystems are simply overkill.

```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```
 
## Tables with triggers

* TABLEQUEUE main table that receives messages
* ** MSGDESTINATION is the destination of the data. A value of * gets handled by router stored procedure
* TABLEQUEUEROUTING contains routing for all MSGORIGIN = * then get replicated to respective additional specific MSGORIGIN.
* TABLEQUEUEHISTORY is a history table containing X days old messages
  
## Stored Procedures

* spTableQueueRouting
