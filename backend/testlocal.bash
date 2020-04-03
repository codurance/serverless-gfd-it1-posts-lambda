curl --write-out %{http_code} -k --silent --output /dev/null https://localhost:3001/dev/message | grep 200 &
curl https://localhost:3001/dev/message -k | grep  "Fake"
