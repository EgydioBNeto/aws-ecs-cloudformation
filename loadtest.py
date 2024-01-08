#!/bin/python3

import requests
import threading
import time

# URL of the endpoint to be tested
url = "https://egydio.domain.cloud"

# Number of threads (simultaneous requests) for the load test
num_threads = 20

# Total number of requests to be made
num_requests = 200

# List to store the results of the requests
results = []

# Function that makes a request to the endpoint
def make_request():
    try:
        response = requests.get(url)
        results.append(response.status_code)
        print(f"Request successful. Status Code: {response.status_code}")
    except Exception as e:
        results.append(str(e))
        print(f"Request failed. Exception: {e}")

# Create threads and start the load test
threads = []
for _ in range(num_requests):
    thread = threading.Thread(target=make_request)
    threads.append(thread)
    thread.start()

# Wait for all threads to finish
for thread in threads:
    thread.join()

# Analyze the results
success_count = results.count(200)
error_count = num_requests - success_count

print(f"Total requests: {num_requests}")
print(f"Successful requests: {success_count}")
print(f"Requests with error: {error_count}")
