---
title: "Incremental ETL for bronze to silver layer processes"
publish: false
date: "2024-10-04T13:11:44"
tags:
  - "Databricks"
---

# TODO
- Create a proof of concept with a bronze table

```python

# Define paths and table names
source_table = "<source_delta_table>"
target_table = "<target_delta_table>"
checkpoint_path = "/path/to/checkpoint"

# Step 1: Read data from the source Delta table incrementally
source_df = (spark.readStream
    .format("delta")
    .table(source_table)  # Reading from the Delta source
)

# Step 2: Apply any transformations (optional)
# Example: add a timestamp and file path metadata
from pyspark.sql.functions import current_timestamp

transformed_df = (source_df
    .withColumn("processing_time", current_timestamp())
)

# Step 3: Write the transformed data to the target Delta table incrementally
(transformed_df.writeStream
    .format("delta")  # Write to Delta
    .trigger(availableNow=True)  # Optional trigger for batch processing
    .option("checkpointLocation", checkpoint_path)  # Ensure unique checkpoint per stream
    .toTable(target_table)  # Writing to Delta sink
)
```

## Proof of Concept

```python

# Set the path to your Delta tables (source and target)
source_path = "/tmp/synthetic_source_delta"
target_path = "/tmp/synthetic_target_delta"

# Create a synthetic Delta table with some sample data
from pyspark.sql.types import StructType, StructField, IntegerType, StringType

# Define schema for the synthetic data
schema = StructType([
    StructField("id", IntegerType(), True),
    StructField("name", StringType(), True)
])

# Generate sample data and write to Delta
data = [(1, "Alice"), (2, "Bob"), (3, "Charlie")]
df = spark.createDataFrame(data, schema)

# Save the initial batch as Delta format
df.write.format("delta").mode("overwrite").save(source_path)

# Create a Delta table from the saved data
spark.sql(f"CREATE TABLE IF NOT EXISTS synthetic_source_delta USING DELTA LOCATION '{source_path}'")
```

```python

# Simulate inserting new data in batches into the Delta table
new_data = [(4, "David"), (5, "Eve")]
new_df = spark.createDataFrame(new_data, schema)

# Append new data to the source Delta table
new_df.write.format("delta").mode("append").save(source_path)
```

```python

# Define checkpoint path to track the stream state
checkpoint_path = "/tmp/streaming_checkpoint"

# Read from the source Delta table incrementally
source_stream_df = (spark.readStream
    .format("delta")
    .load(source_path)
)

# Apply a simple transformation (e.g., adding a timestamp column)
from pyspark.sql.functions import current_timestamp

transformed_stream_df = (source_stream_df
    .withColumn("processing_time", current_timestamp())
)

# Write the transformed data incrementally to the target Delta table
query = (transformed_stream_df.writeStream
    .format("delta")
    .outputMode("append")  # Append new records to the target Delta table
    .option("checkpointLocation", checkpoint_path)
    .start(target_path)
)
```
