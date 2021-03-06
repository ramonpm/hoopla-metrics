require 'faraday'
require 'faraday_middleware'

class HooplaClient
  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']
  PUBLIC_API_ENDPOINT = 'https://api.hoopla.net'

  LIST_METRICS_PATH = '/metrics'
  LIST_USERS_PATH = '/users'
  LIST_METRIC_VALUES_PATH = '/values'

  METRIC_VALUE_CONTENT_TYPE = 'application/vnd.hoopla.metric-value+json'

  def initialize
    descriptor
  end

  def self.hoopla_client
    @@hoopla_client_singleton ||= HooplaClient.new
  end

  def get(relative_url, options)
    response = client.get(relative_url, headers: options)
    if response.status == 200
      JSON.parse(response.body)
    else
      raise StandardError('Invalid response from ')
    end
  end

  def post(relative_url, payload, options)
    response = client.post(relative_url, payload, options)
    if response.status == 201
      JSON.parse(response.body)
    else
      raise StandardError('Invalid response from')
    end
  end

  def put(relative_url, payload, options)
    response = client.post(relative_url, payload, options)
    if response.status == 200
      JSON.parse(response.body)
    else
      raise StandardError('Invalid response from')
    end
  end

  def get_relative_url(link)
    descriptor['links'].find { |l| l['rel'] == link }['href'].delete_prefix descriptor['href']
  end

  def list_metrics(options = nil)
    get(LIST_METRICS_PATH, options)
  end

  def list_users(options = nil)
    get(LIST_USERS_PATH, options)
  end

  def list_metric_values_of(metric_href, options = nil)
    get(metric_href + LIST_METRIC_VALUES_PATH, options)
  end

  def create_metric_value(metric_href, payload)
    metric_values_path = metric_href + LIST_METRIC_VALUES_PATH
    post(metric_values_path, payload.to_json, {'Content-Type' => METRIC_VALUE_CONTENT_TYPE})
  end

  def update_metric_value(metric_href, payload)
    metric_values_path = metric_href + LIST_METRIC_VALUES_PATH
    put(metric_values_path, payload.to_json, {'Content-Type' => METRIC_VALUE_CONTENT_TYPE})
  end

  private

  def connection
    @conn ||= Faraday.new(url: PUBLIC_API_ENDPOINT) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth CLIENT_ID, CLIENT_SECRET
    end
  end

  def login
    response = connection.post('oauth2/token') do |req|
      if @refresh_token
        req.params['grant_type'] = 'refresh_token'
        req.params['refresh_token'] = @refresh_token
      else
        req.params['grant_type'] = 'client_credential'
      end
    end

    if response.status == 200
      json_resp = JSON.parse(response.body)
      @token = json_resp['access_token']
      @refresh_token = json_resp['refresh_token']
    else
      if (@token.nil? && @refresh_token.nil?)    # Nothing to retry
        raise ActiveResource::UnauthorizedAccess
      else
        @token = nil
        @refresh_token = nil
      end
    end
    @token
  end

  def token
    if !@token
      login

      if !@token # login failed
        login
      end

      # Either it's succeeded or raised an execption
    end
    @token
  end

  def client
    @client ||= Faraday.new(url: PUBLIC_API_ENDPOINT) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.use FaradayMiddleware::EncodeJson
      faraday.authorization :Bearer, token
    end
  end

  def parse_response(verb, url, response)
    if [200, 201].include? response.status
      JSON.parse(response.body)
    else
      raise StandardError('Invalid response from #{verb} #{url}: #{response.status}: #{response.body')
    end
  end

  def descriptor
    descriptor_url = PUBLIC_API_ENDPOINT
    @descriptor ||= self.get(descriptor_url, {'Accept' => 'application/vnd.hoopla.api-descriptor+json'})
  end
end
