class FakeController < ApplicationController

  def data
    result = FakeApi::Handler.handle(request.method, path: params[:path], params: params, headers: request.headers)

    respond_to do |format|
      format.html { render plain: result.inspect }
      format.xml  { render xml: result }
      format.json { render json: result }
      format.js   { render js: result }
    end
  end
  
end