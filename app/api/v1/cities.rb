module V1
  class Cities < Grape::API
    helpers V1::SharedParams

    resources :cities do
      get "" do
        cities = City.all

        wrapper(cities)
      end

      desc "创建城市"
      params do
        group :city, type: Hash do
          requires :name, desc: "城市名称"
          optional :pinyin, desc: "城市拼音"
        end
      end
      post "" do
        status 200

        permitted_params = ActionController::Parameters.new(params).require(:city).permit!

        result = City.new(permitted_params).save

        wrapper(result)
      end
    end
  end
end