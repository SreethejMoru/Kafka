#!/bin/bash

# Example Kafka consumer script
# Adjust topic and other parameters as needed

/usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic test --from-beginning
