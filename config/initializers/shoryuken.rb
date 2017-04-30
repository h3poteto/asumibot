sqs_client = Aws::SQS::Client.new(
  endpoint: ENV["AWS_SQS_ENDPOINT"] || "http://localhost:4568",
  raise_response_errors: false
)
queues = sqs_client.list_queues
if queues.successful?
  [Settings.sqs.queue.patient].each do |shoryuken_queue|

    # queues.queue_urlsは
    # "http://0.0.0.0:4568/asumibot-patient-queue"
    # というstringが返ってくるので、比較のためにpathを抜き出す
    unless queues.queue_urls.map{|q| URI.parse(q).path }.any?{|p| /.*#{shoryuken_queue}/ =~ p }
      new_queue = sqs_client.create_queue(queue_name: shoryuken_queue)
      if new_queue
        Rails.logger.info "#{new_queue.queue_url}を作成しました"
      else
        Rails.logger.error "#{sqs_client.config.endpoint}/#{shoryuken_queue}の作成に失敗しました"
      end
    end
  end
end

Shoryuken.configure_client do |config|
  config.sqs_client = Aws::SQS::Client.new(
    endpoint: ENV["AWS_SQS_ENDPOINT"] || "http://localhost:4568"
  )
  config.sqs_client_receive_message_opts = {
    attribute_names: [
      "ApproximateReceiveCount",
      "SentTimestamp"
    ]
  }
  config.add_queue(Settings.sqs.queue.patient)
end

Shoryuken.configure_server do |config|
  config.sqs_client = Aws::SQS::Client.new(
    endpoint: ENV["AWS_SQS_ENDPOINT"] || "http://localhost:4568"
  )
  config.add_queue(Settings.sqs.queue.patient)
end
