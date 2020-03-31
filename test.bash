curl --write-out %{http_code} --silent --output /dev/null https://b1776kqi2k.execute-api.us-east-1.amazonaws.com/dev/message | grep 200 &
curl https://b1776kqi2k.execute-api.us-east-1.amazonaws.com/dev/message | grep  "Fake"
