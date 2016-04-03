sqs_client = Aws::SQS::Client.new(
  endpoint: ENV["AWS_SQS_ENDPOINT"] || "http://localhost:4568",
  secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"] || "secret access key",
  access_key_id: ENV["AWS_ACCESS_KEY_ID"] || "access key id",
  region: ENV["AWS_REGION"] || "region"
)
queues = sqs_client.list_queues
if queues.successful?
  Settings.sqs.queue.to_a.each do |key, value|
    # queues.queue_urlsは
    # "http://0.0.0.0:4568/asumibt-patient-queue"
    # というstringが返ってくるので、比較のためにpathを抜き出す
    unless queues.queue_urls.map{|q| URI.parse(q).path }.include?("/#{value}")
      new_queue = sqs_client.create_queue(queue_name: value)
      if new_queue
        Rails.logger.info "#{new_queue.queue_url}を作成しました"
      else
        Rails.logger.error "#{sqs_client.config.endpoint}/#{value}の作成に失敗しました"
      end
    end
  end
  Shoryuken::EnvironmentLoader.load(config_file: "config/shoryuken.yml", logfile: "log/shoryuken.log")
end

