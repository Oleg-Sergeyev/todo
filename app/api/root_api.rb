# class RootApi
class RootApi < Grape::API
  #helpers FiltersHelper, EventsHelper

  format :json
  prefix :api

  #mount Events

  #mount Events

  #helpers do
    # def events_scope(all)
    #   scope = Event.order(:id)
    #   all ? scope : scope.where(done: false)
    # end

    # params :filters do
    #   optional :all, type: Boolean, desc: 'Вывести все включая завершенные'
    # end

  #end

  # resource :events do
  #   desc 'Список дел'
  #   params do
  #     use :filters
  #   end
  #   get '/' do
  #     events_scope(params[:all])
  #   end

  #   route_param :event_id, type: Integer do
  #     before do
  #       @event = Event.find params[:event_id]
  #     end
  #     get '/' do
  #       @event 
  #     end

  #     post '/' do
  #       @event.destroy
  #     end
  #   end
  # end
end
