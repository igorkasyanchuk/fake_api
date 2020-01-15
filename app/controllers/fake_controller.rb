class FakeController < ApplicationController

  def data
    result = FakeApi.handle(request.method, path: params[:path], params: params, headers: request.headers)

    respond_to do |format|
      format.html { render plain: result.inspect }
      format.json { render json: result }
      format.xml  { render xml: result }
    end
  end
  
end