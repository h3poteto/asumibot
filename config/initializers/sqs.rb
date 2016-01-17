sqs_client = Aws::SQS::Client.new(
  endpoint: ENV["AWS_SQS_ENDPOINT"] || "http://localhost:4568",
  secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"] || "secret access key",
  access_key_id: ENV["AWS_ACCESS_KEY_ID"] || "access key id",
  region: ENV["AWS_REGION"] || "region"
)
begin
  sqs_client.create_queue(queue_name: Settings.sqs.queue.patient)
rescue
  puts "SQSに接続できません"
end
