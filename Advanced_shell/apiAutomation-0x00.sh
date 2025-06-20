#!/bin/bash

api_url="https://pokeapi.co/api/v2/pokemon/"

curl "$api_url" -o data.json 2>> error.txt

if [ $? -eq 0 ]; then
    echo "Users fetched successfully"
else
    echo "$(date): API request failed" >> errors.txt
    echo "Failed to fetch users from the API"
fi