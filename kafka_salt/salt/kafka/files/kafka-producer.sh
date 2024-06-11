#!/bin/bash

# Example Kafka producer script
# Adjust topic and other parameters as needed

echo "This is a test message" | /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic test
