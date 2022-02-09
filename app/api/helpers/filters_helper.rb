module FiltersHelper
  extend Grape::API::Helpers

  params :filters do
    optional :all, type: Boolean, desc: 'Вывести все включая завершенные'
  end
end
