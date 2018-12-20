--ddl
create table inventory_change_event
(
	id varchar(255) not null
		constraint inventory_change_event_pkey
			primary key,
	timestamp timestamp(0) not null,
	original_event json not null,
	product json,
	old_percentage double precision,
	new_percentage double precision,
	old_stream_percentage double precision,
	new_stream_percentage double precision,
	item_count integer
);

comment on column inventory_change_event.original_event is '(DC2Type:json_document)';

comment on column inventory_change_event.product is '(DC2Type:json_document)';

alter table inventory_change_event owner to "api-platform";

-- row of data:
'A419BA74_20181121_173137:003887',
2018-11-21 17:31:37,
"{""#type"":""App\\Model\\SensorEvent"",""id"":""A419BA74_20181121_173137:003887"",""sensorId"":""A419BA74"",""payload"":{""#type"":""App\\Model\\SensorPayload"",""batteryMV"":3730,""distanceMm"":208},""locationId"":""shelf1""}",
,,,,,


--query
select
       product->>'id' as product_id,
       cast(original_event->>'payload'->>'distanceMm' as integer) as meas
from inventory_change_event;

--error message
--[42883] ERROR: operator does not exist: text ->> unknown Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts. Position: 83

-- working query
select
       product->>'id' as product_id,
       cast(original_event->'payload'->>'distanceMm' as integer) as meas
from inventory_change_event;