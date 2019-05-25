module.exports.handler = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({
      input: event,
    })
  }
}

aws lambda invoke --region=us-east-1 --function-name=hello-ynap "{}"
