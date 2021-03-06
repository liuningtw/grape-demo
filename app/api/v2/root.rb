require 'grape-swagger'

module V2
  class Root < Grape::API
    helpers V2::Helpers
    use V2::Middleware::PostMiddleware

    version 'v2'
    format :json
    content_type :json, "application/json;charset=UTF-8"
    formatter :json, Grape::Formatter::Jbuilder

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    mount Provinces
    mount Cities

    add_swagger_documentation base_path: "/api", api_version: 'v2', mount_path: 'doc', markdown: GrapeSwagger::Markdown::KramdownAdapter
  end
end
