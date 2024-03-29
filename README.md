er# TableQueue

TableQueue (TQ for short) is a simple table based queue module. It's ment to be used where full blown messagingsystems are simply overkill.

```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```
## Sequence flows

### Actors

* Sender, app sending a message
* Receiver, app(s) receiving a message
* TQ, Table Queue internal routine. Can be stored procedure, trigger or additional external application running

### Adding message to bus

```mermaid
  sequenceDiagram;
    Sender->>TQ: Send a message to the bus;
    TQ-->>Sender: Message received with messageid x;
    Sender-)John: See you later;
```
 
### Fetching message from bus

```mermaid
  sequenceDiagram;
    Alice->>John: Hello John, how are you;
    John-->>Alice: Great;
    Alice-)John: See you later;
```
 
## Tables with triggers

* TABLEQUEUE main table that receives messages
* ** MSGDESTINATION is the destination of the data. A value of * gets handled by router stored procedure
* TABLEQUEUEROUTING contains routing for all MSGORIGIN = * then get replicated to respective additional specific MSGORIGIN.
* TABLEQUEUEHISTORY is a history table containing X days old messages
* TABLEQUEUECONFIG is a table containing configuration
  
## Stored Procedures

* spTableQueueRouting
