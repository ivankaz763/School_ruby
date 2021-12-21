require 'json'
require 'net/http'

module VK_api_client

    class API

        attr_reader :access_token, :api_version, :timeout
  
        def initialize(access_token = nil, api_version = '5.131', timeout = 60)
            @access_token = access_token
            @api_version = api_version
            @timeout = timeout
        end
  
        private
        def method_missing(api_method, *api_params)
            api_method_for_request = api_method.to_s.split('_').join('.')
            api_response = request_creator(api_method_for_request, *api_params)
            raise VK_api_client::API::Error_api.new(api_method_for_request, api_response['error']['error_code'], api_response['error']['error_msg'], api_params).message if api_response['error']
            api_response['response']
        end

        def request_creator(api_method_for_request, params = {})
            params.merge!(access_token: @access_token,  v: @api_version, https: '1')
            url = "https://api.vk.com/method/#{api_method_for_request}"
            response_from_api = make_request(url, params)
            JSON.parse(response_from_api.body)
        end
    
        def make_request(url, params)
            uri = URI(url)
            use_ssl = uri.scheme == 'https'
            request = Net::HTTP::Post.new(uri)
            request.form_data = params
            Net::HTTP.start(uri.hostname, uri.port, use_ssl: use_ssl, read_timeout: @timeout, open_timeout: @timeout) { |http| http.request(request) }
        end

        class Error_api < StandardError
            attr_reader :api_method, :error_code, :error_msg, :params
    
            def initialize(api_method, error_code, error_msg, params)
                @api_method = api_method
                @error_code = error_code.to_i
                @error_msg = error_msg
                @params = params
            end
    
            def message
                "When we calling '#{@api_method}' with parametrs '#{@params.inspect}' VK return error #{@error_code}: '#{@error_msg}'"
            end
        end
    end
end

api = VK_api_client::API.new('6df71ec91de1b546e9d8e5189cc05d84ce38f0d3cb4dad57d09cd5ea0abda9a97f86ce6efcbf49d87097e')
# возвращает информацию о пользователе
puts api.users_get(user_ids: '210700286')
# возвращает ошибка потому, что для вызова метода "getFollowers" нужна авторизация не по сообществу, а по странице
api.users_getFollowers(user_ids: '210700286')
