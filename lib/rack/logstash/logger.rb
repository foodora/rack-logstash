module Rack::Logstash
  class Logger
    def initialize(app, *args)
      @app = app
      log_file_path = 'log/access.log'
      additional_data = {}
      unless args.nil?
        if args.first.is_a? String
          log_file_path = args.first
          unless args.second.nil?
            raise ArgumentError.new 'Second argument needs to be a Hash.' unless args.second.is_a? Hash
            additional_data
          end
        elsif args.first.is_a? Hash
          additional_data = args.first
        else
          raise ArgumentError.new 'First argument needs to be a String or a Hash.'
        end
      end

      log_file = File.open(log_file_path, 'a')
      log_file.sync = true
      logger = ::Logger.new(log_file)
      logger.formatter = proc do |severity, datetime, _, data|
        body = {
            :'@timestamp' => datetime.iso8601,
            :'@version' => '1',
            :severity => severity
        }.merge!(additional_data).merge!(format(data))
        body.delete_if { |_key, value| value.nil? }
        body.to_json
      end
      @logger = logger
    end

    def call(env)
      began_at = Time.now
      status, header, body = @app.call(env)
      header = Rack::Utils::HeaderHash.new(header)
      body = Rack::BodyProxy.new(body) { log(env, status, header, began_at) }
      [status, header, body]
    end

    private

    def log(env, status, header, began_at)
      payload = {
          host: env['HTTP_HOST'],
          status: status,
          method: env['REQUEST_METHOD'],
          duration: ((Time.now - began_at) * 1000).round(2),
          db: Thread.current[:grape_db_runtime].round(2) || 0,
          path: env['PATH_INFO'],
          params: env['QUERY_STRING'],
          ip: env['HTTP_X_FORWARDED_FOR'] || env["REMOTE_ADDR"] || '-'
      }

      if status >= 400
        @logger.error payload
      else
        @logger.info payload
      end
    end

    def format(data)
      if data.is_a?(Hash)
        data
      elsif data.is_a?(String)
        { message: data }
      elsif data.is_a?(Exception)
        format_exception(data)
      else
        { message: data.inspect }
      end
    end
  end
end
