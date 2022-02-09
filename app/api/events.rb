module ParamsHelper
  extend Grape::API::Helpers

  params :filters do
    optional :all,
             type: Boolean,
             desc: 'весь список, включая завершенные'
  end
end

module FiltersHelper
  extend Grape::API::Helpers

  def events_scope(all)
    scope = Event.order(:id)
    all ? scope : scope.where(done: false)
  end
end

class Events < Grape::API
  helpers FiltersHelper, ParamsHelper

  resource :events do
    desc 'Список дел'
    params do
      use :filters
    end
    get '/' do
      present events_scope(params[:all]), with: Entities::EventIndex
    end

    route_param :event_id, type: Integer do
      before do
        @event = Entities::Event.find params[:event_id]
      end

      get '/' do
        present @event, with: Entities::Event
      end

      post '/' do
        @event.destroy
      end
    end
  end
end
